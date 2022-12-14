import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/pages/payment_page.dart';
import 'package:jumbo_app_flutter/widgets/basket/barcode_scanner.dart';
import 'package:jumbo_app_flutter/widgets/basket/basket_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/allergen.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';
import 'package:jumbo_app_flutter/widgets/loading_dialog.dart';
import 'package:jumbo_app_flutter/widgets/products/product_alert.dart';
import 'package:jumbo_app_flutter/widgets/appbar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final ProductService productService = ProductService();
  final Basket basket = Basket();
  late Product product;
  late List<Allergen> warnings;

  final PanelController panelController = PanelController();
  bool isScanning = false;

  _checkBarcode(code) async {
    _onLoading();
    isScanning = false;

    Product? scannedProduct = await productService.scan(code);

    if (!mounted) return;
    Navigator.of(context).pop(); // removes loading dialog

    if (scannedProduct == null) {
      _setScanning(true);
      return;
    }

    product = scannedProduct;
    warnings = productService.getWarnings(product);

    if (warnings.isNotEmpty) {
      _onProductAlert();
      return;
    }

    _successFeedback();
    _addToBasket(product);
    _setScanning(true);
  }

  _onProductAlert() async {
    _errorFeedback();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductAlert(
          product,
          warnings,
          _callbackAdd,
          _callbackCancel,
        );
      },
    );
  }

  _onLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const LoadingDialog();
      },
    );
  }

  _successFeedback() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/scanned.mp3'));
    FeedbackType type = FeedbackType.medium;
    Vibrate.feedback(type);
  }

  _errorFeedback() async {
    final player = AudioPlayer();
    await player.play(AssetSource('sounds/warning.mp3'));
    FeedbackType type = FeedbackType.warning;
    Vibrate.feedback(type);
  }

  _addToBasket(Product product) {
    setState(() {
      basket.addProduct(product);
    });
  }

  _removeFromBasket(Product product) {
    setState(() {
      basket.removeProduct(product);
    });
  }

  _callbackAdd(Product product) {
    _addToBasket(product);
    _setScanning(true);
  }

  _callbackCancel() {
    _setScanning(true);
  }

  _onPay() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PaymentPage(),
      ),
    );
  }

  _setScanning(bool value) {
    if (isScanning && !value) {
      isScanning = value;
      CameraController.instance.pauseDetector();
    } else if (!isScanning && value) {
      isScanning = value;
      CameraController.instance.resumeDetector();
    }
  }

  @override
  Widget build(BuildContext context) {
    var availableHeight = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    if (Platform.isIOS) {
      // padding bottom seems to be 0.0 on iOS, so - 40 for correct sizing
      availableHeight += -40;
    }

    final panelHeight = availableHeight;
    final cameraHeight = availableHeight / 2;

    return Scaffold(
      appBar: CustomAppBar(
          leading: "Your",
          pageName: "Basket",
          amount: basket.getAmount(),
          appBar: AppBar()),
      body: SlidingUpPanel(
        controller: panelController,
        defaultPanelState: PanelState.OPEN,
        maxHeight: panelHeight,
        minHeight: cameraHeight,
        parallaxEnabled: false,
        body: Column(
          children: [
            SizedBox(
              height: cameraHeight,
              child: BarcodeScanner(_checkBarcode),
            ),
          ],
        ),
        panelBuilder: (scrollController) => BasketPanel(
          basket,
          panelController,
          scrollController,
          _addToBasket,
          _removeFromBasket,
          _onPay,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        onPanelClosed: () {
          _setScanning(true);
        },
        onPanelOpened: () {
          _setScanning(false);
        },
      ),
    );
  }
}

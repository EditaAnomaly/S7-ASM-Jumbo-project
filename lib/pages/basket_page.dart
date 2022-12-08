import 'package:flutter/material.dart';
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

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final ProductService productService = ProductService();
  final Basket basket = Basket();
  late Product scannedProduct;
  late List<Allergen> warnings;

  final PanelController panelController = PanelController();
  bool isScanning = false;

  _checkBarcode(code) async {
    _onLoading();
    isScanning = false;

    scannedProduct = await productService.scan(code);
    warnings = productService.getWarnings(scannedProduct);

    if (!mounted) return;
    Navigator.of(context).pop(); // removes loading dialog

    if (warnings.isEmpty) {
      _addToBasket(scannedProduct);
      _setScanning(true);
      return;
    }

    _onProductAlert();
  }

  _onProductAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductAlert(
          scannedProduct,
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
    print("pay");
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
    final availableHeight = MediaQuery.of(context).size.height -
        kBottomNavigationBarHeight -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        40; // padding bottom seems to be 0.0 on iOS, so - 40 for correct sizing

    final panelHeight = availableHeight;
    final cameraHeight = availableHeight / 2;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "Basket",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 24.0),
            ),
            Text(
              " (${Basket.items.length.toString()})",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 24.0,
                color: Colors.grey,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
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

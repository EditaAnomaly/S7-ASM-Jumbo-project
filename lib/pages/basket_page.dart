import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/allergen.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';
import 'package:jumbo_app_flutter/widgets/loading_dialog.dart';
import 'package:jumbo_app_flutter/widgets/products/price_text.dart';
import 'package:jumbo_app_flutter/widgets/products/product_alert.dart';
import 'package:jumbo_app_flutter/widgets/products/basket_list.dart';
import 'package:jumbo_app_flutter/widgets/products/empty_basket.dart';

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
  late CameraController cameraController = CameraController.instance;
  final PanelController panelController = PanelController();
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 315.0;

  _checkBarcode(code) async {
    _onLoading();

    scannedProduct = await productService.scan(code);
    warnings = productService.getWarnings(scannedProduct);

    if (!mounted) return;
    Navigator.of(context).pop();

    if (warnings.isEmpty) {
      _addToBasket(scannedProduct);
      Future.delayed(
          const Duration(milliseconds: 1400), () => _resumeScanning());
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
        });
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
    _resumeScanning();
  }

  _callbackCancel() {
    _resumeScanning();
  }

  _resumeScanning() {
    cameraController.resumeDetector();
  }

  _pauseScanning() {
    cameraController.pauseDetector();
  }

  @override
  Widget build(BuildContext context) {
    // calculates height minus safe area (could be replaced with SafeArea).
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        5;
    _panelHeightOpen = availableHeight;
    final bodyHeight = availableHeight - 270;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            controller: panelController,
            defaultPanelState: PanelState.OPEN,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: false,
            body: _body(bodyHeight),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
            onPanelClosed: () {
              _resumeScanning();
            },
            onPanelOpened: () {
              _pauseScanning();
            },
          ),
          Positioned(
              top: 0,
              child: ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.transparent,
                      )))),
        ],
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Scaffold(
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 12.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Basket",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                    )),
                Text(" (${Basket.items.length.toString()})",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                      color: Colors.grey,
                    )) // counts per product only.
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            if (Basket.items.isEmpty) ...[
              EmptyBasket(),
            ] else ...[
              Expanded(
                child: BasketList(
                    sc, Basket.items, _addToBasket, _removeFromBasket),
              ),
            ],
            const SizedBox(
              height: 54.0,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            panelController.close();
            _resumeScanning();
          },
          backgroundColor: const Color(0xffEEB717),
          tooltip: 'Scan',
          foregroundColor: Colors.black,
          child: const Icon(Icons.qr_code_scanner_rounded),
        ),
        bottomNavigationBar: Container(
            color: Colors.white,
            child: ButtonTheme(
                minWidth: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.fromLTRB(20, 10, 20, 10)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffEEB717)),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(50.0)))),
                        onPressed: () => print("Pressed Pay. "),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Text("Pay total",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w500)),
                            Container(
                              height: 27,
                              child: PriceText(basket.getTotal()),
                            ),
                          ],
                        ))))),
      ),
    );
  }

  Widget _body(bodyHeight) {
    return Column(
      children: [
        SizedBox(
          height: bodyHeight,
          width: double.infinity,
          child: Expanded(
            child: BarcodeCamera(
              types: const [
                BarcodeType.ean8,
                BarcodeType.ean13,
              ],
              resolution: Resolution.hd720,
              framerate: Framerate.fps30,
              mode: DetectionMode.pauseDetection,
              position: CameraPosition.back,
              onScan: (code) => {
                _checkBarcode(code.value),
              },
              children: const [
                MaterialPreviewOverlay(
                  animateDetection: false,
                  aspectRatio: 16.0 / 11.0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

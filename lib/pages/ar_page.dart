import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:jumbo_app_flutter/models/allergen.dart';
import 'package:jumbo_app_flutter/models/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';
import 'package:jumbo_app_flutter/widgets/product_alert.dart';
import 'package:jumbo_app_flutter/widgets/product_alert copy.dart';

import 'package:fast_barcode_scanner/fast_barcode_scanner.dart';

class ArViewPage extends StatefulWidget {
  const ArViewPage({super.key});
  @override
  State<ArViewPage> createState() => _ArViewPageState();
}

class _ArViewPageState extends State<ArViewPage> {
  final ProductService productService = ProductService();
  late Product product;
  late List<Allergen> warnings;
  final List<Product> basket = [];
  late CameraController cameraController;
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 315.0;

  @override
  Widget build(BuildContext context) {
    // calculates height minus safe area
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
            defaultPanelState: PanelState.OPEN,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: false,
            body: _body(bodyHeight),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18.0),
                topRight: Radius.circular(18.0)),
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
                Text(" (${basket.length.toString()})",
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
                      color: Colors.grey,
                    ))
              ],
            ),
            const SizedBox(
              height: 18.0,
            ),
            Expanded(
              // Basket List starts here
              child: ListView(controller: sc, children: <Widget>[
                if (basket.isEmpty) ...[
                  const Center(child: Text('nothing in basket')),
                ] else ...[
                  const Divider(
                    color: Colors.grey,
                    height: 0,
                    thickness: 0.3,
                  ),
                  for (product in basket)
                    Row(children: <Widget>[
                      Container(
                          margin: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          height: MediaQuery.of(context).size.height / 30,
                          width: MediaQuery.of(context).size.width / 5,
                          decoration: const BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                    width: 1,
                                    color: Color(0xffEEB717),
                                    style: BorderStyle.solid),
                                bottom: BorderSide(
                                    width: 1,
                                    color: Color(0xffEEB717),
                                    style: BorderStyle.solid),
                                left: BorderSide(
                                    width: 1,
                                    color: Color(0xffEEB717),
                                    style: BorderStyle.solid),
                                right: BorderSide(
                                    width: 1,
                                    color: Color(0xffEEB717),
                                    style: BorderStyle.solid),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          child: const Center(
                            child: Text('1'),
                          )),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child:
                            Image.network(product.image, height: 30, width: 30),
                      ),
                      Flexible(child: Text(product.title)),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                        child: Text(product.price.toString()),
                      ),
                    ]),
                  const Divider(
                    color: Colors.grey,
                    height: 0,
                    thickness: 0.3,
                  )
                ]
              ]), // End Basket List
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // onPressed: _openBarcodeScanner, // should also close panel
          onPressed: () {
            print("pressed fab");
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
                          children: const [
                            Text("Pay", style: TextStyle(fontSize: 19)),
                            Text("€0.00", style: TextStyle(fontSize: 19))
                          ],
                        ))))),
      ),
    );
  }

  _checkBarcode(code, cameraController) async {
    product = await productService.scan(code);
    warnings = productService.getWarnings(product);

    if (warnings.isEmpty) {
      _addProductToBasket(product);
      Future.delayed(
          const Duration(milliseconds: 1400), () => _resumeScanning());
      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProductAlertCopy(
            product,
            warnings,
            _callbackAdd,
            _callbackCancel,
          );
        });
  }

  _addProductToBasket(Product product) {
    setState(() {
      basket.add(product);
    });
  }

  _callbackAdd(Product product) {
    _addProductToBasket(product);
    _resumeScanning();
  }

  _callbackCancel() {
    _resumeScanning();
  }

  _resumeScanning() {
    cameraController.resumeDetector();
  }

  Widget _body(bodyHeight) {
    cameraController = CameraController.instance;

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
                _checkBarcode(code.value, cameraController),
              },
              children: const [
                MaterialPreviewOverlay(
                    animateDetection: false, aspectRatio: 16.0 / 11.0),
                // BlurPreviewOverlay(),
                // Positioned(
                //   bottom: 35,
                //   left: 0,
                //   right: 0,
                //   child: Column(
                //     children: const [
                //       Text("Tooltip"), // Add tooltip for scan feedback?
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// TODO: 
// - Merge develop into this branch.
// - Slider up = disabled camera, slider down = enabled camera.
// - FAB functionality: slide down basket on press.
// - (opt) Tooltip after successfully adding item to basket,
//      and/or animate MaterialPreviewOverlay (https://m2.material.io/design/machine-learning/barcode-scanning.html#usage).
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:jumbo_app_flutter/models/allergen.dart';
import 'package:jumbo_app_flutter/models/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';
import 'package:jumbo_app_flutter/widgets/product_alert.dart';

class ArViewPage extends StatefulWidget {
  const ArViewPage({super.key});
  @override
  State<ArViewPage> createState() => _ArViewPageState();
}

class _ArViewPageState extends State<ArViewPage> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 320.0;

  final ProductService productService = ProductService();
  late Product product;
  late List<Allergen> warnings;
  final List<Product> basket = [];

  _openBarcodeScanner() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.BARCODE);

    product = await productService.scan(barcodeScanRes);
    warnings = productService.getWarnings(product);

    if (warnings.isEmpty) {
      _addToBasket(product);

      return;
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProductAlert(
            product,
            warnings,
            _addToBasket,
          );
        });
  }

  _addToBasket(Product product) {
    setState(() {
      basket.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    // calculates height minus safe area
    final availableHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        5;
    _panelHeightOpen = availableHeight;

    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            defaultPanelState: PanelState.OPEN,
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: false,
            body: _body(),
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
              children: const [
                Text("Shopping basket",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 24.0,
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
              height: 24,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openBarcodeScanner, // should also close panel
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

  Widget _body() {
    return const Center(child: Text("hello :)")); // add AR camera here.
  }
}

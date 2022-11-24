import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:jumbo_app_flutter/models/allergen.dart';
import 'package:jumbo_app_flutter/models/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';
import 'package:jumbo_app_flutter/widgets/product_alert.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});
  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openBarcodeScanner,
        backgroundColor: const Color(0xffEEB717),
        tooltip: 'Scan',
        foregroundColor: Colors.black,
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
      body: ListView(children: <Widget>[
        if (basket.isEmpty) ...[
          const Text('nothing in basket'),
        ] else ...[
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
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: const Center(
                    child: Text('1'),
                  )),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Image.network(product.image, height: 30, width: 30),
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
      ]),
    );
  }
}

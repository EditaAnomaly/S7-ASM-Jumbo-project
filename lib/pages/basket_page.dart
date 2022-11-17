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

  _openBarcodeScanner() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.BARCODE);

    product = await productService.scan(barcodeScanRes);
    warnings = productService.getWarnings(product);

    if (warnings.isEmpty) return;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProductAlert(product, warnings);
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
      body: Row(children: <Widget>[
        Container(
          margin: const EdgeInsets.all(20),
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
          child: const Text('amount'),
        ),
        const Text('this is why i choose media...')
      ]),
    );
  }
}

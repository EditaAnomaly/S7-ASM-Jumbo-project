import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:jumbo_app_flutter/models/allergen.dart';
import 'package:jumbo_app_flutter/models/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';

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
    _alertAboutProduct(product, warnings);
  }

  _alertAboutProduct(Product product, List<Allergen> warnings) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Image(
                image: AssetImage('images/warningsmol.png'),
              ),
              SizedBox(height: 20),
              Text(
                'Product Warning',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                  'Pay attention! The Product contains the following dangerous ingredients:')
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 500,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: warnings.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(warnings[index].message));
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xffEEB717),
                //padding: const EdgeInsets.all(16.0),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Add anyway'),
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    width: 1.0,
                    color: Color(0xffEEB717),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
          actionsAlignment: MainAxisAlignment.spaceEvenly,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      // body
      floatingActionButton: FloatingActionButton(
        onPressed: _openBarcodeScanner,
        backgroundColor: const Color(0xffEEB717),
        tooltip: 'Scan',
        child: const Image(
          image: AssetImage('images/barcode.png'),
        ),
      ),
    );
  }
}

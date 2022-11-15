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
          shape: const Border(
              left: BorderSide(width: 6.0, color: Color((0xffEEB717)))),
          title: Column(
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
            //height: 400,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: warnings.length,
              itemBuilder: (context, index) {
                return Text(warnings[index].message,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold));
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xffEEB717),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Add anyway'),
            ),
            TextButton(
                style: OutlinedButton.styleFrom(
                  //padding: const EdgeInsets.symmetric(vertical: 8.0),
                  side: const BorderSide(
                    color: Color(0xffEEB717),
                  ),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child:
                    const Text('Cancel', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  Navigator.of(context).pop();
                })
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

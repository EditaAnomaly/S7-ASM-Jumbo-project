import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:jumbo_app_flutter/models/allergen.dart';
import 'package:jumbo_app_flutter/models/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Hello Lisa!'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Scan product'),
          ],
        ),
      ),
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

  _alertAboutProduct(Product product, List<Allergen> warnings) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(product.title),
          content: SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: warnings.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(warnings[index].message));
                },
              )),
          actions: [
            TextButton(
              child: const Text("Don't add"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add anyway'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

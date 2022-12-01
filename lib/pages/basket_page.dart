import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

  _openBarcodeScanner() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      "#000000",
      "Cancel",
      true,
      ScanMode.BARCODE,
    );

    _onLoading();

    scannedProduct = await productService.scan(barcodeScanRes);
    warnings = productService.getWarnings(scannedProduct);

    if (!mounted) return;
    Navigator.of(context).pop();

    if (warnings.isEmpty) {
      _addToBasket(scannedProduct);

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
          _addToBasket,
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
      body: Column(
        children: [
          if (Basket.items.isNotEmpty)
            Expanded(
              child: BasketList(Basket.items, _addToBasket, _removeFromBasket),
            ),
          if (Basket.items.isEmpty) EmptyBasket(),
          PriceText(basket.getTotal())
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/products/allergen.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';

class ProductAlert extends StatelessWidget {
  ProductAlert(
      this.product, this.warnings, this.callbackAdd, this.callbackCancel,
      {super.key});
  final Function(Product) callbackAdd;
  final Function callbackCancel;
  final ProductService productService = ProductService();
  final Product product;
  final List<Allergen> warnings;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
          const Border(left: BorderSide(width: 6.0, color: Color(0xffEEB717))),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Image(
            image: AssetImage('images/warningsmol.png'),
          ),
          SizedBox(height: 20),
          Text(
            'Product Warning',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'Pay attention! The Product contains the following dangerous ingredients:',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
      content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var warning in warnings)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(warning.message,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              )
          ]),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xffEEB717),
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: () {
            callbackAdd(product);
            Navigator.of(context).pop();
          },
          child: const Text('Add anyway'),
        ),
        TextButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color(0xffEEB717),
              ),
              textStyle: const TextStyle(fontSize: 20),
            ),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
            onPressed: () {
              callbackCancel();
              Navigator.of(context).pop();
            })
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

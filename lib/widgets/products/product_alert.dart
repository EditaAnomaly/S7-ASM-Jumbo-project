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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(
          width: 0.0,
          color: Colors.white,
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            product.image,
            height: 120,
            width: 110,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Image(
                image: AssetImage('images/warningsmol.png'),
                height: 20,
                width: 20,
              ),
              Container(
                margin: EdgeInsets.zero,
                child: const Text(
                  '   Product Warning',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            product.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text(
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
              child: Text(
                warning.message,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            callbackAdd(product);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor: const Color(0xffEEB717),
            foregroundColor: Colors.black,
          ),
          child: const Text('Add anyway'),
        ),
        OutlinedButton(
          onPressed: () {
            callbackCancel();
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            side: const BorderSide(
              color: Color(0xffEEB717),
            ),
            foregroundColor: Colors.black,
          ),
          child: const Text("Cancel"),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceEvenly,
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:jumbo_app_flutter/models/allergen.dart';
// import 'package:jumbo_app_flutter/models/product.dart';
// import 'package:jumbo_app_flutter/services/product.service.dart';

class BasketPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Basket Page',
          style: Theme.of(context).textTheme.headline3,
        ),
      ]),
    );
  }
}

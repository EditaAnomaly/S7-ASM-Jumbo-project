import 'package:flutter/material.dart';
// import 'package:jumbo_app_flutter/models/basket.dart';
// import 'package:jumbo_app_flutter/widgets/products/basket_item_cell.dart';

class EmptyBasket extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmptyBasketState();
}

class _EmptyBasketState extends State<EmptyBasket> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          margin: const EdgeInsets.all(35),
          child: const Image(image: AssetImage("images/basketempty.png"))),
      Container(
        margin: const EdgeInsets.all(15),
        child: const Text(
          "Your basket is empty",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
        ),
      ),
      const Text("Time to fill your basket."),
    ]);
  }
}

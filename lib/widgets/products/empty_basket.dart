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
    return ListView(
      children: <Widget>[
        Container(child: const Image(image: AssetImage("images/profile.png"))),
      ],
    );
  }
}

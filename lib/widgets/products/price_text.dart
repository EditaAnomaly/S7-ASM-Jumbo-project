import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/products/price.dart';

class PriceText extends StatefulWidget {
  final Price price;

  const PriceText(this.price, {super.key});

  @override
  State<StatefulWidget> createState() => _PriceTextState();
}

class _PriceTextState extends State<PriceText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.only(top: 2),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.price.getInteger(),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              height: 1.0,
            ),
          ),
          Text(
            widget.price.getFractional(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

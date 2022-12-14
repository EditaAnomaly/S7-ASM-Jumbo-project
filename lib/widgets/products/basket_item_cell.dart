import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/widgets/products/amount_widget.dart';
import 'package:jumbo_app_flutter/widgets/products/price_text.dart';

class BasketItemCell extends StatefulWidget {
  final BasketItem item;
  final Function(BasketItem, String) update;

  const BasketItemCell(this.item, this.update, {super.key});

  @override
  State<StatefulWidget> createState() => _BasketItemCellState();
}

class _BasketItemCellState extends State<BasketItemCell> {
  _changeAmount(String action) {
    widget.update(widget.item, action);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              AmountWidget(widget.item.amount, _changeAmount),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.network(
                  widget.item.product.image,
                  height: 60,
                  width: 50,
                ),
              ),
              Expanded(
                child: Text(widget.item.product.title),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: PriceText(widget.item.product.price),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.grey,
          height: 0,
          thickness: 0.3,
        ),
      ],
    );
  }
}

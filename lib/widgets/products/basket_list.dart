import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/widgets/products/basket_item_cell.dart';

class BasketList extends StatefulWidget {
  final ScrollController scrollController;
  final List<BasketItem> items;
  final Function(Product) add;
  final Function(Product) remove;

  const BasketList(this.scrollController, this.items, this.add, this.remove,
      {super.key});

  @override
  State<StatefulWidget> createState() => _BasketListState();
}

class _BasketListState extends State<BasketList> {
  _updateItemAmount(BasketItem item, String action) {
    if (action == "add") {
      widget.add(item.product);
    } else if (action == "remove") {
      widget.remove(item.product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: <Widget>[
        for (BasketItem item in widget.items)
          BasketItemCell(
            item,
            _updateItemAmount,
          ),
      ],
    );
  }
}

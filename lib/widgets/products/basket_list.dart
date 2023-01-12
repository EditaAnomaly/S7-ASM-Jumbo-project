import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/widgets/products/basket_item_cell.dart';
import 'package:jumbo_app_flutter/services/settings.service.dart';
import 'package:jumbo_app_flutter/widgets/products/empty_basket.dart';

class BasketList extends StatefulWidget {
  final ScrollController scrollController;
  final Function(Product) add;
  final Function(Product) remove;

  const BasketList({
    super.key,
    required this.scrollController,
    required this.add,
    required this.remove,
  });

  @override
  State<StatefulWidget> createState() => _BasketListState();
}

class _BasketListState extends State<BasketList> {
  _updateItemAmount(BasketItem item, String action) {
    if (SettingsService.isVibrationOn) {
      FeedbackType type = FeedbackType.medium;
      Vibrate.feedback(type);
    }
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
      children: [
        if (Basket.items.isNotEmpty) ...[
          for (BasketItem item in Basket.items)
            BasketItemCell(
              item,
              update: _updateItemAmount,
            ),
        ] else ...[
          const EmptyBasket()
        ],
      ],
    );
  }
}

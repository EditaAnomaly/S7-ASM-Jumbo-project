import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/shopping_list.dart';
import 'package:jumbo_app_flutter/pages/arkit_page.dart';
import 'package:jumbo_app_flutter/services/product.service.dart';
import 'package:jumbo_app_flutter/widgets/products/basket_item_cell.dart';
import 'package:jumbo_app_flutter/widgets/products/category_header.dart';

class ShoppingListWidget extends StatefulWidget {
  final ScrollController scrollController;

  const ShoppingListWidget({super.key, required this.scrollController});

  @override
  State<StatefulWidget> createState() => _ShoppingListWidgetState();
}

class _ShoppingListWidgetState extends State<ShoppingListWidget> {
  ProductService productService = ProductService();

  _navigateTo(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ARNavigationWidget(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.scrollController,
      children: [
        for (Category category in ShoppingList.categories) ...[
          CategoryHeader(
            category,
            _navigateTo,
          ),
          Column(
            children: [
              for (BasketItem item in category.items)
                BasketItemCell(
                  item,
                  hideAmount: true,
                ),
            ],
          ),
        ],
      ],
    );
  }
}

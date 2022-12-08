import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/widgets/basket/pay_total.dart';
import 'package:jumbo_app_flutter/widgets/basket/slider_indicator.dart';
import 'package:jumbo_app_flutter/widgets/products/basket_list.dart';
import 'package:jumbo_app_flutter/widgets/products/empty_basket.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BasketPanel extends StatelessWidget {
  const BasketPanel(this.basket, this.panelController, this.scrollController,
      this.addCallback, this.removeCallback, this.payCallback,
      {super.key});

  final Basket basket;
  final PanelController panelController;
  final ScrollController scrollController;
  final Function addCallback;
  final Function removeCallback;
  final Function payCallback;

  _add(Product product) {
    addCallback(product);
  }

  _remove(Product product) {
    removeCallback(product);
  }

  _pay() {
    payCallback();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 8),
            child: SliderIndicator(),
          ),
          if (Basket.items.isEmpty) ...[
            EmptyBasket(),
          ] else ...[
            Expanded(
              child: BasketList(
                scrollController,
                Basket.items,
                _add,
                _remove,
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          panelController.close();
        },
        backgroundColor: const Color(0xffEEB717),
        tooltip: 'Scan',
        foregroundColor: Colors.black,
        child: const Icon(Icons.qr_code_scanner_rounded),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        color: Colors.white,
        child: PayTotal(basket.getTotal(), _pay),
      ),
    );
  }
}

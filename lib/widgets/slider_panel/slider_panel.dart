import 'package:flutter/material.dart';
import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/pages/payment_page.dart';
import 'package:jumbo_app_flutter/widgets/slider_panel/pay_total.dart';
import 'package:jumbo_app_flutter/widgets/slider_panel/slider_indicator.dart';
import 'package:jumbo_app_flutter/widgets/products/basket_list.dart';
import 'package:jumbo_app_flutter/widgets/products/shopping_list_widget.dart';
import 'package:jumbo_app_flutter/widgets/slider_panel/floating_scan_button.dart';
import 'package:jumbo_app_flutter/widgets/slider_panel/panel_tab_bar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SliderPanel extends StatelessWidget {
  const SliderPanel(this.basket, this.panelController, this.scrollController,
      this.addCallback, this.removeCallback,
      {super.key});

  final Basket basket;
  final PanelController panelController;
  final ScrollController scrollController;
  final Function addCallback;
  final Function removeCallback;

  _add(Product product) {
    addCallback(product);
  }

  _remove(Product product) {
    removeCallback(product);
  }

  _togglePanel() {
    panelController.panelPosition.round() == 1
        ? panelController.close()
        : panelController.open();
  }

  @override
  Widget build(BuildContext context) {
    onPay() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentPage(),
        ),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(76),
          child: Column(
            children: [
              SliderIndicator(_togglePanel),
              const PanelTabBar(),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            BasketList(
              scrollController: scrollController,
              add: _add,
              remove: _remove,
            ),
            ShoppingListWidget(
              scrollController: scrollController,
            ),
          ],
        ),
        floatingActionButton: FloatingScanButton(
          onTap: () => panelController.close(),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          color: Colors.white,
          child: PayTotal(basket.getTotal(), onPay),
        ),
      ),
    );
  }
}

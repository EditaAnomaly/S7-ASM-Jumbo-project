import 'package:jumbo_app_flutter/models/products/price.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';

class Basket {
  static final List<BasketItem> items = [];

  Price getTotal() {
    int total = 0;
    for (BasketItem item in items) {
      total += item.product.price.amount * item.amount;
    }

    return Price(
      currency: "EUR",
      amount: total,
    );
  }

  int getAmount() {
    int amount = 0;
    for (BasketItem item in items) {
      amount += item.amount;
    }
    return amount;
  }

  BasketItem? findProduct(Product product) {
    int index = items.indexWhere((item) => item.product.id == product.id);
    return index >= 0 ? items[index] : null;
  }

  addProduct(Product product) {
    BasketItem? item = findProduct(product);

    if (item != null) {
      item.amount++;
      return;
    }

    items.add(BasketItem(1, product));
  }

  removeProduct(Product product) {
    BasketItem? item = findProduct(product);

    if (item == null) return;

    if (item.amount > 1) {
      item.amount--;
      return;
    }

    items.remove(item);
  }
}

class BasketItem {
  int amount;
  Product product;

  BasketItem(this.amount, this.product);
}

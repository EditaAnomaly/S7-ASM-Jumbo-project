import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/price.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';

class ShoppingList {
  static final List<Category> categories = [
    Category(
      name: "Sauzen",
      destination: "algorythm",
      [
        BasketItem(1, pindaSaus),
        BasketItem(1, knoflookSaus),
      ],
    ),
    Category(
      name: "Tomatenblokjes, -puree",
      destination: "algorythm",
      [
        BasketItem(2, tomatenBlokjes),
      ],
    )
  ];

  static int getAmount() {
    int amount = 0;
    for (Category category in categories) {
      for (BasketItem item in category.items) {
        amount += item.amount;
      }
    }
    return amount;
  }
}

class Category {
  List<BasketItem> items = [];
  String name;
  String destination;

  Category(
    this.items, {
    required this.name,
    required this.destination,
  });
}

final pindaSaus = Product(
  id: "148336ZK",
  image:
      'https://static-images.jumbo.com/product_images/261020220809_148336ZK-1_360x360.png',
  price: Price(currency: 'EUR', amount: 105),
  title: "Conimex Mix Pinda Satésaus 68g",
  quantity: "1",
);
final knoflookSaus = Product(
  id: "386260FLS",
  image:
      'https://static-images.jumbo.com/product_images/271120200355_386260FLS-1_360x360.png',
  price: Price(currency: 'EUR', amount: 89),
  title: "Jumbo Knoflook Saus 250ML",
  quantity: "1",
);
final tomatenBlokjes = Product(
  id: "218376DS",
  image:
      'https://static-images.jumbo.com/product_images/130920211704_218376DS-1_360x360.png',
  price: Price(currency: 'EUR', amount: 69),
  title: "Jumbo Tomatenblokjes 400g",
  quantity: "1",
);

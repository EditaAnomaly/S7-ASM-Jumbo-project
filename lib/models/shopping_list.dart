import 'package:jumbo_app_flutter/models/basket.dart';
import 'package:jumbo_app_flutter/models/products/price.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';

class ShoppingList {
  static final List<Category> categories = [
    Category(
      name: "Koek, snoep, chocolade en chips",
      destination: "algorythm",
      [
        BasketItem(1, chocolate),
        BasketItem(1, cookies),
      ],
    ),
    Category(
      name: "Fris, sap, koffie, thee",
      destination: "algorythm",
      [
        BasketItem(2, sparklingWater),
        BasketItem(1, juice),
        BasketItem(1, drinkMeal)
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

final chocolate = Product(
  id: "453487PAK",
  image:
      'https://static-images.jumbo.com/product_images/301120211324_453487PAK-1_360x360.png',
  price: Price(currency: 'EUR', amount: 213),
  title: "Hands Off My Chocolate Crunchy Hazelnut 100g",
  quantity: "1",
);
final cookies = Product(
  id: "305339ZK",
  image:
      'https://static-images.jumbo.com/product_images/290420210545_305339ZK-1_360x360.png',
  price: Price(currency: 'EUR', amount: 299),
  title: "BioToday Kokos-Citroenkoekjes 175g",
  quantity: "1",
);
final sparklingWater = Product(
  id: "363841BLK",
  image:
      'https://static-images.jumbo.com/product_images/270620200313_363841BLK-1_360x360.png',
  price: Price(currency: 'EUR', amount: 105),
  title:
      "Charlie's Organics Framboos & Limoen Bruisend Water & Geperst Fruit 330ml",
  quantity: "1",
);
final juice = Product(
  id: "498385PAK",
  image:
      'https://static-images.jumbo.com/product_images/180520221253_498385PAK-1_360x360.png',
  price: Price(currency: 'EUR', amount: 223),
  title: "DubbelFrisss Ananas & Mango 1, 5L",
  quantity: "1",
);
final drinkMeal = Product(
  id: "403879FLS",
  image:
      'https://static-images.jumbo.com/product_images/191120210708_403879FLS-1_360x360.png',
  price: Price(currency: 'EUR', amount: 365),
  title: "YFood Gebalanceerde Drinkmaaltijd Classic Choco 500ml",
  quantity: "1",
);

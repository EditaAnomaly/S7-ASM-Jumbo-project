import 'package:jumbo_app_flutter/models/ingredient.dart';
import 'package:jumbo_app_flutter/models/price.dart';

class Product {
  final String id;
  final String title;
  final Price price;
  final String quantity;
  final String image;
  final List<Ingredient> ingredients;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity,
      required this.image,
      required this.ingredients});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: Price.fromJson(json['prices']['price']),
      quantity: json['quantity'],
      image: json['imageInfo']['primaryView'][0]['url'],
      ingredients: List<Ingredient>.from(json['ingredientInfo'][0]
              ['ingredients']
          .map((ingredient) => Ingredient.fromJson(ingredient))),
    );
  }
}

import 'package:jumbo_app_flutter/models/products/ingredient.dart';
import 'package:jumbo_app_flutter/models/products/price.dart';
import 'package:jumbo_app_flutter/models/products/allergen.dart';

class Product {
  final String id;
  final String title;
  final Price price;
  final String quantity;
  final String image;
  late List<Ingredient> ingredients;
  late List<Allergen> allergens;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: Price.fromJson(json['prices']['price']),
      quantity: json['quantity'],
      image: json['imageInfo']['primaryView'][0]['url'],
    );
  }

  setIngredients(List<dynamic> ingredients) {
    this.ingredients = List<Ingredient>.from(
        ingredients.map((ingredient) => Ingredient.fromJson(ingredient)));
  }

  setAllergens(List<String> allergens) {
    this.allergens = List<Allergen>.from(
        allergens.map((allergy) => Allergen.fromString(allergy)));
  }
}

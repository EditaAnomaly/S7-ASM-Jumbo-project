import 'package:jumbo_app_flutter/models/products/allergen.dart';
import 'package:jumbo_app_flutter/models/products/product.dart';
import 'package:jumbo_app_flutter/services/preference.service.dart';
import 'api.service.dart';
import 'dart:convert';

class ProductService {
  final apiService = Api();

  Future<Product?> scan(barcode) async {
    var product = await fetchProduct(barcode);

    if (product == null) return null;

    await setMetaData(product);
    return product;
  }

  // FETCH PRODUCT USING EAN BARCODE <8718452461158>
  Future<Product?> fetchProduct(String barcode) async {
    final response = await apiService.get('search?q=$barcode');

    try {
      final json =
          jsonDecode(utf8.decode(response.bodyBytes))['products']['data'][0];
      return Product.fromJson(json);
    } catch (error) {
      return null;
    }
  }

  // SET INGREDIENTS AND ALLERGENS
  setMetaData(Product product) async {
    final response = await apiService.get('products/${product.id}');

    final json = jsonDecode(utf8.decode(response.bodyBytes))['product']['data'];

    product.setIngredients(json['ingredientInfo'][0]['ingredients']);
    product.setAllergens(json['allergyText'].split(','));
  }

  List<Allergen> getWarnings(Product product) {
    return product.allergens.where((allergen) {
      return PreferenceService.allergens.contains(allergen.allergen);
    }).toList();
  }
}

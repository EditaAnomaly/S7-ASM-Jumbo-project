import 'package:jumbo_app_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  Future<Product> fetchProduct(productId) async {
    final url = 'https://mobileapi.jumbo.com/v17/products/$productId';

    final headers = {
      "Accept": "application/json",
      "User-Agent": "Fontys team green"
    };

    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode != 200) throw Exception('Failed to load product');

    var jsonString =
        jsonDecode(utf8.decode(response.bodyBytes))['product']['data'];
    var product = Product.fromJson(jsonString);

    return product;
  }
}

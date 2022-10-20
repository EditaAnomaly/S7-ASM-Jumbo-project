import 'package:jumbo_app_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  final baseUrl = 'https://mobileapi.jumbo.com/v17/';
  final headers = {
    "Accept": "application/json",
    "User-Agent": "Fontys team green"
  };

  Future<Product> fetchProduct(barcode) async {
    final barcodeResponse = await getRequest('search?q=$barcode');
    final productId = jsonDecode(barcodeResponse.body)['products']['data'][0]
        ['id']; // 8718452461158

    final productResponse = await getRequest('products/$productId');
    var productString =
        jsonDecode(utf8.decode(productResponse.bodyBytes))['product']['data'];
    var product = Product.fromJson(productString);

    return product;
  }

  Future<http.Response> getRequest(source) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + source), headers: headers);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}

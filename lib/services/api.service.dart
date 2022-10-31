import 'package:http/http.dart' as http;

class Api {
  final baseUrl = 'https://mobileapi.jumbo.com/v17/';
  final headers = {
    "Accept": "application/json",
    "User-Agent": "Fontys team green"
  };

  Future<http.Response> get(source) async {
    try {
      final response =
          await http.get(Uri.parse(baseUrl + source), headers: headers);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}

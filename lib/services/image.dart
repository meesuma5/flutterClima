import 'dart:convert';

import 'package:http/http.dart' as http;

Future<dynamic> fetchCityImage(String cityName) async {
  final apiKey = 'Your API Key Here';
  final url =
      'https://api.unsplash.com/search/photos?query=$cityName&client_id=$apiKey';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final imageUrlList = data['results'];
    return imageUrlList;
  } else {
    throw Exception('Failed to load image');
  }
}

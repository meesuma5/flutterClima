import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> getWeatherMessage(dynamic weatherData) async {
  final apiKey = '4ac2a67318d7d6eb4e1559a961a9e63c75997faf6c11ad8c7304d5c1';
  final apiUrl = 'https://api.textrazor.com/';
  String jsonString = jsonEncode(weatherData);
  final body =
      'text=${Uri.encodeQueryComponent(jsonString)}&extractors=entities';

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'x-textrazor-key': apiKey,
    },
    body: body,
  );
  print(response.statusCode);
  print(response.body);

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse.containsKey('response')) {
      // Assuming you extract summar
      return jsonResponse['response']['entities']
          .map((entity) => entity['entityId'])
          .join(', ');
    } else {
      throw Exception(
          'Failed to summarize weather data: ${jsonResponse['message']}');
    }
  } else {
    throw Exception(
        'Failed to summarize weather data. Status code: ${response.statusCode}');
  }
}

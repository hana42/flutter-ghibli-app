import 'dart:convert';

import 'http_service.dart';
import 'package:http/http.dart' as http;

class HttpServiceImpl implements HttpService {
  @override
  Future<dynamic> get(String url) async {
    final defaultHeaders = ({'Content-type': 'application/json;charset=utf-8'});

    try {
      Future<http.Response> futureResponse =
          http.get(Uri.parse(url), headers: defaultHeaders);
      var response = await futureResponse.timeout(Duration(minutes: 10));

      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}

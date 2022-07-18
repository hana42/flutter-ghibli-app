// ignore: unused_import
import 'package:http/http.dart' as http;

abstract class HttpService {
  Future<dynamic> get(String url);
}

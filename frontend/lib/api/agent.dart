import 'package:http/http.dart' as http;

abstract class Agent {
  static Future<http.Response> get(String path) {
    return http.get(Uri.http("sstu.ru", "/$path"));
  }

  static Future<http.Response> post(String path, Object? body) {
    return http.post(Uri.http("sstu.ru", "/$path"), body: body);
  }
}

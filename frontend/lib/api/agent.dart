import 'package:http/http.dart' as http;
import 'package:sstu_event_app/exceptions/notfound.dart';

abstract class Agent {
  static Future<http.Response> get(String path) async {
    final response =
        await http.get(Uri.http("localhost:8080", "/api/$path"));

    if (response.statusCode == 404) {
      throw HttpNotFoundException(path);
    }
    return response;
  }

  static Future<http.Response> post(String path, Object? body) {
    return http.post(Uri.http("localhost:8080", "/api/$path"), body: body, headers: {"Content-Type": "application/json"});
  }
}

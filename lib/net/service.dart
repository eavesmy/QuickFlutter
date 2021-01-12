import 'http.dart';

class Service {
  Service._();

  static Future<Map<String,dynamic>> index() {
    return Http.request<Map<String,dynamic>>(
      path: '/movie/index',
      method: HttpMethod.POST,
    ).then((value) => new Map<String, dynamic>.from(value.data));
  }
}

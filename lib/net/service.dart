import 'http.dart';

class Service {
  Service._();

  static Future<List<String>> getAllProject() {
    return Http.request<List<String>>(
      path: '/all/projects',
      method: HttpMethod.GET,
    ).then((value) => value.data);
  }
}

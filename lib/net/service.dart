import 'http.dart';

/// CI 项目所需要的网络接口

class Service {
  Service._();

  /// 获取所有项目
  static Future<List<String>> getAllProject() {
    return CIHttp.request<List<String>>(
      path: '/all/projects',
      method: HttpMethod.GET,
    ).then((value) => value.data);
  }
}

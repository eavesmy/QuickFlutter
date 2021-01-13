import 'http.dart';
import 'http_config.dart';

class Service {
  Service._();
    
  // 获取 token

  // 获取首页内容
  static Future<Map<String,dynamic>> index({int page = 1, size = 20}) {
    return Http.request<Map<String,dynamic>>(
      path: '/movie/index',
      method: HttpMethod.POST,
      body: { 'page': page , 'size': size }
    ).then((value) => new Map<String, dynamic>.from(value.data));
  }

  // 登陆
  static Future<String> login(String token){
    return Http.request<String>(
        path: "/auth/login",
        method: HttpMethod.POST,
        baseUrl: HttpConfig.HTTP_AUTH_HOST,
        body: token,
      ).then((value) => value.data);
  }

  static Future<String> requestUrl(int id){
    return Http.request<String>(
        path: "/movie/video",
        method: HttpMethod.POST,
        body: { 'id': id }
      ).then((value) => value.data);
  }
}

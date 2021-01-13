import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';

import 'http_config.dart';

/// Http请求工具类

class Http {
  /// dio instance
  static final _defaultDio = Dio()
    ..options.baseUrl = HttpConfig.HTTP_HOST
    ..options.headers['Accept-Encoding'] = 'gzip, deflate'
    ..options.headers['Accept'] = '*/*'
    ..options.connectTimeout = Duration(seconds: 15).inMilliseconds
    ..options.receiveTimeout = Duration(seconds: 15).inMilliseconds
    ..options.sendTimeout = Duration(seconds: 15).inMilliseconds
    ..interceptors.add(Interceptor())
    ..transformer = _HttpTransformer();

  static Future<Response<T>> request<T>({
    Dio dio,
    @required String path,
    Map<String, String> pathParams,
    @required String method,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParams,
    body,
    String baseUrl,
  }) {
    assert(path != null && path.trim().isNotEmpty, '请求Path不能为空');
    assert(method != null && method.trim().isNotEmpty, '请求Method不能为空');

    final _response = (dio ?? _defaultDio).request<T>(
      fillPath(path, pathParams),
      data: body,
      queryParameters: queryParams,
      options: RequestOptions(
        method: method,
        headers: headers,
        baseUrl: baseUrl,
      ),
    );
    
    return _response.catchError((error, [StackTrace stackTrace]) {
      if (error is DioError) {
        throw error.message;
      }
    });
  }

  static String fillPath(String path, Map<String, dynamic> pathParams) {
    if (path != null && pathParams != null && pathParams.isNotEmpty) {
      pathParams.forEach((key, value) {
        path = path.replaceFirst("{$key}", value.toString());
      });
    }
    return path;
  }
}

class HttpMethod {
  HttpMethod._();

  static const String GET = "GET";
  static const String POST = "POST";
  static const String PATCH = "PATCH";
  static const String PUT = "PUT";
  static const String DELETE = "DELETE";
  static const String HEAD = "HEAD";
  static const String OPTIONS = "OPTIONS";
}

class ClientErrorCode {
  ClientErrorCode._();

  static const String BUSINESS_FAILED = "-100";
}

class _HttpTransformer extends DefaultTransformer {
  @override
  Future transformResponse(RequestOptions options, ResponseBody response) {
    print("""
-------------------- HTTP REQ --------------------
Url:${options.uri}
Method:${options.method}
Headers:${options.headers}
-------------------- HTTP RESP --------------------
Status:${response.statusCode}
Headers:${response.headers}""");

    if (response.statusCode < 200 || response.statusCode >= 400) {
      print("-------------------- HTTP END --------------------");
      return Future.error('Request failed:${response.statusCode}');
    }
    return super.transformResponse(options, response).then((value) {
      print("""Body:${JsonEncoder.withIndent('  ').convert(value)} 
-------------------- HTTP END --------------------""");
      return value;
      if (options.baseUrl == HttpConfig.HTTP_HOST && value is Map) {
        if (value['success'] == true) {
          return value['data'];
        } else {
          throw 'Request failed:${ClientErrorCode.BUSINESS_FAILED}';
        }
      } else {
        return value;
      }
    });
  }

  @override
  Future<String> transformRequest(RequestOptions options) {
    return super.transformRequest(options);
  }
}

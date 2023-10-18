import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Dio getDio() {
  // var uri = "http://192.168.1.187:9000/utcc-mini-project-mobile";
  // var uri = "http://172.20.10.3:9000/utcc-mini-project-mobile";
  var uri = "http://192.168.100.103:9000/utcc-mini-project-mobile";
  FlutterSecureStorage storageToken = new FlutterSecureStorage();
  var _dio = Dio();
  _dio.options.baseUrl = uri;
  _dio.options.responseType = ResponseType.json;
  _dio.options.connectTimeout = 30000;
  _dio.options.receiveTimeout = 30000;
  _dio.interceptors.clear();
  _dio.interceptors
      .add(InterceptorsWrapper(onRequest: (options, handler) async {
    log("PATH : ${uri + options.path}");
    if ((options.path != '/token/authenticate')) {
      final accessToken = await storageToken.read(key: 'jwttoken');
      if (accessToken != null && accessToken != '') {
        options.headers["Authorization"] = "Bearer " + accessToken;
        options.headers["User-Agent"] =
            "Mozilla/5.0 (iPhone; CPU iPhone OS 12_0_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/16A404";
      }
    }
    return handler.next(options);
  }, onResponse: (response, handler) {
    return handler.next(response); // continue
  }, onError: (error, handler) async {
    if ((error.response?.statusCode == 401) &&
        error.requestOptions.path != '/token/authenticate') {
      return handler.next(error); //continue
    }
    return handler.next(error); //continue
  }));

  return _dio;
}

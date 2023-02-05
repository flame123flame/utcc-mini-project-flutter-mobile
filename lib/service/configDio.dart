import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Dio getDio() {
  var uri = "http://baiwa.ddns.net:9440/utcc-api";
  // var uri = "http://192.168.203.22:9000/utcc-api";

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

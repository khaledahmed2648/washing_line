import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/functions.dart';
import 'package:washing_line/core/services/services.dart';

class Crud {
  static Dio dio = Dio(BaseOptions(
    connectTimeout: Duration(seconds: 10), // 5 seconds
    receiveTimeout: Duration(seconds: 10), // 5 seconds
  ));

  static postData(String url, Map<String, dynamic> data) async {
    var response = await dio.post(url,
        data: data,
        options:Options(headers: {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }

  static getData(String url, Map<String, dynamic> data) async {
    var response = await dio.get(url,
        data: data,
        options:Options(headers: {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }

  static deleteData(String url, Map<String, dynamic> data) async {
    var response = await dio.delete(url,
        queryParameters: data,
        options:Options(headers: {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
}

enum StatusRequest {
  loading,
  success,
  serverFailure,
  offlineFailure,
  failure,
  initialState
}
import 'package:dio/dio.dart';
import 'package:washing_line/app_api_links.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../core/class/curd_helper.dart';
import '../../../core/services/services.dart';

class LoginData {
  static postLoginData(
      {required String username, required String password}) async {
    var response = await http.post(Uri.parse(AppApiLinks.login).replace(queryParameters: {
    'username': username,
    'password': password,
    },));
    return response;
  }
}

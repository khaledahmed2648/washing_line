import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/functions.dart';
import 'package:washing_line/core/services/services.dart';
import 'package:washing_line/data/datasource/remote/login_data_source.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.initialState;

  postLogin() async {
    statusRequest = StatusRequest.loading;
    update();
    print('-=================done loading======================');

      var response = await LoginData.postLoginData(
          username: usernameController.text, password: passController.text);

      print('-=================done ======================');
      print(response.body);
      if (jsonDecode(response.body)['success'] == true) {
        print('in success');
        MyServices.sharedPreferences.setString(
            'id', (jsonDecode(response.body)['data']['id'].toString()));
        MyServices.sharedPreferences.setString(
            'username', jsonDecode(response.body)['data']['username']);
        MyServices.sharedPreferences
            .setString('name', jsonDecode(response.body)['data']['name']);
        MyServices.sharedPreferences
            .setString('phone', jsonDecode(response.body)['data']['phone']);
        MyServices.sharedPreferences
            .setString('area', jsonDecode(response.body)['data']['area']);
        print('=====================branch====================');
        print(jsonDecode(response.body)['data']['branch']);
        print(MyServices.sharedPreferences.getString('branch'));
        print('=====================area====================');
        print(jsonDecode(response.body)['data']['area']);
        print(MyServices.sharedPreferences.getString('area'));
        MyServices.sharedPreferences
            .setString('branch', jsonDecode(response.body)['data']['branch']);
        MyServices.sharedPreferences.setString(
            'token', jsonDecode(response.body)['data']['access_token']);
        MyServices.sharedPreferences.setString(
            'cover', jsonDecode(response.body)['data']['profile_picture']);
        token = MyServices.sharedPreferences.getString('token')!;
        print('your token is $token');
        statusRequest = StatusRequest.success;
      } else {
        print('-=================done two ======================');

        statusRequest = StatusRequest.failure;


  }
    update();

  }

  }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/routes.dart';

import '../services/services.dart';

class MainMiddleWare extends GetMiddleware {
  @override
  int? priority = 1;

  @override
  RouteSettings? redirect(String? route) {
    if (MyServices.sharedPreferences.getBool('onBoarding') == true) {
      if (MyServices.sharedPreferences.getBool('login') == true) {
                return const RouteSettings(name:AppRoutes.home );

      } else {
                return const RouteSettings(name: AppRoutes.login);

      }
    }
    else {
      return null;
    }
  }
}

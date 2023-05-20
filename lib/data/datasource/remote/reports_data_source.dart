import 'package:dio/dio.dart';
import 'package:washing_line/app_api_links.dart';
import 'package:washing_line/core/class/curd_helper.dart';

import '../../../core/services/services.dart';

class ReportsDataSource{
  static getDailyReports(String day) async {
    Response response = await Crud.dio.get('${AppApiLinks.getDailyReports}?day=$day',
        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}'
        }));
    return response;
  }
  static getMonthlyReports(String month) async {
    Response response = await Crud.dio.get('${AppApiLinks.getMonthlyReports}?month=$month',

        options: Options(headers: {
          'Authorization':
          'Bearer ${MyServices.sharedPreferences.getString('token')}',

        }));
    return response;
  }

}
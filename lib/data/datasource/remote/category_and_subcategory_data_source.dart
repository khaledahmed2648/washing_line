import 'package:dio/dio.dart';
import 'package:washing_line/app_api_links.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/functions.dart';
import 'package:washing_line/core/services/services.dart';

class CategoryDataSource {
  static getCategories() async {
    Response response = await Crud.dio.get(AppApiLinks.getCategories,options: Options(headers:  {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
  static getSupCategories() async {
    Response response = await Crud.dio.get(AppApiLinks.getSupCategories,options: Options(headers:  {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
}

import 'package:dio/dio.dart';
import 'package:washing_line/core/functions.dart';
import 'package:washing_line/core/services/services.dart';

import '../../../app_api_links.dart';
import '../../../core/class/curd_helper.dart';

class ProductDataSource{
  static getProducts(int supCategoryId) async {
    Response response = await Crud.dio.get('${AppApiLinks.getProducts}/$supCategoryId',options: Options(headers:  {'Authorization': 'Bearer ${MyServices.sharedPreferences.getString('token')}'}));
    return response;
  }
}
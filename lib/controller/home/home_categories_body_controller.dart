
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/core/functions.dart';
import 'package:washing_line/data/datasource/remote/category_and_subcategory_data_source.dart';
import 'package:washing_line/data/model/sup_category_id.dart';

import '../../data/model/category_model.dart';

class HomeCategoriesBodyController extends GetxController {
  StatusRequest statusRequest = StatusRequest.initialState;
  StatusRequest statusSupCategoryRequest = StatusRequest.initialState;
  List<CategoryModel> categories = [];
  List<SupCategoryModel> supCategories = [];
  Map<int,List<SupCategoryModel>> allCat = {};

  addAllCat() {
    categories.forEach((category) {
      var matchingSupCategories = supCategories
          .where((supCategory) => supCategory.categoryId.toString() == category.categoryId.toString())
          .toList();

      if (matchingSupCategories.isNotEmpty) {
        allCat[category.categoryId] = matchingSupCategories;
      }
    });
  }

  static HomeCategoriesBodyController get =
      Get.find<HomeCategoriesBodyController>();

  getCategories() async {
    if (await checkInternet()) {
      statusRequest = StatusRequest.loading;
      try{
        dio.Response response = await CategoryDataSource.getCategories();
        if (response.statusCode == 200) {
          categories = [];
          print(response.data['data']);
          if(response.data['data']['data'].isNotEmpty){
            response.data['data']['data'].forEach((element) {

              categories.add(CategoryModel.fromJson(element));
              print(categories);
            });
          }
          statusRequest = StatusRequest.success;

          getSupCategories();
        } else {
          statusRequest = StatusRequest.serverFailure;
        }
      }catch(error){
        print(error.toString());
        if(error is dio.DioError){
          print(error.response!.statusCode.toString());
          if(error.response!.statusCode==401){
            Get.defaultDialog(
              title: 'تحذبر',middleText:'هناك مشكلة في تعريف حسابك'
            ).then((value) {

              Get.offNamed(AppRoutes.login);

            });
          }
        }
      }

    } else {
      statusRequest = StatusRequest.offlineFailure;
    }
    print(statusRequest);
    update();
  }

  getSupCategories() async {
    if (await checkInternet()) {
      dio.Response response = await CategoryDataSource.getSupCategories();
      if (response.statusCode == 200) {
        supCategories = [];
        response.data['data']['data'].forEach((element) {
          supCategories.add(SupCategoryModel.fromJson(element));
          statusSupCategoryRequest = StatusRequest.success;
          addAllCat();

        });
        print('##############  categoryName  ###############');
        // print(allCat.values.toList()[0][0].categoryName);
        print('##############   categoryName   #################s');
      } else {
        statusSupCategoryRequest = StatusRequest.serverFailure;
      }
    } else {
      statusSupCategoryRequest = StatusRequest.offlineFailure;
    }
    update();
  }
}

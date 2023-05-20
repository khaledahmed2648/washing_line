import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart'as dio;
import 'package:washing_line/controller/home/home_shop_body_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/data/datasource/local/sqflite.dart';
import 'package:washing_line/data/datasource/remote/products_data_source.dart';
import '../core/constant/main_constants.dart';
import '../core/constant/routes.dart';
import '../core/functions.dart';
import '../data/model/product_model.dart';
import '../preseintation/widgets/main_widgets/custom_button.dart';

SqlDb sqlDb = Get.put(SqlDb());

class ProductController extends GetxController {
  ProductController(int supCategoryId){
    getProduct(supCategoryId);
  }
  @override
  void onInit() async {
    print(sqlDb.readData("SELECT * FROM 'shop'"));
    super.onInit();
  }
  List<RemoteProductModel> supCategoryProducts=[];
  StatusRequest statusRequest = StatusRequest.initialState;
  getProduct(int supCategoryId)async{
    if (await checkInternet()) {
      dio.Response response = await ProductDataSource.getProducts(supCategoryId);
      print(response);
      if (response.statusCode == 200) {
        supCategoryProducts = [];
        response.data['data']['products'].forEach((element) {
          supCategoryProducts.add(RemoteProductModel.fromJson(element));
        });
        statusRequest = StatusRequest.success;
      } else {
        statusRequest = StatusRequest.serverFailure;
      }
    } else {
      statusRequest = StatusRequest.offlineFailure;
    }
    update();
  }
  @override
  void onClose() {
    HomeShopBodyController.instance.getShopProducts();
    super.onClose();
  }

// Map<int,List>


  Future<void> addToShop() async {
    Future.wait(supCategoryProducts.map((element) async {
      if (element.productQuantity != 0) {
        bool exist =
            await sqlDb.checkItem('productId', element.productId.toString());
        if (exist == false) {
          sqlDb.insertData('''
            INSERT INTO 'shop' ('productId','productName','productImage','productQuantity','productPrice')VALUES
            ('${element.productId}','${element.productName}','${element.productImage}','${element.productQuantity}','${element.productPrice}')
            ''');
        } else {
          sqlDb.updateData(
              'UPDATE shop SET productQuantity=${element.productQuantity} WHERE productId=${element.productId}');

        }
      }
      return null;
    }));

    // }
  }

  anotherProductOrBuildBill(
      context, ProductController controller, int categoryNum) {
    Get.defaultDialog(
      title: 'اختيار منتج اخر',
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: 'نعم',
            width: 75 * w(context),
            height: 50 * h(context),
            onPressed: () {
              Get.back();
              Get.back();
            },
          ),
          SizedBox(
            width: 10 * w(context),
          ),
          CustomButton(
            onPressed: () {
              _goToShop();
            },
            text: 'سلة التسوق',
            width: 180 * w(context),
            height: 50 * h(context),
            alertButton: true,
          ),
        ],
      ),
    );
  }

  void _goToShop() {
    Get.offNamedUntil(AppRoutes.home, arguments: 1, (route) => false);
  }
}

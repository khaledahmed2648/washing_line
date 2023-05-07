import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/data/datasource/local/sqflite.dart';

import '../core/constant/color.dart';
import '../core/constant/main_constants.dart';
import '../core/constant/routes.dart';
import '../data/model/category_model.dart';
import '../data/model/product_model.dart';
import '../preseintation/widgets/main_widgets/custom_button.dart';
import 'home/home_controller.dart';
SqlDb sqlDb= Get.put(SqlDb());
class ProductController extends GetxController {
  @override
  void onInit()async{
    print( sqlDb.readData("SELECT * FROM 'shop'"));
    super.onInit();

  }
  List<List<ProductModel>> products = [
    [
      ProductModel(
        productId: 0,
          productName: 'سجاد 1 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 1,
          productName: 'سجاد 2 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 2,
          productName: 'سجاد 3 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId:3,
          productName: 'سجاد 4 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
    ],
    [
      ProductModel(
          productId: 4,
          productName: 'بطانية 1 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_blanket.png'),
      ProductModel(
          productId: 5,
          productName: 'بطانية 2 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_blanket.png'),
      ProductModel(
          productId:6,
          productName: 'بطانية 3 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_blanket.png'),
      ProductModel(
          productId: 7,
          productName: 'بطانية 4 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_blanket.png'),
    ],
    [
      ProductModel(
          productId: 8,
          productName: 'كنبة 1 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_couch.png'),
      ProductModel(
          productId: 9,
          productName: 'كنبة 4 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
          '${AppAssetUrl.rootImage}/products/product_couch.png'),
      ProductModel(
          productId: 10,
          productName: 'كنبة 2 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_couch.png'),
      ProductModel(
          productId: 11,
          productName: 'كنبة 3 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_couch.png'),
      ProductModel(
          productId: 12,
          productName: 'كنبة 4 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage:
              '${AppAssetUrl.rootImage}/products/product_couch.png'),
    ],
    [
      ProductModel(
          productId: 13,
          productName: 'سجاد 1 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 2 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 3 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 4 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
    ],
    [
      ProductModel(
          productId: 13,
          productName: 'سجاد 1 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 2 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 3 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 4 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
    ],
    [
      ProductModel(
          productId: 13,
          productName: 'سجاد 1 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 2 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 3 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
      ProductModel(
          productId: 13,
          productName: 'سجاد 4 متر',
          productQuantity: 0,
          productPrice: 25,
          productImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
    ],
  ];
  List<String> productNames = [
    'السجاد',
    'البطانيات',
    'الكنب',
    'السجاد',
    'السجاد',
  ];
  List<CategoryModel> categories = [
    CategoryModel(
        categoryId: 1,
        categoryName: 'سجاد',
        categoryImage: '${AppAssetUrl.rootImage}/products/product_curpet.png'),
    CategoryModel(
        categoryId: 2,
        categoryName: 'بطانيات',
        categoryImage: '${AppAssetUrl.rootImage}/products/product_blanket.png'),
    CategoryModel(
        categoryId: 3,
        categoryName: 'كنب',
        categoryImage: '${AppAssetUrl.rootImage}/products/product_couch.png'),
    CategoryModel(
        categoryId: 4,
        categoryName: 'ركن',
        categoryImage: '${AppAssetUrl.rootImage}/products/product_chair.png'),
    CategoryModel(
        categoryId: 5,
        categoryName: 'ملابس',
        categoryImage:
            '${AppAssetUrl.rootImage}/products/product_curtains.png'),
    CategoryModel(
        categoryId: 6,
        categoryName: 'ملابس',
        categoryImage: '${AppAssetUrl.rootImage}/products/product_clothes.png'),
  ];
  addToShop(int categoryId){
    Future.wait(products[categoryId].map((element) async{
      if(element.productQuantity!=0){
          bool exist=await sqlDb.checkItem('productId', element.productId.toString());
          if(exist==false){
          sqlDb.insertData('''
            INSERT INTO 'shop' ('productId','productName','productImage','productQuantity','productPrice')VALUES
            ('${element.productId}','${element.productName}','${element.productImage}','${element.productQuantity}','${element.productPrice}')
            ''');
          }else{
          sqlDb.updateData('UPDATE shop SET productQuantity=${element.productQuantity} WHERE productId=${element.productId}');
          }
          }
      return null;
    }));
    // products[categoryId].forEach((element)async {
    //   Future.wait({
    //   if(element.productQuantity!=0){
    //   bool exist=await sqlDb.checkItem('productId', element.productId.toString());
    //   if(exist==false){
    //   sqlDb.insertData('''
    //     INSERT INTO 'shop' ('productId','productName','productImage','productQuantity','productPrice')VALUES
    //     ('${element.productId}','${element.productName}','${element.productImage}','${element.productQuantity}','${element.productPrice}')
    //     ''');
    //   }else{
    //   sqlDb.updateData('UPDATE shop SET productQuantity=${element.productQuantity} WHERE productId=${element.productId}');
    //   }
    //
    //
    //   }
    //   });
    //
    // }


  }
  anotherProductOrBuildBill(context,ProductController controller,int categoryNum) {
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
              controller.addToShop(categoryNum);
              Get.offNamedUntil(AppRoutes.home, (route) => false);
            },
          ),
          SizedBox(width: 10*w(context),),
          CustomButton(
            onPressed: (){
              controller.addToShop(categoryNum);
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
    Get.offNamedUntil(AppRoutes.home,arguments:1, (route) => false);
  }
}

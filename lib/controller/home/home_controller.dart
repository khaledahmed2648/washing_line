import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:washing_line/data/datasource/local/sqflite.dart';
import 'package:washing_line/data/model/product_model.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_shopping_body.dart';

import '../../../core/constant/assets_route.dart';
import '../../../core/constant/color.dart';
import '../../../preseintation/widgets/home_widgets/home_bills_body.dart';
import '../../../preseintation/widgets/home_widgets/home_main_body.dart';
import '../../core/constant/main_constants.dart';
import '../../core/constant/routes.dart';
import '../../preseintation/widgets/main_widgets/custom_button.dart';
import '../../preseintation/widgets/main_widgets/custom_text_field.dart';
import '../product_controller.dart';
import 'home_shop_body_controller.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int i);
}
enum ShopState { initial, loaded, loading }

class HomeScreenControllerImp extends HomeScreenController {
  static HomeScreenController instance = Get.find<HomeScreenController>();
  final advancedDrawerController = AdvancedDrawerController(
    AdvancedDrawerValue.hidden()
  );
  SqlDb sqlDb = Get.put(SqlDb());
  ShopState shopState = ShopState.initial;

  updateProductQuantity(int quantity, int id) {
    sqlDb.updateData(
        "UPDATE 'shop' SET productQuantity=$quantity WHERE id=$id");
  }

  @override
  void onInit() {
    getShopProducts();
    super.onInit();
    currentPage.value = 0;
  }

  List<ProductModel> shopProducts = [];

  getShopProducts() {
    sqlDb.readData("SELECT * FROM 'shop'").then((value) {
      shopProducts = [];
      value.forEach((element) {
        shopProducts.add(ProductModel.fromJson(element));
        print(element);
      });
    });
    shopState = ShopState.loaded;
    update();
  }


  RxInt currentPage = 0.obs;
  List<Widget> bottomAppBarIcons = [
    SvgPicture.asset(
      '${AppAssetUrl.rootIcons}/main_bar_icon.svg',
    ),
    SvgPicture.asset(
      '${AppAssetUrl.rootIcons}/shopping_bar_icon.svg',
    ),
    SvgPicture.asset(
      '${AppAssetUrl.rootIcons}/bells_bar_icon.svg',
    ),

  ];
  List<Widget> bottomAppBarTitle = [
    Text("الرئيسية"),
    Text("عربة التسوق"),
    Text("الفواتير"),
  ];


  RxList<Widget> buildScreens = [
    HomeMainBody(),
    HomeShoppingBody(),
    HomeBillsBody(),
  ].obs;

  @override
  changePage(int i) {
    currentPage.value = i;
    if (i == 1) {}
    update();
  }

  void interClientNumber(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        backgroundColor: AppColors.background,
        content: Container(
          height: 400*h(context),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الهاتف',
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brounColor),
              ).marginOnly(bottom: 10 * h(context)),
              CustomTextField(
                  controller: TextEditingController(), hint: 'الهاتف'),
              Text(
                'الكود',
                style: TextStyle(
                    fontFamily: 'roboto',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.brounColor),
              ).marginOnly(bottom: 10 * h(context)),
              CustomTextField(
                  controller: TextEditingController(), hint: 'الكود')
                  .marginOnly(bottom: 10 * h(context)),

              CustomButton(
                onPressed: () {
                  _search(context);
                },
                text: 'بحث',
                height: 50 * h(context),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _confirmBill(BuildContext context) {
    sqlDb.deleteTable('shop');
    getShopProducts();
    Get.defaultDialog(
        title: '',
        content: Container(
          padding: EdgeInsets.all(
              20 * w(context)
          ),
          child: Column(
            children: [
              Container(
                  height:100,
                  width: 100,
                  child: Icon(
                    Icons.check_circle_outline, color: Colors.green,
                    size: 100*h(context)*w(context),
                  )),
              Text('تم تسجيل الفاتورة')
            ],
          ),
        )
    );
    update();
    Get.toNamed(AppRoutes.billdetailsScreen);
  }

  void _search(BuildContext context) {Get.defaultDialog(
      title: '',
      content: Container(
        padding: EdgeInsets.all(
            20 * w(context)
        ),
        child: CustomButton(text: 'تأكيد',onPressed: (){
          _confirmBill(context);
        },),
      )
  );}

}
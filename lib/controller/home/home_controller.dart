
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:washing_line/controller/home/home_bills_body_controller.dart';
import 'package:washing_line/controller/home/home_categories_body_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/data/model/cleint_bills_model.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_shopping_body.dart';

import '../../../core/constant/assets_route.dart';
import '../../../preseintation/widgets/home_widgets/home_bills_body.dart';
import '../../../preseintation/widgets/home_widgets/home_main_body.dart';
import 'home_shop_body_controller.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int i);
}

enum ShopState { initial, loaded, loading }

class HomeScreenControllerImp extends HomeScreenController {
  @override
  onInit() async {
    HomeCategoriesBodyController.get.getCategories();
    super.onInit();
  }

  HomeScreenControllerImp() {
    HomeShopBodyController.instance.getShopProducts();
  }
  static HomeScreenControllerImp instance = Get.find<HomeScreenControllerImp>();
  final advancedDrawerController =
      AdvancedDrawerController(AdvancedDrawerValue.hidden());

  int currentPage = 0;
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
    currentPage = i;
    if (i == 2) {
      HomeBillsBodyController.get.getBills('0');
    }

    update();
  }
}

import 'package:get/get.dart';
import 'package:washing_line/controller/bill_details_controller.dart';
import 'package:washing_line/controller/home/home_bills_body_controller.dart';
import 'package:washing_line/controller/home/home_categories_body_controller.dart';
import 'package:washing_line/controller/home/home_controller.dart';
import 'package:washing_line/controller/home/home_shop_body_controller.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_bills_body.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeShopBodyController());
    Get.put(HomeBillsBodyController());
    Get.put(HomeCategoriesBodyController());
    Get.put(BillDetailsController());
  }
}

import 'package:get/get.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/preseintation/screens/bill_details_screen.dart';
import 'package:washing_line/preseintation/screens/delegate_reports_screen.dart';
import 'package:washing_line/preseintation/screens/home_screen.dart';
import 'package:washing_line/preseintation/screens/login_screen.dart';
import 'package:washing_line/preseintation/screens/on_boarding_screen.dart';
import 'package:washing_line/preseintation/screens/payment_screen.dart';
import 'package:washing_line/preseintation/screens/product_details_screen.dart';
import 'package:washing_line/preseintation/screens/product_screen.dart';
import 'package:washing_line/preseintation/widgets/product_details_item.dart';

import 'core/mainmiddleware/mainmiddleware.dart';

List <GetPage<dynamic>>? routes=[

  GetPage(
      name: '/', page: () => const OnBoardingScreen(), middlewares: [MainMiddleWare()]),
  GetPage(
      name: AppRoutes.login, page: () => const LoginScreen()),
  GetPage(
      name: AppRoutes.home, page: () =>  HomeScreen()),
  GetPage(
      name: AppRoutes.products, page: () => ProductScreen()),
  GetPage(
      name: AppRoutes.productsDetails, page: () =>  ProductDetailsScreen()),
  GetPage(
      name: AppRoutes.billdetailsScreen, page: () =>  BillDetailsScreen()),
  GetPage(
      name: AppRoutes.delegateReportsScreen, page: () => const DelegateReportsScreen()),
  GetPage(
      name: AppRoutes.payment, page: () => const PaymentScreen()),
];
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:washing_line/controller/home/home_bills_body_controller.dart';
import 'package:washing_line/controller/home/home_shop_body_controller.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/core/services/services.dart';
import 'package:washing_line/data/datasource/remote/login_data_source.dart';
import 'package:washing_line/preseintation/screens/delegate_reports_screen.dart';
import 'package:washing_line/preseintation/screens/login_screen.dart';
import 'package:washing_line/preseintation/screens/profile_screen.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_drawer_row.dart';

import '../../controller/home/home_controller.dart';
import '../../core/constant/main_constants.dart';

class HomeScreen extends StatelessWidget {
  int? currentPage = Get.arguments;
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeScreenControllerImp controller = Get.put(HomeScreenControllerImp());
    if (currentPage != null) {
      controller.currentPage = currentPage!;
    }
    print('home rebuild');
    return GetBuilder<HomeScreenControllerImp>(builder: (controller) {
      return SafeArea(
          child: AdvancedDrawer(
        backdrop: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
          ),
        ),
        controller: controller.advancedDrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        animateChildDecoration: true,
        rtlOpening: true,
        // openScale: 1.0,
        disabledGestures: false,
        childDecoration: const BoxDecoration(
          // NOTICE: Uncomment if you want to add shadow behind the page.
          // Keep in mind that it may cause animation jerks.
          // boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: Colors.black12,
          //     blurRadius: 0.0,
          //   ),
          // ],
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Scaffold(
          bottomNavigationBar: SalomonBottomBar(
            backgroundColor: AppColors.whiteColor,
            margin: EdgeInsets.symmetric(
                horizontal: 40 * w(context), vertical: 17 * h(context)),
            currentIndex: controller.currentPage,
            onTap: (int currentIndex) {
              controller.changePage(currentIndex);
            },
            selectedItemColor: AppColors.primaryColor,
            items: [
              SalomonBottomBarItem(
                icon: SvgPicture.asset(
                  '${AppAssetUrl.rootIcons}/main_bar_icon.svg',
                  color: controller.currentPage == 0
                      ? AppColors.primaryColor
                      : null,
                ),
                title: controller.bottomAppBarTitle[0],
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset(
                  '${AppAssetUrl.rootIcons}/shopping_bar_icon.svg',
                  color: controller.currentPage == 1
                      ? AppColors.primaryColor
                      : null,
                ),
                title: controller.bottomAppBarTitle[1],
              ),
              SalomonBottomBarItem(
                icon: SvgPicture.asset(
                  '${AppAssetUrl.rootIcons}/bells_bar_icon.svg',
                  color: controller.currentPage == 2
                      ? AppColors.primaryColor
                      : const Color(0xffE1E1E1),
                ),
                title: controller.bottomAppBarTitle[2],
              ),
            ],
          ),
          body:
              Obx(() => controller.buildScreens[controller.currentPage]),
        ),
        drawer: Container(
          padding: EdgeInsets.only(left: 80 * w(context)),
          color: AppColors.primaryColor,
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60 * w(context),
                  backgroundImage: NetworkImage(
                      MyServices.sharedPreferences.getString('cover')!
                  ),
                ).marginOnly(top: 40 * h(context)),
              ),
              Text(
                  MyServices.sharedPreferences.getString('name')!,
                style: TextStyle(color: AppColors.whiteColor),
              ).marginOnly(bottom: 40 * h(context)),
              InkWell(
                  onTap: () {
                    Get.to(ProfileScreen());
                  },
                  child: HomeDrawerRow(
                    iconData: Icons.person,
                    label: 'الحساب الشخصي',
                  )),
              HomeDrawerRow(
                iconData: Icons.notifications,
                label: 'الاشعارات',
              ),
              HomeDrawerRow(
                iconData: Icons.translate,
                label: 'اللغة',
              ),
              InkWell(
                  onTap: () {
                    Get.to(DelegateReportsScreen());
                  },
                  child: HomeDrawerRow(
                    iconData: Icons.note,
                    label: 'تقارير المندوب',
                  )),
              HomeDrawerRow(
                iconData: Icons.share_outlined,
                label: 'مشاركة التطبيق',
              ),
            ],
          ),
        ),
      ));
    });
  }
}

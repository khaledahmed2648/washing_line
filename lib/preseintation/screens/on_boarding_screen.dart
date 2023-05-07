import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/core/constant/main_constants.dart';
import 'package:washing_line/preseintation/screens/login_screen.dart';
import 'package:washing_line/preseintation/widgets/onBoarding_widgets/on_boarding_page_view.dart';

import '../../controller/on_boarding_controller.dart';
import '../../core/constant/color.dart';
import '../../core/services/services.dart';
import '../../data/datasource/static/static.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OnBoardingControllerImp controller = Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: Column(
        children: [
          InkWell(
            onTap: () {
              // () {

              MyServices.sharedPreferences.setBool('onBoarding', true);
              Get.offAll(LoginScreen());
            },
            child: Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsetsDirectional.only(
                  start: 26 * w(context), top: 92 * h(context)),
              child: Text(
                'تخطى',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          OnBoardingPageView(),
          const Spacer(),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            margin: EdgeInsetsDirectional.only(
                bottom: 76 * h(context),
                start: 58 * w(context),
                end: 23 * w(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    // () {
                    if (controller.currentPage < onBoardingList.length - 1) {
                      controller.next();
                    } else {
                      MyServices.sharedPreferences.setBool('onBoarding', true);
                      Get.offAll(LoginScreen());
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 32 * w(context),
                    child: Image.asset(AppAssetUrl.onBoardingNextPage),
                  ),
                ),
                const Spacer(),
                onBoardingController(context),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

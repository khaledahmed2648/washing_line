import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/home/home_categories_body_controller.dart';
import 'package:washing_line/controller/home/home_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/preseintation/screens/profile_screen.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_main_body_head.dart';

import '../../../controller/home/home_bills_body_controller.dart';

class HomeMainBody extends StatelessWidget {
  const HomeMainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('main body rebuild');
    // HomeScreenControllerImp homeController = Get.find();
    return Column(
      children: [
        HomeMainBodyHead(
          notificationOnPressed: () {},
        ),
        Row(
          children: [
            Container(
              width: 48.5 * w(context),
              height: 42.5 * h(context),
              padding: EdgeInsets.all(12 * w(context)),
              margin: EdgeInsetsDirectional.only(start: 38 * w(context)),
              child: InkWell(
                onTap: () {
                  HomeScreenControllerImp.instance.advancedDrawerController.showDrawer();
                },
                child: SvgPicture.asset(
                  '${AppAssetUrl.rootIcons}/home_icon_first.svg',
                  width: 22.5 * w(context),
                  height: 23.5 * h(context),
                ),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(
                  start: 60 * w(context),
                  end: 25 * w(context),
                  top: 45 * h(context),
                  bottom: 40 * h(context)),
              child: Text(
                'الخدمات',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff756B6B)),
              ),
            ),
          ],
        ),
        Expanded(
          child: GetBuilder<HomeCategoriesBodyController>(
            builder: (controller) {
              if (controller.statusRequest == StatusRequest.success) {
                if (controller.categories.isEmpty) {
                  return SizedBox(
                    height: 400 * h(context),
                    child: Center(
                        child: Text(
                      'لا توجد خدمات',
                      style: TextStyle(color: AppColors.blackColor),
                    )),
                  );
                }else{
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.5 * w(context)),
                    child: GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: .75),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.products,
                                  arguments: controller.allCat[
                                  controller.categories[index].categoryId]);
                            },
                            child: Container(
                              margin: EdgeInsetsDirectional.only(
                                  end: 9.5 / 2 * w(context),
                                  start: 9.5 / 2 * w(context),
                                  bottom: 24 * h(context)),
                              width: 110 * w(context),
                              height: 130 * h(context),
                              padding: EdgeInsets.all(12 * w(context)),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius:
                                BorderRadius.circular(10 * w(context)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          bottom: 10 * w(context)),
                                      child: Image.network(
                                          controller
                                              .categories[index].categoryImage,
                                          width: 70 * w(context),
                                          height: 70 * h(context))),
                                  Text(
                                    controller.categories[index].categoryName,
                                    style: GoogleFonts.getFont('Roboto',
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: Color(0xff756B6B))),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: controller.categories.length),
                  );
                }

              } else if (controller.statusRequest ==
                      StatusRequest.initialState ||
                  controller.statusRequest == StatusRequest.loading) {
                return SizedBox(
                    height: 400 * h(context),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ));
              } else {
                return SizedBox(
                  height: 400 * h(context),
                  child: Center(
                      child: Text(
                    'من فضلك تأكد من الاتصال بالانترنت',
                    style: TextStyle(color: AppColors.blackColor),
                  )),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

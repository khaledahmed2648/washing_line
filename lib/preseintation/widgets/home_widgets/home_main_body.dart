import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/home/home_controller.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/preseintation/screens/profile_screen.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_main_body_head.dart';

import '../../../controller/home/hom_body_controller.dart';

class HomeMainBody extends StatelessWidget {
  const HomeMainBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('main body rebuild');
    HomeBodyControllerImp bodyController = Get.put(HomeBodyControllerImp());
    HomeScreenControllerImp homeController = Get.find();
    return Column(
      children: [
        HomeMainBodyHead(notificationOnPressed: (){},),
        Row(
          children: [
            Container(
              width: 48.5 * w(context),
              height: 42.5 * h(context),
              padding: EdgeInsets.all(12 * w(context)),
              margin: EdgeInsetsDirectional.only(start: 38 * w(context)),
              child: InkWell(
                onTap: (){
                  homeController.advancedDrawerController.showDrawer();
                },
                child: SvgPicture.asset(
                  '${AppAssetUrl.rootIcons}/home_icon_first.svg',
                  width: 22.5 * w(context),
                  height: 23.5 * h(context),
                ),
              ),
            ),
            Container(
              width: 291.6 * w(context),
              height: 44 * h(context),
              margin: EdgeInsetsDirectional.only(start: 21 * w(context)),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10 * w(context))),
              child: TextFormField(
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    suffixIcon: Container(
                      margin: EdgeInsetsDirectional.symmetric(
                          horizontal: 12 * w(context),
                          vertical: 10 * h(context)),
                      child: SvgPicture.asset(
                        '${AppAssetUrl.rootIcons}/home_search_icon.svg',
                        color: Color(0xff828A89),
                        width: 18.5 * w(context),
                        height: 20 * h(context),
                      ),
                    )),
              ),
            )
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(
                    start: 25 * w(context),
                    end: 25 * w(context),
                    top: 45 * h(context),
                    bottom: 40 * h(context)),
                child: Row(
                  children: [
                    Text(
                      'الخدمات',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff756B6B)),
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'عرض الكل',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryColor,
                              fontSize: 18),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.5 * w(context)),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: .83),
                    itemBuilder: (context, index) {
                      // favorateController
                      //         .inFavorite[controller.items[index].items_id] =
                      //     '${controller.items[index].favorite}';
                      // print(favorateController.inFavorite);
                      return InkWell(
                        onTap: (){
                          Get.toNamed(AppRoutes.products);
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
                            borderRadius: BorderRadius.circular(10 * w(context)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  margin:EdgeInsets.only(bottom:10*w(context) ),
                                  child: Image.asset(
                                      bodyController.services[index].serviceImageUrl,
                                      width: 50 * w(context),
                                      height: 50 * h(context))),
                              Text(
                                bodyController.services[index].serviceName,
                                style:GoogleFonts.getFont('Roboto',
                                    textStyle:TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: Color(0xff756B6B))
                                ) ,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: bodyController.services.length),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

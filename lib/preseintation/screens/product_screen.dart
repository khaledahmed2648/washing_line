import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/product_controller.dart';
import 'package:washing_line/core/constant/routes.dart';

import '../../core/constant/assets_route.dart';
import '../../core/constant/color.dart';
import '../../core/constant/main_constants.dart';
import '../../data/model/sup_category_id.dart';

class ProductScreen extends StatelessWidget {
  List<SupCategoryModel>? supCategories = Get.arguments;

  ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                  top: 60 * h(context),
                  start: 21 * w(context),
                  bottom: 90 * h(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 70 * w(context)),
                    child: Text(
                      'المنتجات',
                      style: GoogleFonts.getFont('Roboto',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color: Color(0xff756B6B))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 136 * w(context)),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          '${AppAssetUrl.rootIcons}/arrow_icon.svg',
                          width: 26.5 * w(context),
                          height: 28.5 * h(context),
                        )),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20 * w(context)),
              child: supCategories != null
                  ? GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: .8),
                      itemBuilder: (context, index) {
                        // favorateController
                        //         .inFavorite[controller.items[index].items_id] =
                        //     '${controller.items[index].favorite}';
                        // print(favorateController.inFavorite);
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.productsDetails,
                                arguments: {
                              'index':supCategories![index].supCategoryId,
                                  'supCategoryName':supCategories![index].categoryName
                                });
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
                                        supCategories![index].categoryImage,
                                        width: 80 * w(context),
                                        height: 100 * h(context))),
                                Text(
                                  supCategories![index].categoryName,
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
                      itemCount: supCategories!.length)
                  : Center(
                      child: Text(
                        'لا يوجد منتجات ',
                        style: TextStyle(color: AppColors.blackColor),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

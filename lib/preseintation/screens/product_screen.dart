import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/product_controller.dart';
import 'package:washing_line/core/constant/routes.dart';

import '../../core/constant/assets_route.dart';
import '../../core/constant/color.dart';
import '../../core/constant/main_constants.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller=Get.put(ProductController());
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(top: 60*h(context),start: 21*w(context),bottom: 90*h(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    margin: EdgeInsetsDirectional.only(start: 70*w(context)),
                    child: Text('المنتجات',style: GoogleFonts.getFont('Roboto',textStyle:const TextStyle(fontWeight: FontWeight.w900,fontSize: 25,color: Color(0xff756B6B)) ) ,),),

                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      margin: EdgeInsetsDirectional.only(start: 136*w(context)),
                      child: SvgPicture.asset('${AppAssetUrl.rootIcons}/arrow_icon.svg',width: 26.5*w(context),height: 28.5*h(context),),
                    ),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 43 * w(context)),
              child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1),
                  itemBuilder: (context, index) {
                    // favorateController
                    //         .inFavorite[controller.items[index].items_id] =
                    //     '${controller.items[index].favorite}';
                    // print(favorateController.inFavorite);
                    return InkWell(
                      onTap: (){
                        Get.toNamed(AppRoutes.productsDetails,arguments: index);
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
                                    controller.categories[index].categoryImage,
                                    width: 80 * w(context),
                                    height: 80 * h(context))),
                            Text(
                              controller.categories[index].categoryName,
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
                  itemCount: controller.categories.length),
            ),
          ],
        ),
      ),
    );
  }
}

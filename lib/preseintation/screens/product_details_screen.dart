import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/home/home_controller.dart';
import 'package:washing_line/controller/product_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/preseintation/screens/home_screen.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_text_field.dart';
import 'package:washing_line/preseintation/widgets/product_details_item.dart';
import '../../core/constant/assets_route.dart';
import '../../core/constant/main_constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int supCategoryNum = Get.arguments['index'];
  final String supCategoryName = Get.arguments['supCategoryName'];

  ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController(supCategoryNum));
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(
                top: 20 * h(context),
                start: 10 * w(context),
                bottom: 30 * h(context),end: 20*w(context)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(start: 30 * w(context)),
                  child: Text(
                    supCategoryName,
                    style: GoogleFonts.getFont('Roboto',
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            color: Color(0xff756B6B))),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    margin: EdgeInsetsDirectional.only(start: 136 * w(context)),
                    child: SvgPicture.asset(
                      '${AppAssetUrl.rootIcons}/arrow_icon.svg',
                      width: 26.5 * w(context),
                      height: 28.5 * h(context),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<ProductController>(
              builder: (controller){
                if(controller.statusRequest==StatusRequest.initialState||controller.statusRequest==StatusRequest.loading){
                  return SizedBox(
                      height: 400*h(context),
                      child: Center(child: CircularProgressIndicator(),));
                }
                else if(controller.statusRequest==StatusRequest.success){
                  if(controller.supCategoryProducts.isEmpty){
                    return Center(child: Text('لا توجد منتجات',style: TextStyle(color: AppColors.blackColor)),);
                  }
                  else{
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10 * w(context)),
                      child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 15/17),
                          itemBuilder: (context, index) {
                            return  ProductDetailsItem(
                              model: controller.supCategoryProducts[index],
                              index: index,
                              addOnPressed: () {
                                controller
                                    .supCategoryProducts[index].productQuantity++;
                                controller.update();
                              },
                              minusOnPressed: () {
                                if (controller.supCategoryProducts[index]
                                    .productQuantity >
                                    0) {
                                  controller.supCategoryProducts[index].productQuantity--;
                                  controller.update();
                                }
                              },
                              quantity: controller.supCategoryProducts[index].productQuantity,
                            );
                          },
                          itemCount:controller.supCategoryProducts.length),
                    );
                  }
                }
                else if (controller.statusRequest==StatusRequest.initialState||controller.statusRequest==StatusRequest.loading){
                  return SizedBox(
                      height: 400*h(context),
                      child: Center(child: CircularProgressIndicator(),));
                }
                else{
                  return SizedBox(height:400*h(context),child: Center(child: Text('من فضلك تأكد من الاتصال بالانترنت',style: TextStyle(color: AppColors.blackColor),)),);
                }
              },
            ),
          ),
          CustomButton(
            text: 'استمرار',
            onPressed: () async {
              await controller.addToShop();
              controller.anotherProductOrBuildBill(
                  context, controller,supCategoryNum);
              // int index=await sqlDb.deleteTable("shop");
            },
          )
              .marginSymmetric(
                horizontal: 50 * w(context),
              )
              .marginOnly(bottom: 40 * h(context), top: 20 * h(context))
        ],
      )),
    );
  }
}

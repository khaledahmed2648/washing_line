import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/home/home_controller.dart';
import 'package:washing_line/controller/product_controller.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/preseintation/screens/home_screen.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_text_field.dart';
import 'package:washing_line/preseintation/widgets/product_details_item.dart';
import '../../core/constant/assets_route.dart';
import '../../core/constant/main_constants.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int categoryNum=Get.arguments ;


  ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find();
    return Scaffold(
      body: ListView(
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
                    controller.productNames[categoryNum],
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20 * w(context)),
            child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 150 / 200),
                itemBuilder: (context, index) {
                  return GetBuilder<ProductController>(
                    builder: (controller) => ProductDetailsItem(
                      model: controller.products[categoryNum][index],
                      index:index,
                      addOnPressed: () {
                        controller.products[categoryNum][index].productQuantity++;
                        controller.update();
                      },
                      minusOnPressed: () {
                        if(controller.products[categoryNum][index].productQuantity>0){
                          controller.products[categoryNum][index].productQuantity--;
                          controller.update();
                        }
                      },
                      quantity: controller.products[categoryNum][index].productQuantity,
                    ),
                  );
                },
                itemCount: controller.products[categoryNum].length),
          ),
          CustomButton(
            text: 'استمرار',
            onPressed: ()async {
              controller.anotherProductOrBuildBill(context,controller,categoryNum);
             // int index=await sqlDb.deleteTable("shop");

            },
          ).marginSymmetric(
            horizontal: 50 * w(context),
            vertical: 30 * h(context),
          )
        ],
      )
    );
  }








}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/home/home_shop_body_controller.dart';
import 'package:washing_line/controller/home/home_controller.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_shopping_body_item.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';

import '../../../core/constant/assets_route.dart';
import '../../../core/constant/main_constants.dart';

class HomeShoppingBody extends StatelessWidget {
  const HomeShoppingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerImp>(builder: (controller) {
      if (controller.shopState == ShopState.loaded) {
        print(controller.shopProducts.length);
        return Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                  top: 20 * h(context),
                  start: 21 * w(context),
                  bottom: 32 * h(context)),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        start: 37 * w(context), end: 37 * w(context)),
                    child: Text(
                      'عربة التسوق',
                      style: GoogleFonts.getFont('Roboto',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                              color: Color(0xff756B6B))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 136 * w(context)),
                    child: InkWell(
                      onTap: ()async{
                        if(await controller.sqlDb.checkItem('1', '1')){
                          controller.sqlDb.deleteTable('shop');
                          controller.update();
                        }
                      },
                      child: Icon(Icons.delete),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => HomeShoppingBodyItem(
                  productModel: controller.shopProducts[index],
                  addOnPressed: () async{
                    controller.shopProducts[index].productQuantity++;
                    controller.updateProductQuantity(controller.shopProducts[index].productQuantity,controller.shopProducts[index].id!);
                    controller.update();
                  },
                  minusOnPressed: () {
                    if(controller.shopProducts[index].productQuantity>1){
                      controller.shopProducts[index].productQuantity--;
                      controller.updateProductQuantity(controller.shopProducts[index].productQuantity,controller.shopProducts[index].id!);
                      controller.update();
                    }
                  },
                ),
                separatorBuilder: (context, index) => SizedBox(
                  height: 13 * h(context),
                ),
                itemCount: controller.shopProducts.length,
              ),
            ),
            CustomButton(text:'انشاء فاتورة',onPressed: (){
              controller.interClientNumber(context,);
            },).marginOnly(bottom: 20*h(context))
          ],
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}

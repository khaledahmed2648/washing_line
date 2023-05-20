import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/home/home_shop_body_controller.dart';
import 'package:washing_line/controller/home/home_controller.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/preseintation/widgets/home_widgets/home_shopping_body_item.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_text_field.dart';
import '../../../core/constant/main_constants.dart';

class HomeShoppingBody extends StatelessWidget {
  const HomeShoppingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeShopBodyController>(builder: (controller) {
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
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('هل تريد حذف عناصر السلة'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'لا',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  controller.deleteShop();
                                  await controller.getShopProducts();
                                  controller.update();
                                  Get.back();
                                },
                                child: Text(
                                  'نعم',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        );
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
              itemBuilder: (context, index) => GestureDetector(
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('هل تريد حذف العنصر من السلة'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'لا',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.deleteProduct(
                                controller.shopProducts[index].productId,
                                index);
                            Get.back();
                          },
                          child: Text(
                            'نعم',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: HomeShoppingBodyItem(
                  productModel: controller.shopProducts[index],
                  addOnPressed: () async {
                    controller.shopProducts[index].productQuantity++;
                    controller.updateProductQuantity(
                        controller.shopProducts[index].productQuantity,
                        controller.shopProducts[index].id!);
                    controller.update();
                  },
                  minusOnPressed: () {
                    if (controller.shopProducts[index].productQuantity > 1) {
                      controller.shopProducts[index].productQuantity--;
                      controller.updateProductQuantity(
                          controller.shopProducts[index].productQuantity,
                          controller.shopProducts[index].id!);
                      controller.update();
                    }
                  },
                ),
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 13 * h(context),
              ),
              itemCount: controller.shopProducts.length,
            )),
            CustomTextField(controller:controller.noteController,hint: 'ملاحظة',).marginSymmetric(horizontal:20 ).marginOnly(top: 10*h(context)),
            CustomButton(
              text: 'بحث برقم العميل',
              onPressed: () {
                if (controller.shopProducts.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('لم تقم باضافة اي عناصر بعد'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('حسنا',style: TextStyle(color: AppColors.primaryColor),),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  controller.interClientNumber(
                    context,false
                  );
                }
              },
            ).marginOnly(bottom: 20 * h(context),top: 10),
            CustomButton(
              text: 'بحث بكود العميل',
              onPressed: () {
                if (controller.shopProducts.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('لم تقم باضافة اي عناصر بعد'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text('حسنا',style: TextStyle(color: AppColors.primaryColor),),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  controller.interClientNumber(
                    context,
                    true
                  );
                }
              },
            ).marginOnly(bottom: 20 * h(context))
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/data/model/product_model.dart';

import '../../../core/constant/assets_route.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/main_constants.dart';

class HomeShoppingBodyItem extends StatelessWidget {
  ProductModel productModel;
  void Function() addOnPressed;
  void Function() minusOnPressed;
   HomeShoppingBodyItem({Key? key,required this.productModel,required this.addOnPressed,required this.minusOnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16 * w(context)),
      padding: EdgeInsetsDirectional.only(
          start: 15.5 * w(context),
          end: 15.5 * w(context),
          top: 12 * h(context)),
      height: 90 * h(context),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10 * w(context))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            productModel.productImage,
            width: 87 * w(context),
            height: 73 * h(context),
          ),
          SizedBox(
            width: 10 * w(context),
          ),
          SizedBox(
            width: 160 * w(context),
            child: Text(
              productModel.productName,
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                  height: .9,
                  color: const Color(0xff756B6B),
              ),
              maxLines: 2,
                overflow: TextOverflow.ellipsis,
            ),
          ).marginSymmetric(vertical: 7*w(context)),
          SizedBox(
            width: 5 * w(context),
          ),
          Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: addOnPressed,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5*w(context)),
                      alignment: Alignment.center,
                      width: 25*w(context),
                        height: 25*h(context),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5*w(context))
                        ),
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 15,
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 25*h(context),
                    width: 30*w(context),
                    child: Text(
                      productModel.productQuantity.toString(),
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.primaryColor),
                    ),
                  ),
                  InkWell(
                    onTap: minusOnPressed,
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 7*w(context)),
                        alignment: Alignment.center,
                        width: 25*w(context),
                        height: 25*h(context),
                        decoration: BoxDecoration(
                            color: const Color(0xffFCF0E6),
                            borderRadius: BorderRadius.circular(5*w(context))
                        ),
                        child: Icon(
                          Icons.remove,
                          color: AppColors.primaryColor,
                          size: 15,
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 16 * h(context),
              ),
              Text(
                '${productModel.productPrice} ر س',
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    color: AppColors.primaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}

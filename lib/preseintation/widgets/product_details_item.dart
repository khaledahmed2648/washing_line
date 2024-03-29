import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';

import '../../data/model/product_model.dart';

class ProductDetailsItem extends StatelessWidget {
  final void Function() addOnPressed;
  final void Function() minusOnPressed;
  int quantity;
  int index;

  RemoteProductModel model;

  ProductDetailsItem(
      {Key? key,
      required this.addOnPressed,
      required this.minusOnPressed,
      required this.index,
      required this.quantity,
      required this.model})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
          start: 3* w(context),
          bottom: 24 * h(context)),
      width: 150 * w(context),
      height: 190 * h(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * w(context)),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 120 * h(context),
            width: 160,
            child: Image.network(
              model.productImage,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  model.productName,
                  style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ).marginOnly(top: 10*h(context),right: 5*w(context)),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsetsDirectional.only(
                      start: 5 * w(context)),
                  child: Column(
                    children: [
                      
                      Text(
                        '${model.productPrice}ر.س',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: addOnPressed,
                            child: Container(
                                margin: EdgeInsetsDirectional.only(
                                    start: 5 * w(context)),
                                alignment: Alignment.center,
                                width: 26 * w(context),
                                height: 26 * h(context),
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius:
                                        BorderRadius.circular(5 * w(context))),
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.whiteColor,
                                  size: 15,
                                )),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 22 * h(context),
                            width: 28 * w(context),
                            child: Text(
                              '$quantity',
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AppColors.primaryColor),
                            ),
                          ),
                          InkWell(
                            onTap: minusOnPressed,
                            child: Container(
                                margin: EdgeInsetsDirectional.only(
                                    end: 5 * w(context)),
                                width: 26 * w(context),
                                height: 26 * h(context),
                                decoration: BoxDecoration(
                                    color: const Color(0xffFCF0E6),
                                    borderRadius:
                                        BorderRadius.circular(5 * w(context))),
                                child: Icon(
                                  Icons.remove,
                                  color: AppColors.primaryColor,
                                  size: 15,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

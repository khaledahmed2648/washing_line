import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/data/model/customer_model.dart';
import 'package:washing_line/data/model/main_Bills_model.dart';

import '../../../core/constant/main_constants.dart';

class BillsBodyBillItem extends StatelessWidget {
  DataBillsModel data;
   BillsBodyBillItem({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10*w(context))
        ),
        margin: EdgeInsets.symmetric(horizontal: 33.5 * w(context)),
        padding: EdgeInsetsDirectional.only(
            start: 15.5 * w(context),
            end: 15.5 * w(context),
            top: 12 * h(context)),
        width: 363 * w(context),
        height: 70 * h(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              '${AppAssetUrl.rootIcons}/bells_bar_icon.svg',
              width: 40 * w(context),
              height: 35 * h(context),
              color: AppColors.primaryColor,
            ),
            SizedBox(
              width: 30 * w(context),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'رقم الفاتورة: ${data.billNo!}',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      height: .9,
                      color: const Color(0xff756B6B),),overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              width: 50 * w(context),
            ),
            Text(
              '${(double.parse(data.totalAmount!)*1.15).toStringAsFixed(2)} ر س',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: const Color(0xff756B6B)),

            )
          ],
        ),
      ),
    );
  }
}

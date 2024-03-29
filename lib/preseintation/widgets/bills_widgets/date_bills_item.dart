import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';
import 'package:washing_line/core/constant/routes.dart';

import '../../../core/constant/assets_route.dart';
import '../../../data/model/report_model.dart';

// ignore: must_be_immutable
class DateBillsItem extends StatelessWidget {
  List<DurationReports> model;
   DateBillsItem({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (94+model.length*83)*h(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>BuildReportItem(bill: model[index],context: context),
            separatorBuilder: (context, index) => SizedBox(
              height: 13 * h(context),
            ),
            itemCount: model.length,
          )),
          SizedBox(
            height: 25 * h(context),
          )
        ],
      ),
    );
  }
}

Widget BuildReportItem({required DurationReports bill,required BuildContext context}) {
  return InkWell(
    onTap: (){
      Get.toNamed(AppRoutes.billdetailsScreen,arguments: {'billId':bill.id.toString()});
    },
    child: Center(
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
                  'رقم الفاتورة: ${bill.billNo!}',
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
              '${(double.parse(bill.totalAmount!)*1.15).toStringAsFixed(2)} ر س',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: const Color(0xff756B6B)),

            )
          ],
        ),
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/home/hom_body_controller.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/date_bills_item.dart';

import '../../../core/constant/assets_route.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/main_constants.dart';

class HomeBillsBody extends StatelessWidget {
  const HomeBillsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeBodyControllerImp>(
        builder: (controller) => Container(
          width: double.infinity,
            height:843*h(context) ,
              color: Color(0xffF5F5F5),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(
                        top: 20 * h(context),
                        start: 21 * w(context),
                        bottom: 32 * h(context)),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          '${AppAssetUrl.rootIcons}/home_icon_first.svg',
                          width: 20 * w(context),
                          height: 17 * h(context),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: 37 * w(context), end: 47 * w(context)),
                          child: Text(
                            'الفواتير',
                            style: GoogleFonts.getFont('Roboto',
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22,
                                    color: Color(0xff756B6B))),
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                              start: 136 * w(context)),
                          child: SvgPicture.asset(
                              '${AppAssetUrl.rootIcons}/home_icon_third.svg',
                              width: 26.5 * w(context),
                              height: 28.5 * h(context),
                              color: Color(0xff756B6B)),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 50 * h(context),
                    margin: EdgeInsets.symmetric(horizontal: 33*w(context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10 * w(context)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                controller.changeBillType(BillType.didntDeliver);
                              },
                              child: Container(
                          padding: EdgeInsets.symmetric(
                                horizontal: 7 * w(context)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color:
                                  controller.billType == BillType.didntDeliver
                                      ? AppColors.primaryColor
                                      : AppColors.whiteColor,
                              borderRadius: BorderRadiusDirectional.only(
                                topStart: Radius.circular(10 * w(context)),
                                bottomStart: Radius.circular(10 * w(context)),
                              ),
                          ),
                          child: Text(
                              'لم يتم التسليم ',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: controller.billType ==
                                          BillType.didntDeliver
                                      ? AppColors.whiteColor
                                      : AppColors.primaryColor),
                          ),
                        ),
                            )),
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                controller.changeBillType(BillType.waiting);
                              },
                              child: Container(
                          padding: EdgeInsets.symmetric(
                                horizontal: 7 * w(context)),
                          color: controller.billType == BillType.waiting
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          alignment: Alignment.center,
                          child: Text(
                              'في الانتظار',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: controller.billType == BillType.waiting
                                      ? AppColors.whiteColor
                                      : AppColors.primaryColor),
                          ),
                        ),
                            )),
                        Expanded(
                            child: InkWell(
                              onTap: (){
                                controller.changeBillType(BillType.delivered);
                              },
                              child: Container(
                          padding: EdgeInsets.symmetric(
                                horizontal: 7 * w(context)),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(10 * w(context)),
                                  bottomEnd: Radius.circular(10 * w(context)),
                                ),
                                color: controller.billType == BillType.delivered
                                    ? AppColors.primaryColor
                                    : AppColors.whiteColor),
                          child: Text(
                              'تم التسليم',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      controller.billType == BillType.delivered
                                          ? AppColors.whiteColor
                                          : AppColors.primaryColor),
                          ),
                        ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemBuilder: (context,index)=>InkWell(onTap:(){
                          Get.toNamed(AppRoutes.billdetailsScreen);
                        },child: DateBillsItem(itemCount: 5,)),
                        itemCount: 3,
                    ),
                  )
                ],
              ),
            ));
  }
}

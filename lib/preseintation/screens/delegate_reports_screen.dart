import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:washing_line/controller/delegate_reports_controller.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';

import '../../controller/bill_details_controller.dart';
import '../../core/class/curd_helper.dart';
import '../../core/constant/assets_route.dart';
import '../../core/constant/color.dart';
import '../../core/constant/main_constants.dart';
import '../../core/constant/routes.dart';
import '../widgets/bills_widgets/bills_body_bill_item.dart';
import '../widgets/bills_widgets/date_bills_item.dart';

class DelegateReportsScreen extends StatelessWidget {
  const DelegateReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DelegateReportsController());
    return GetBuilder<DelegateReportsController>(
        builder: (controller){
      return SafeArea(
            child: Scaffold(
              body: Container(
                width: double.infinity,
                height: 843 * h(context),
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
                          Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 37 * w(context), end: 47 * w(context)),
                            child: Text(
                              'التقارير',
                              style: GoogleFonts.getFont('Roboto',
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 22,
                                      color: Color(0xff756B6B))),
                            ),
                          ),
                          CustomButton(text: controller.reportsTurn==ReportsTurn.daily?controller.formatter.format(controller.selectedDate):controller.monthFormatter.format(controller.selectedDate),width: 150*w(context),onPressed: (){
                            controller.selectDate(context);
                          },)
                        ],
                      ),
                    ),
                    Container(
                      height: 50 * h(context),
                      margin:
                      EdgeInsets.symmetric(horizontal: 33 * w(context)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10 * w(context)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller
                                      .changeReportsTurn(ReportsTurn.monthly);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7 * w(context)),
                                  color: controller.reportsTurn ==
                                      ReportsTurn.monthly
                                      ? AppColors.primaryColor
                                      : AppColors.whiteColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'الشهرية',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: controller.reportsTurn ==
                                            ReportsTurn.monthly
                                            ? AppColors.whiteColor
                                            : AppColors.primaryColor),
                                  ),
                                ),
                              )),
                          Expanded(
                              child: InkWell(
                                onTap: () {
                                  controller.changeReportsTurn(ReportsTurn.daily);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7 * w(context)),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(10 * w(context)),
                                        bottomEnd:
                                        Radius.circular(10 * w(context)),
                                      ),
                                      color: controller.reportsTurn ==
                                          ReportsTurn.daily
                                          ? AppColors.primaryColor
                                          : AppColors.whiteColor),
                                  child: Text(
                                    'اليومية',
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: controller.reportsTurn ==
                                            ReportsTurn.daily
                                            ? AppColors.whiteColor
                                            : AppColors.primaryColor),
                                  ),
                                ),
                              )),
                        ],
                      ).marginOnly(bottom: 10),
                    ),
                    if (controller.statusBills != StatusRequest.success)
                      Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          )),
                    if (controller.statusBills == StatusRequest.success)
                      Expanded(
                        child: controller.billsModel!.isEmpty
                            ? Center(
                          child: Text(
                            'لم تتم اضافة فواتير بعد',
                            style: TextStyle(color: AppColors.blackColor),
                          ),
                        )
                            : Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                          separatorBuilder: (context, index) => Container(
                                  height: 10 * h(context),
                          ),
                          shrinkWrap: true,
                          itemCount: controller.billsModel.length,
                          itemBuilder: (context, index) {
                            return BuildReportItem(bill: controller.billsModel[index],context: context);
                          },
                        ),
                                ),
                                SizedBox(height: 7,),
                                Center(
                                  child: Text(
                                    'عدد الفواتير: ${controller.clientBillsNum}',
                                    style: TextStyle(color: AppColors.blackColor),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'اجمالي سعر الفواتير: ${(controller.clientBillsPrice*1.15).toStringAsFixed(2)}',
                                    style: TextStyle(color: AppColors.blackColor),
                                  ),
                                ),
                                SizedBox(height: 7,),
                              ],
                            ),
                      )
                  ],
                ),
              ),
            ),
          );
    }

    );
  }
}

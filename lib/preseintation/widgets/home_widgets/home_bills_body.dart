import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/bill_details_controller.dart';
import 'package:washing_line/controller/home/home_bills_body_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/data/model/cleint_bills_model.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bills_client_body_item.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bills_body_bill_item.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_text_field.dart';
import '../../../core/constant/color.dart';
import '../../../core/constant/main_constants.dart';

class HomeBillsBody extends StatelessWidget {
  const HomeBillsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeBillsBodyController>(
        builder: (controller) {
          
                return  Container(
                  width: double.infinity,
                  height: 843 * h(context),
                  color: Color(0xffF5F5F5),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(
                            top: 30 * h(context),
                            start: 21 * w(context),
                            bottom: 32 * h(context)),
                        child: Row(
                          children: [
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
                            SizedBox(
                                width: 200,
                                child: Column(
                                  children: [
                                    DropdownButton<String>(
                                      value: controller.selectedItem,
                                      onChanged: (value) {
                                        controller.selectedItem = value;
                                          controller.clientRequest =
                                              StatusRequest.initialState;
                                               controller.searchController.clear();
                                        controller.update();
                                      },
                                      items: controller.items.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                      ),
                                      dropdownColor: Colors.white,
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 36.0,
                                      isExpanded: true,
                                    ),
                                    TextFormField(
                                      cursorColor: AppColors.primaryColor,
                                      controller: controller.searchController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'ادخل الرقم',
                                        prefixIcon: controller.billRequest !=
                                            StatusRequest.loading
                                            ? InkWell(
                                          onTap: () {
                                            if (controller.searchController.text.isNotEmpty) {

                                                controller.getClientBills();

                                            }
                                          },
                                          child: Icon(
                                            Icons.search,
                                            color: AppColors.primaryColor,
                                          ),
                                        )
                                            : CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ).marginAll(10 * w(context)),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 50 * h(context),
                        margin: EdgeInsets.symmetric(horizontal: 33 * w(context)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10 * w(context)),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                  onTap: () {
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
                                  onTap: () {
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
                                  onTap: () {
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
                      SizedBox(
                        height: 10 * h(context),
                      ),
                      if (controller.statusBills != StatusRequest.success ||
                          controller.clientRequest == StatusRequest.loading)
                        Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            )),
                      if (controller.statusBills == StatusRequest.success &&
                          controller.clientRequest != StatusRequest.success &&
                          controller.clientRequest != StatusRequest.loading)
                        Expanded(
                          child: controller.billsModel!.data!.isEmpty
                              ? Center(
                            child: Text(
                              'لم تتم اضافة فواتير بعد',
                              style: TextStyle(color: AppColors.blackColor),
                            ),
                          )
                              : ListView.separated(
                            controller: controller.billsScrollController,
                            separatorBuilder: (context, index) => Container(
                              height: 10 * h(context),
                            ),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.billdetailsScreen,
                                      arguments: {
                                        'billId':
                                        '${controller.billsModel!.data![index].id}'
                                      });
                                },
                                child: BillsBodyBillItem(
                                  data: controller.billsModel!.data![index],
                                )),
                            itemCount: controller.billsModel!.data!.length,
                          ),
                        ),
                      if (controller.clientRequest == StatusRequest.success&&controller.statusBills != StatusRequest.loading )
                        controller.clientBills!.data!.bills==null
                            ? Expanded(
                              child: Center(
                          child: Text(
                              'لم تتم اضافة فواتير بعد',
                              style: TextStyle(color: AppColors.blackColor),
                          ),
                        ),
                            )
                            : Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: 10 * h(context)),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                                    final bill = controller.sortedBills[index];
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(AppRoutes.billdetailsScreen, arguments: {
                                          'billId': '${bill.id}',
                                        });
                                      },
                                      child: BillsClientBodyItem(data: bill),
                                    );
                          },
                          itemCount: controller.sortedBills.length,
                        ),
                                  ),
                                  SizedBox(height: 7,),
                                  Center(
                                    child: Text(
                                      'عدد الفواتير: ${controller.clientBillsNum.toStringAsFixed(0)}',
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
                            ),

                    ],
                  ),
                );
        }
       );
  }
}

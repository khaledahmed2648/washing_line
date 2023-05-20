import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:washing_line/controller/bill_details_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_column.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_divider.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_row.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';

import '../../core/constant/assets_route.dart';

class BillDetailsScreen extends StatelessWidget {
  String billId = Get.arguments['billId'];

  BillDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BillDetailsController controller = Get.find();

    controller.getBill(billId);

    return Scaffold(
      body: GetBuilder<BillDetailsController>(
        builder: (controller) {
          if (controller.billRequest == StatusRequest.success) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            showMenu(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10 * w(context))),
                                context: context,
                                position: RelativeRect.fromDirectional(
                                    textDirection: TextDirection.rtl,
                                    start: 70 * w(context),
                                    top: 100 * h(context),
                                    end: 10070 * w(context),
                                    bottom: 100100 * h(context)),
                                items: [
                                  PopupMenuItem(
                                    child: SizedBox(
                                      height: 30 * h(context),
                                      width: 200 * w(context),
                                      child: InkWell(
                                        onTap: () {
                                          controller
                                              .saveBillAsPDF(
                                                  context,
                                                  controller.billModel!.data!.billNo
                                                      .toString(),
                                                  true)
                                              .then((value) {});
                                        },
                                        child: Row(
                                          children: [
                                            Text("مشاركة عبر الواتساب "),
                                            const Spacer(),
                                            SvgPicture.asset(
                                                '${AppAssetUrl.rootIcons}/icon_whatsApp.svg',
                                                height: 22 * h(context),
                                                width: 10 * w(context)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    child: InkWell(
                                      onTap: () async {
                                        var status =
                                            await Permission.storage.request();

                                        if (status.isGranted) {
                                          controller.saveBillAsPDF(
                                              context,
                                              controller.billModel!.data!.billNo
                                                  .toString(),
                                              false);
                                        } else if (status.isDenied) {
                                          // Permission denied
                                          status.reactive;
                                        }
                                      },
                                      child: SizedBox(
                                        height: 30 * h(context),
                                        width: 200 * w(context),
                                        child: Row(
                                          children: [
                                            Text("حفظ "),
                                            const Spacer(),
                                            SizedBox(
                                              height: 22 * h(context),
                                              width: 22 * w(context),
                                              child: SvgPicture.asset(
                                                  '${AppAssetUrl.rootIcons}/icon_save.svg'),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                          icon: Icon(
                            Icons.more_vert,
                            size: 20,
                            color: AppColors.blackColor,
                          )),
                      Spacer(),
                      if (controller.billModel!.data!.isPaid == '0')
                        InkWell(
                          onTap: () {
                            _payTheBill(context);
                          },
                          child: Text(
                            'الدفع',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                    ],
                  ).marginOnly(
                      top: 85 * h(context),
                      right: 39 * w(context),
                      left: 49 * w(context),
                      bottom: 21 * h(context)),
                  RepaintBoundary(
                    key: controller.globalKey,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 190 * w(context),
                          child: Stack(
                            children: [
                              PositionedDirectional(
                                  top: 75 * h(context),
                                  child: Text(
                                    'مغاسل خط الغسيل',
                                    style: TextStyle(
                                      fontFamily: 'roboto',
                                      fontSize: 22,
                                      color: AppColors.blackColor,
                                    ),
                                  )),
                              Center(
                                child: Image.asset(
                                  '${AppAssetUrl.rootImage}/login_logo.png',
                                  width: 136 * w(context),
                                  height: 114 * h(context),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'فاتورة ضريبة مبسطة',
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 17,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          controller.billModel!.data!.customer!.phone
                              .toString(),
                          style: TextStyle(
                              fontFamily: 'roboto',
                              fontSize: 16,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const CustomDivider(),
                        Row(
                          children: [
                            BillDetailsColumn(
                                width: 100,
                                itemIdentity: 'المندوب',
                                item:
                                    controller.billModel!.data!.delivery!.name),
                            BillDetailsColumn(
                                itemIdentity: 'المنطقة',
                                item:
                                    controller.billModel!.data!.delivery!.area),
                            BillDetailsColumn(
                                itemIdentity: 'الوقت',
                                item: intl.DateFormat('HH:mm').format(
                                    controller.billModel!.data!.createdAt!)),
                            BillDetailsColumn(
                              itemIdentity: 'التاريخ',
                              item: intl.DateFormat('dd/MM/yyyy').format(
                                  controller.billModel!.data!.createdAt!),
                              width: 130 * w(context),
                            )
                          ],
                        ).marginOnly(right: 30 * w(context)),
                        const CustomDivider(),
                        Column(
                          children: [
                            BillDetailsRow(
                                itemIdentity: 'رقم الفاتورة',
                                item:
                                    controller.billModel!.data!.billNo.toString()),
                            BillDetailsRow(
                                itemIdentity: 'الرقم الضريبى ',
                                item: '300408005600003'),
                            BillDetailsRow(
                                itemIdentity: 'الفرع',
                                item: controller
                                    .billModel!.data!.delivery!.branch),
                            BillDetailsRow(
                              itemIdentity: 'طريقة الدفع',
                              item: controller.billModel!.data!.payOption == '0'
                                  ? 'لم تحدد بعد'
                                  : controller.billModel!.data!.payOption == '1'
                                      ? 'كاش'
                                      : 'بطاقة مدى',
                            )
                          ],
                        ).marginOnly(right: 30 * w(context)),
                        const CustomDivider(),
                        Column(
                          children: [
                            BillDetailsRow(
                                itemIdentity: 'العميل',
                                item: controller
                                    .billModel!.data!.customer!.name!),
                            BillDetailsRow(
                                itemIdentity: 'هاتف العميل',
                                item: controller
                                    .billModel!.data!.customer!.phone!),
                            BillDetailsRow(
                                itemIdentity: 'كود العميل',
                                item: controller
                                    .billModel!.data!.customer!.code!
                                    .toString()),
                          ],
                        ).marginOnly(right: 30 * w(context)),
                        const CustomDivider(),
                        SizedBox(
                          child: Row(
                            children: [
                              Text(
                                'اسم المنتج',
                                style: TextStyle(
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    overflow: TextOverflow.ellipsis),
                              ).marginOnly(right: 30 * w(context)),
                              Text(
                                'الكمية',
                                style: TextStyle(
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    overflow: TextOverflow.ellipsis),
                              ).marginOnly(right: 40 * w(context)),
                              Text(
                                'السعر',
                                style: TextStyle(
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    overflow: TextOverflow.ellipsis),
                              ).marginOnly(right: 50 * w(context)),
                              Text(
                                'الاجمالي',
                                style: TextStyle(
                                    fontFamily: 'roboto',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.blackColor,
                                    overflow: TextOverflow.ellipsis),
                              ).marginOnly(right: 30 * w(context)),
                            ],
                          ).marginOnly(right: 10 * w(context)),
                        ),
                        Container(
                            height:
                                controller.billModel!.data!.products!.length *
                                    40 *
                                    w(context),
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Row(
                                children: [
                                  SizedBox(
                                    width: 118 * w(context),
                                    child: Text(
                                      controller.billModel!.data!
                                          .products![index].name!,
                                      style: TextStyle(
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.blackColor,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      controller.billModel!.data!
                                          .products![index].quantity
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.blackColor,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 9,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      controller.billModel!.data!
                                          .products![index].price
                                          .toString(),
                                      style: TextStyle(
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.blackColor,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      '${(double.parse(controller.billModel!.data!.products![index].price!) * controller.billModel!.data!.products![index].quantity!).toStringAsFixed(2)}',
                                      style: TextStyle(
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: AppColors.blackColor,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                ],
                              ).marginOnly(left: 20, right: 30),
                              itemCount:
                                  controller.billModel!.data!.products!.length,
                            )),
                        const CustomDivider(),
                        Column(
                          children: [
                            BillDetailsRow(
                                itemIdentity: 'المبلغ بدون ضريبة',
                                item:
                                    '${controller.billModel!.data!.totalAmount.toString()} ر.س'),
                            BillDetailsRow(
                                itemIdentity: 'المبلغ بعد الخصم',
                                item:
                                    '${controller.billModel!.data!.totalAmount.toString()} ر.س'),
                            BillDetailsRow(
                                itemIdentity:
                                    'اجمالى ضريبة القيمة المضافة (15%) ',
                                item:
                                    '${(double.parse(controller.billModel!.data!.totalAmount!) * (15 / 100)).toStringAsFixed(2)} ر.س'),
                            BillDetailsRow(
                                itemIdentity: 'مبلغ الفاتورة الاجمالى',
                                item:
                                    '${(double.parse(controller.billModel!.data!.totalAmount!) * (1.15)).toStringAsFixed(2)} ر.س'),
                          ],
                        ).marginOnly(right: 30 * w(context)),
                        const CustomDivider(),
                        Text(
                          'للاستفسار او الشكاوي يرجي الاتصال علي 0551993333',
                          style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const CustomDivider(),
                        Text(
                          controller.billModel!.data!.notes != null
                              ? 'ملاحظة :${controller.billModel!.data!.notes} '
                              : 'لا توجد ملاحظات',
                          style: TextStyle(
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.blackColor,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const CustomDivider(),
                        QrImageView(
                          data: 'https://4z-software.business.site/',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        SizedBox(
                          height: 60 * h(context),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          } else
            return (Center(
              child: CircularProgressIndicator(),
            ));
        },
      ),
    );
  }

  void _payTheBill(BuildContext context) {
    Get.defaultDialog(
        title: 'اختر طريقة الدفع',
        content: Container(
          child: GetBuilder<BillDetailsController>(
            builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Radio(
                      value: 'card',
                      groupValue: controller.paymentMethod,
                      onChanged: (value) {
                        controller.changePaymentMethod(value!);
                      },
                      activeColor: AppColors.primaryColor,
                    ),
                    Text(
                      'بطاقة الائتمان او خصم',
                      style: TextStyle(
                          color: controller.paymentMethod == 'card'
                              ? AppColors.primaryColor
                              : null),
                    )
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 'cash',
                        groupValue: controller.paymentMethod,
                        onChanged: (value) {
                          controller.changePaymentMethod(value!);
                        },
                        activeColor: AppColors.primaryColor),
                    Text('الدفع كاش',
                        style: TextStyle(
                            color: controller.paymentMethod == 'cash'
                                ? AppColors.primaryColor
                                : null))
                  ],
                ),
                CustomButton(
                  text: 'استمرار',
                  onPressed: () {
                    if (controller.paymentMethod == 'cash') {
                      Get.defaultDialog(
                          title: 'تأكيد الدفع كاش',
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (controller.billRequest ==
                                  StatusRequest.loading)
                                CircularProgressIndicator(),
                              if (controller.billRequest !=
                                  StatusRequest.loading)
                                CustomButton(
                                  width: 60 * w(context),
                                  text: 'نعم',
                                  onPressed: () async {
                                    await controller.changeBillStatus('1');
                                  },
                                ),
                              SizedBox(
                                width: 30 * w(context),
                              ),
                              CustomButton(
                                width: 60 * w(context),
                                text: 'لا',
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ));
                    } else {
                      Get.defaultDialog(
                          title: 'تأكيد الدفع بواسطة مدى',
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (controller.billRequest ==
                                  StatusRequest.loading)
                                CircularProgressIndicator(),
                              if (controller.billRequest !=
                                  StatusRequest.loading)
                                CustomButton(
                                  width: 60 * w(context),
                                  text: 'نعم',
                                  onPressed: () async {
                                    await controller.changeBillStatus('2');
                                  },
                                ),
                              SizedBox(
                                width: 30 * w(context),
                              ),
                              CustomButton(
                                width: 60 * w(context),
                                text: 'لا',
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ));
                    }
                  },
                )
                    .marginOnly(top: 10 * h(context))
                    .marginSymmetric(horizontal: 15 * w(context))
              ],
            ),
          ),
        ));
  }
}

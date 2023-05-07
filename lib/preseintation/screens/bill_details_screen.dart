import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/controller/bill_details_controller.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_column.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_divider.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_row.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_row.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_row.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bill_details_row.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';

import '../../core/constant/assets_route.dart';

class BillDetailsScreen extends StatelessWidget {
  const BillDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      showMenu(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10*w(context))
                        ),
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
                                height:30*h(context),
                                 width: 200*w(context),
                                child: Row(
                                  children: [
                                    Text("مشاركة عبر الواتساب "),
                                    const Spacer(),
                                    SvgPicture.asset('${AppAssetUrl.rootIcons}/icon_whatsApp.svg',height: 22*h(context),width: 10*w(context)),
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              child: SizedBox(
                                height:30*h(context),
                                width: 200*w(context),
                                child: Row(
                                  children: [
                                    Text("حفظ "),
                                    const Spacer(),
                                    SizedBox(height: 22*h(context),width: 22*w(context),
                                      child: SvgPicture.asset('${AppAssetUrl.rootIcons}/icon_save.svg'),
                                    )
                                  ],
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
                InkWell(
                  onTap: (){
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
            SizedBox(
              width: 170 * w(context),
              child: Stack(
                children: [
                  PositionedDirectional(
                      top: 75 * h(context),
                      child: Text(
                        'مغاسل واشنج لاين',
                        style: TextStyle(
                          fontFamily: 'roboto',
                          fontSize: 22,
                          color: AppColors.blackColor,
                        ),
                      )),
                  Image.asset(
                    '${AppAssetUrl.rootImage}/login_logo.png',
                    width: 136 * w(context),
                    height: 114 * h(context),
                    fit: BoxFit.contain,
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
              '08558846764',
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontSize: 16,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold),
            ),
            const CustomDivider(),
            Row(
              children: [
                BillDetailsColumn(itemIdentity: 'المندوب', item: 'خالد'),
                BillDetailsColumn(itemIdentity: 'المنطقة', item: 'الرياض'),
                BillDetailsColumn(itemIdentity: 'الوقت', item: '10:30'),
                BillDetailsColumn(
                  itemIdentity: 'التاريخ',
                  item: '24/4/2023',
                  width: 90,
                )
              ],
            ).marginOnly(right: 30 * w(context)),
            const CustomDivider(),
            Column(
              children: [
                BillDetailsRow(
                    itemIdentity: 'الرقم المرجعى', item: '4975847643020322'),
                BillDetailsRow(
                    itemIdentity: 'رقم الجهاز', item: 'dis87w674e6d6'),
                BillDetailsRow(itemIdentity: 'رقم الفاتورة', item: '876'),
                BillDetailsRow(
                    itemIdentity: 'الرقم الضريبى ', item: '4375643478'),
                BillDetailsRow(itemIdentity: 'الفرع', item: ' الدمام'),
                BillDetailsRow(
                  itemIdentity: 'طريقة الدفع',
                  item: 'عند الاستلام',
                )
              ],
            ).marginOnly(right: 30 * w(context)),
            const CustomDivider(),
            Column(
              children: [
                BillDetailsRow(itemIdentity: 'العميل', item: 'يوسف'),
                BillDetailsRow(itemIdentity: 'هاتف العميل', item: '12346790'),
                BillDetailsRow(itemIdentity: 'كود العميل', item: 's8fuf847'),
              ],
            ).marginOnly(right: 30 * w(context)),
            const CustomDivider(),
            Row(
              children: [
                BillDetailsColumn(
                    itemIdentity: 'اسم المنتج', item: '3متر بطانية', width: 90),
                BillDetailsColumn(itemIdentity: 'الكمية', item: '30'),
                BillDetailsColumn(itemIdentity: 'السعر', item: '10'),
                BillDetailsColumn(
                  itemIdentity: 'الاجمالى',
                  item: '32',
                )
              ],
            ).marginOnly(right: 30 * w(context)),
            const CustomDivider(),
            Column(
              children: [
                BillDetailsRow(
                    itemIdentity: 'اجمالى المبلغ بدون ضريبة القيمة المضافة',
                    item: '35 ر.س'),
                BillDetailsRow(
                    itemIdentity: 'اجمالى المبلغ بعد الخصم', item: '35 ر.س'),
                BillDetailsRow(
                    itemIdentity: 'اجمالى ضريبة القيمة المضافة (15%) ',
                    item: '3 ر.س'),
                BillDetailsRow(
                    itemIdentity: 'مبلغ الفاتورة الاجمالى', item: '38 ر.س'),
              ],
            ).marginOnly(right: 30 * w(context)),
            const CustomDivider(),
            Text(
              'ملاحظة : يوجد قطع ف السجادة',
              style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const CustomDivider(),
            SizedBox(
              height: 60 * h(context),
            )
          ],
        ),
      ),
    );
  }

  void _payTheBill(BuildContext context) {
    Get.put(BillDetailsController());
    Get.defaultDialog(
      title: 'اختر طريقة الدفع',
      content: Container(
        child: GetBuilder<BillDetailsController>(
          builder: (controller)=>Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio(value: 'card', groupValue: controller.paymentMethod, onChanged: (value){
                    controller.changePaymentMethod(value!);
                  },activeColor: AppColors.primaryColor,),
                  Text('بطاقة الائتمان او خصم',style: TextStyle(color:controller.paymentMethod=='card'?AppColors.primaryColor:null),)
                ],
              ),
              Row(
                children: [
                  Radio(value: 'cash', groupValue: controller.paymentMethod, onChanged: (value){
                    controller.changePaymentMethod(value!);
                  },activeColor: AppColors.primaryColor),
                  Text('الدفع كاش',style: TextStyle(color:controller.paymentMethod=='cash'?AppColors.primaryColor:null))
                ],
              ),
              CustomButton(text: 'استمرار',onPressed: (){

              },).marginOnly(top: 10*h(context)).marginSymmetric(horizontal: 15*w(context))
            ],
          ),
        ),
      )
    );
  }
}

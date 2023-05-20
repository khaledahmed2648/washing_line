import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:dio/dio.dart' as dio;
import 'package:pdf/widgets.dart'as pdfWidgets;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:washing_line/controller/home/home_bills_body_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/data/datasource/remote/bill_data_source.dart';
import 'package:washing_line/data/model/bill_model.dart';

import '../core/constant/main_constants.dart';
import '../core/constant/routes.dart';

class BillDetailsController extends GetxController{
 static BillDetailsController get =Get.find<BillDetailsController>();
  // final screenshotController = ScreenshotController();
  GlobalKey globalKey=GlobalKey();
  String fPath = '';
  StatusRequest statusBillRequest=StatusRequest.initialState;
 changeBillStatus(String paymentOption)async{
   statusBillRequest=StatusRequest.loading;
   update();

   try{
     Get.back();
     await BillDataSource.changeBillPaymentStatus(billModel!.data!.id!.toString(),paymentOption);
     await BillDataSource.changeBillPayment(billModel!.data!.id!.toString());
     var response=await BillDataSource.changeBillStatus(billModel!.data!.id!.toString());
     if(response.data['success']==true){
       statusBillRequest=StatusRequest.success;
       HomeBillsBodyController.get.getBills('0');
       Get.defaultDialog(title: 'شكرا',middleText: 'تمت عملية الدفع').then((value) {
         Get.offAllNamed(AppRoutes.home);
       });
     }
   }catch(error){
     print(error.toString());
     statusBillRequest=StatusRequest.serverFailure;
     Get.back();
     Get.defaultDialog(title: 'تنبية',middleText: 'لم تتم عملية الدفع برجاء اعادة المحاولة');

   }
   billModel!.data!.status='1';
   update();

 }
  saveBillAsPDF(BuildContext context,String billNumber,bool share)async{
  RenderRepaintBoundary boundary = globalKey.currentContext!
      .findRenderObject() as RenderRepaintBoundary;
  final image = await boundary.toImage();
  final byteData =
      await image.toByteData(format: ImageByteFormat.png);
  final Uint8List pngBytes = byteData!.buffer.asUint8List();

  // Convert the image to PDF
  final pdf = pdfWidgets.Document();
  final imageWidget =
  pdfWidgets.Image(pdfWidgets.MemoryImage(pngBytes));
  pdf.addPage(pdfWidgets.Page(build: (pdfWidgets.Context context) {
    return pdfWidgets.Center(child: imageWidget);
}));
  final output = await getExternalStorageDirectory();
  final downloadsPath = '${output!.path}/Bills';
  final file = File('$downloadsPath/$billNumber.pdf');
  fPath = file.path;

  if (!await File(downloadsPath).exists()) {
    await file.create(recursive: true);
  }
  await file.writeAsBytes(await pdf.save());
  if(share==false){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم تخزين الملف داخل $downloadsPath/$billNumber.pdf')),
    );
  }else{
    Share.shareFiles([fPath], text: 'Great picture');
  }


}
  // Future<void> shareToWhatsApp(Uint8List imageBytes,BuildContext context,String billNumber) async {
  //   try {
  //     await saveBillAsPDF(context,billNumber);
  //     final tempDir = await getTemporaryDirectory();
  //     final file = await File('${tempDir.path}/screenshot.png').create();
  //     await file.writeAsBytes(imageBytes);
  //
  //
  //   } catch (e) {
  //     print('Error sharing to WhatsApp: $e');
  //   }
  // }


  String paymentMethod = 'cash';
  void changePaymentMethod(String value){
    paymentMethod=value;
    update();
  }

void pay(BuildContext context){
  if(paymentMethod=='cash'){
    Get.defaultDialog(
        title: '',
        content: Container(
          padding: EdgeInsets.all(
              20 * w(context)
          ),
          child: Column(
            children: [
              Container(
                  height:100,
                  width: 100,
                  child: Icon(
                    Icons.check_circle_outline, color: Colors.green,
                    size: 100*h(context)*w(context),
                  )),
              Text('تم تسجيل الفاتورة'),
            ],
          ),
        )
    );

  }
  else{
    // Get.toNamed();
  }
}
StatusRequest billRequest=StatusRequest.initialState;
BillModel? billModel;
   getBill(String billId)async {
    billRequest=StatusRequest.loading;
    update();
    try{
      dio.Response response=await BillDataSource.getBill(billId);
      print(response.data);
      billModel=BillModel.fromJson(response.data);
      print(billModel!.data!.id);
      billRequest=StatusRequest.success;
    }catch(error){
      print(error.toString());
      billRequest=StatusRequest.serverFailure;
    }
    update();

  }
}
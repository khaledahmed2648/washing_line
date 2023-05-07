import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/constant/main_constants.dart';

class BillDetailsController extends GetxController{
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
}
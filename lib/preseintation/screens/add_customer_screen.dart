import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/class/curd_helper.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/data/datasource/remote/customer_data_source.dart';

import '../../core/constant/color.dart';
import '../../core/constant/main_constants.dart';
import '../widgets/main_widgets/custom_button.dart';
import '../widgets/main_widgets/custom_text_field.dart';

class AddCustomerScreen extends StatefulWidget {

   AddCustomerScreen({Key? key}) : super(key: key);

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  var formKey=GlobalKey<FormState>();

  StatusRequest statusRequest = StatusRequest.initialState;

  TextEditingController nameController=TextEditingController();

  TextEditingController phoneController=TextEditingController();

  TextEditingController locationController=TextEditingController(text: 'https://www.ww.w');

addCustomer()async{
  statusRequest=StatusRequest.loading;
  setState(() {

  });
  try{
    var response=await CustomerDataSource.addNewCustomer({

      'name':nameController.text,
      'phone':phoneController.text,
      'location':locationController.text
    });
    print(response.data);
    statusRequest=StatusRequest.success;
    phoneController=TextEditingController(text: '');
    locationController=TextEditingController(text: 'https://www.ww.w');
    nameController=TextEditingController();
    Get.defaultDialog(title: 'شكرا لك',middleText:'لقد تم تسجيل العميل بنجاح' ).then((value) {
      Get.back();
    });

  }catch(error){

    if(error is DioError){
    print(error.response!.data);
        Get.defaultDialog(title: 'تنبه',middleText:'${error.response!.data['errors']}' );
      statusRequest=StatusRequest.serverFailure;
    }
  }
  setState(() {

  });

}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Image.asset('${AppAssetUrl.rootImage}/login_logo.png').marginOnly(top: 20*h(context)),
                  CustomTextField(
                    controller: nameController,
                    hint: 'اسم العميل',
                    onValidate: (value) {
                      if (value!.length<3) {
                        return 'الاسم لا يمكن ان يكون اقل من ثلاثة احرف';
                      } else
                        return null;
                    },
                  ).marginSymmetric(horizontal: 30 * w(context)),
                  SizedBox(
                    height: 20 * h(context),
                  ),
                  CustomTextField(
                      controller: phoneController,
                      hint: 'رقم العميل',
                      onValidate: (value) {
                        if (value!.length<9) {
                          return 'رقم الهاتف يجب ان يكون اكبر من ثمان ارقام';
                        } else
                          return null;
                      }).marginSymmetric(horizontal: 30 * w(context)),
                  SizedBox(
                    height: 20 * h(context),
                  ),
                  CustomTextField(
                      controller: locationController,
                      hint: 'موقع العميل',
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return 'رجاء ادخال الموقع';
                        } else
                          return null;
                      }).marginSymmetric(horizontal: 30 * w(context)),
                  SizedBox(
                    height: 50 * h(context),
                  ),
                  if(statusRequest==StatusRequest.loading)
                    Center(child: CircularProgressIndicator(),),
                    if(statusRequest!=StatusRequest.loading)
                  CustomButton(
                      text: 'تسجيل العميل',
                      onPressed: () async {
                        if (formKey.currentState!.validate()){
                         await addCustomer();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

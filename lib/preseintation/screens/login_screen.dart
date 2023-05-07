import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/assets_route.dart';
import 'package:washing_line/core/constant/routes.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_text_field.dart';

import '../../core/constant/color.dart';
import '../../core/constant/main_constants.dart';
import '../../core/services/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 27*h(context),
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(
                top: 83*h(context),
                right: 44*w(context),
                bottom: 56*h(context)
              ),
           child:Image.asset('${AppAssetUrl.rootImage}/saudi_flag.png') ,
            ),
            CustomTextField(controller: TextEditingController(), hint: 'رقم الهاتف'),
             SizedBox(
              height: 20*h(context),
            ),
            CustomTextField(controller: TextEditingController(), hint: 'كلمة المرور'),
            SizedBox(
              height: 77*h(context),
            ),
            CustomButton(text: 'تسجيل الدخول',onPressed: (){
              MyServices.sharedPreferences.setBool('login', true);
              Get.offAllNamed(AppRoutes.home);
            }),


          ],
        ),
      ),
    );
  }
}

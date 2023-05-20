import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/controller/login_controller.dart';
import 'package:washing_line/core/class/curd_helper.dart';
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
    LoginController controller = Get.put(LoginController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 27 * h(context),
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(
                        top: 40 * h(context),
                        right: 44 * w(context),
                        bottom: 56 * h(context)),
                    child: Image.asset('${AppAssetUrl.rootImage}/saudi_flag.png'),
                  ),
                  Image.asset('${AppAssetUrl.rootImage}/login_logo.png'),
                  CustomTextField(
                    controller: controller.usernameController,
                    hint: 'الاسم',
                    onValidate: (value) {
                      if (value!.isEmpty) {
                        return 'رجاء ادخال الاسم';
                      } else
                        return null;
                    },
                  ).marginSymmetric(horizontal: 30 * w(context)),
                  SizedBox(
                    height: 20 * h(context),
                  ),
                  CustomTextField(
                      controller: controller.passController,
                      hint: 'كلمة المرور',
                      onValidate: (value) {
                        if (value!.isEmpty) {
                          return 'رجاء ادخال كلمة المرور';
                        } else
                          return null;
                      }).marginSymmetric(horizontal: 30 * w(context)),
                  SizedBox(
                    height: 50 * h(context),
                  ),
                  GetBuilder<LoginController>(
                    builder: (controller) => Center(
                      child: controller.statusRequest == StatusRequest.loading
                          ? CircularProgressIndicator()
                          : CustomButton(
                              text: 'تسجيل الدخول',
                              onPressed: () async {
                                if (controller.formKey.currentState!.validate()) {
                                  await controller.postLogin();
                                  if (controller.statusRequest ==
                                      StatusRequest.success) {
                                    MyServices.sharedPreferences
                                        .setBool('login', true);
                                    Get.offNamed(AppRoutes.home);
                                    Get.delete<LoginController>();
                                  } else if (controller.statusRequest ==
                                      StatusRequest.offlineFailure) {
                                    Get.defaultDialog(
                                        title: 'تنبية',
                                        middleText:
                                            'من فضلك تفحص اتصالك بالانترنت').then((value) {
                                      controller.statusRequest=StatusRequest.initialState;
                                    });
                                  } else if (controller.statusRequest ==
                                      StatusRequest.failure) {
                                    Get.defaultDialog(
                                        title: 'تنبية',
                                        middleText: 'الاسم او كلمة السر غير صحيحة').then((value) {
                                          controller.statusRequest=StatusRequest.initialState;
                                    });
                                  } else if (controller.statusRequest ==
                                      StatusRequest.serverFailure) {
                                    Get.defaultDialog(
                                        title: 'تنبية',
                                        middleText: 'الاسم او كلمة السر غير صحيحة').then((value) {
                                      controller.statusRequest=StatusRequest.initialState;
                                    });;
                                  }
                                }
                              }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/AppTheme.dart';

class LocaleController extends GetxController{
  Locale? language;
  ThemeData appTheme=englishTheme;


  changeLang(String langCode){
    Locale locale=Locale(langCode);
    // MyServices.sharedPreferences.setString('lang', langCode);
    appTheme=langCode=='ar'?arabicTheme:englishTheme;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);

  }
  @override
  void onInit() {
    super.onInit();
    // String? sharedPrefLang=MyServices.sharedPreferences.getString('lang');

   //    if(sharedPrefLang=='ar') {
   //      language=const Locale('ar');
   //      appTheme=arabicTheme;
   //    } else if(sharedPrefLang=='en') {
   //   language=const Locale('en');
   //   appTheme=englishTheme;
   // } else {
   //   language=Locale(Get.deviceLocale!.languageCode);
   // }


  }
}
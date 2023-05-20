import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:washing_line/bindings/initialBinding.dart';
import 'package:washing_line/core/constant/AppTheme.dart';
import 'package:washing_line/preseintation/screens/home_screen.dart';
import 'package:washing_line/routes.dart';
import 'core/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MyServices.sharedPreferences.setString('token', '')
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: arabicTheme,
      title: 'Washing Line',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English
        const Locale('ar', ''), // Arabic
      ],
      locale: Locale('ar', ''), // Set the default locale to Arabic
      textDirection: TextDirection.rtl,
      getPages: routes,
      initialBinding: InitialBindings(),
    );
  }
}

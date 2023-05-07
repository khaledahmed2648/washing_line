
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/core/constant/color.dart';

ThemeData englishTheme=ThemeData(
  fontFamily: 'PlayfairDisplay',
    textTheme: TextTheme(
      headline1:const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold, fontSize: 20) ,
      headline2:const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold, fontSize: 26) ,
      bodyText1: TextStyle(
          height: 2, fontSize: 17, color: Colors.grey[620]),
    )
);

ThemeData arabicTheme=ThemeData(
  scaffoldBackgroundColor: AppColors.background,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.getFont('Roboto',
        textStyle:TextStyle(
            color: Color(0xffDB6A00),
            fontWeight: FontWeight.w600, fontSize: 22)

      ),
      bodyMedium:GoogleFonts.getFont('Roboto',
          textStyle:TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800, fontSize: 23)

      )  ,
      bodySmall:GoogleFonts.getFont('Roboto',
          textStyle:TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17, color: Color(0xff948E8E)),

      )

    )
);
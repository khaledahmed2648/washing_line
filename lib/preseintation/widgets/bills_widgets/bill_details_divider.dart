import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/color.dart';

import '../../../core/constant/main_constants.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(14, (index) =>Container(
          margin: EdgeInsetsDirectional.only(end: 12*w(context)),
          height: 2,
          width: 12*w(context),
          color: Colors.black,
        ),
        )
      ],
    ).marginSymmetric(horizontal:40*w(context),vertical: 20*h(context));
  }
}

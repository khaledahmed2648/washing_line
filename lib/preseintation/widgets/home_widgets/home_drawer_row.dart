import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/main_constants.dart';

class HomeDrawerRow extends StatelessWidget {
  final IconData iconData;
  final String label;
   HomeDrawerRow({Key? key,required this.iconData,required,required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,color: AppColors.whiteColor,
        ).marginSymmetric(horizontal: 15*w(context)),
        Text(label,style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.whiteColor,fontSize: 18),)
      ],
    ).marginOnly(bottom: 25*h(context));
  }
}

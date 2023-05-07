import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/main_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  double? width;
  double? height;
  Widget? prefixIcon;
  final String hint;

  CustomTextField(
      {Key? key,
      required this.controller,
        this.prefixIcon,
      required this.hint,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width ?? 370 * w(context),
      height: height ?? 60 * h(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * w(context)),
        color: AppColors.whiteColor,
      ),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 20,
            color: const Color(0xff948E8E),
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10 * w(context), vertical: 7 * h(context)),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../../core/constant/color.dart';
import '../../../core/constant/main_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  bool?enabled;
  double? width;
  double? height;
  Widget? prefixIcon;
  String? label;
  String? Function(String?)? onValidate;
  void Function(String)? onChange;
  String? hint;

  CustomTextField(
      {Key? key,
      required this.controller,
        this.enabled,
      this.prefixIcon,
      this.hint,
      this.onValidate,
        this.onChange,
      this.width,
      this.label,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),

      alignment: Alignment.center,
      // width: width ?? 370 * w(context),
      // height: height ?? 60 * h(context),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10 * w(context)),
        color: AppColors.whiteColor,
      ),
      child: TextFormField(
        validator: onValidate,
        onChanged: onChange,
        textAlign: TextAlign.right,
        controller: controller,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 20,
            color: AppColors.blackColor,
            fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          enabled:enabled??true ,
            labelText: label,
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 10 * w(context), vertical: 5 * h(context)),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: hint),
      ),
    );
  }
}

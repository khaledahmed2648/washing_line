import 'package:flutter/material.dart';
import 'package:washing_line/core/constant/color.dart';

import '../../../core/constant/main_constants.dart';

class CustomButton extends StatelessWidget {
  bool? alertButton;
  double? width;
  double? height;
  final String text;
  final void Function()? onPressed;
   CustomButton({Key? key, required this.text, this.onPressed,this.width,this.height,this.alertButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width:width??370*w(context),
          height:height??60*h(context) ,
        decoration: BoxDecoration(
          border: alertButton==true?Border.all(width: 1,color: AppColors.mainColor):null,
          borderRadius: BorderRadius.circular(10*w(context)),
              color:alertButton==true?AppColors.secondaryColor: AppColors.primaryColor,
        ),
        child: Text(text,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:alertButton==true?AppColors.primaryColor: AppColors.secondaryColor, ),),
      ),
    );
  }
}

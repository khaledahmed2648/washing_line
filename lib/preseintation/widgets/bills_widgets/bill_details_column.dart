import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/main_constants.dart';

import '../../../core/constant/color.dart';

class BillDetailsColumn extends StatelessWidget {
  String itemIdentity;
  String item;
  double? width;

  BillDetailsColumn({Key? key, required this.itemIdentity, required this.item,this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80 * h(context),
      width:width!=null?width!*w(context): 70 * w(context),
      child: Column(
        children: [
          Text(
            itemIdentity,
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor,overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            height: 5 * h(context),
          ),
          Text(
            item,
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor,overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    ).marginSymmetric(horizontal: 4);
  }
}

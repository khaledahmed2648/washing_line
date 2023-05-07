import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/main_constants.dart';

import '../../../core/constant/color.dart';

class BillDetailsRow extends StatelessWidget {
  String itemIdentity;
  String item;
   BillDetailsRow({Key? key,required this.itemIdentity,required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SizedBox(
            width: 150*w(context),
            child: Text(
              itemIdentity,
              maxLines: 2,
              style: TextStyle(
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.blackColor,overflow: TextOverflow.ellipsis),
            ),
          ),
          const Spacer(),
          Text(
            item,
            style: TextStyle(
                fontFamily: 'roboto',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: AppColors.blackColor,overflow: TextOverflow.ellipsis),
          ),
        ],
      ).marginSymmetric(vertical: 2*h(context)).marginOnly(left: 60*w(context)),
    );
  }
}

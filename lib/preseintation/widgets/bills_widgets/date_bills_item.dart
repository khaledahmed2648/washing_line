import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';
import 'package:washing_line/preseintation/widgets/bills_widgets/bills_body_bill_item.dart';

class DateBillsItem extends StatelessWidget {
  int itemCount;
   DateBillsItem({Key? key,required this.itemCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (94+itemCount*83)*h(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25 * h(context)),
            width: double.infinity,
            height: 44 * h(context),
            color: Color(0xffF5ECE4),
            alignment: Alignment.center,
            child: Text(
              '20/4/2023',
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: AppColors.primaryColor),
            ),
          ),
          Expanded(
              child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => BillsBodyBillItem(),
            separatorBuilder: (context, index) => SizedBox(
              height: 13 * h(context),
            ),
            itemCount: itemCount,
          )),
          SizedBox(
            height: 25 * h(context),
          )
        ],
      ),
    );
  }
}

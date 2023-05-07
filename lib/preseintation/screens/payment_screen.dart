import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_text_field.dart';

import '../../core/constant/assets_route.dart';
import '../../core/constant/main_constants.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                  top: 20 * h(context), bottom: 30 * h(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 70 * w(context)),
                    child: Text(
                      'الدفع الالكتروني',
                      style: GoogleFonts.getFont('Roboto',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color: Color(0xff756B6B))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      margin:
                          EdgeInsetsDirectional.only(start: 136 * w(context)),
                      child: SvgPicture.asset(
                        '${AppAssetUrl.rootIcons}/arrow_icon.svg',
                        width: 26.5 * w(context),
                        height: 28.5 * h(context),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Image.asset(
              '${AppAssetUrl.rootImage}/Card.png',
              height: 200 * h(context),
            )
                .marginSymmetric(horizontal: 15 * h(context))
                .marginOnly(bottom: 20 * h(context)),
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.grey.withOpacity(.2),
            //       borderRadius: BorderRadius.circular(10*w(context))
            //   ),
            //   margin: EdgeInsets.all(10 * w(context)),
            //   child: TextFormField(
            //     controller: TextEditingController(),
            //     decoration: InputDecoration(
            //       hintText: 'رقم الكارت',
            //       border: InputBorder.none,
            //       contentPadding: EdgeInsets.all(7 * w(context)),
            //     ),
            //   ),
            // )
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter(),
              ],
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Mastercard-logo.svg/800px-Mastercard-logo.svg.png',
                    height: 30,
                    width: 30,
                  ),
                ),
                suffixIcon: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Change',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                border: const OutlineInputBorder(),
                hintText: 'XXXX XXXX XXXX XXXX',
                labelText: 'Card Number',
              ),
              maxLength: 19,
              onChanged: (value) {},
            ).marginSymmetric(horizontal: 15*w(context)),
          ],
        ),
      ),
    );
  }
}
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue previousValue,
      TextEditingValue nextValue,
      ) {
    var inputText = nextValue.text;

    if (nextValue.selection.baseOffset == 0) {
      return nextValue;
    }

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();
    return nextValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(
        offset: string.length,
      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_button.dart';
import 'package:washing_line/preseintation/widgets/main_widgets/custom_text_field.dart';

import '../../core/constant/assets_route.dart';
import '../../core/constant/main_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: double.infinity,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsetsDirectional.only(
                  top: 60 * h(context),
                  start: 21 * w(context),
                  bottom: 90 * h(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 70 * w(context)),
                    child: Text(
                      'الملف الشخصى',
                      style: GoogleFonts.getFont('Roboto',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color: Color(0xff756B6B))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 120 * w(context)),
                    child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          '${AppAssetUrl.rootIcons}/arrow_icon.svg',
                          width: 26.5 * w(context),
                          height: 28.5 * h(context),
                        )),
                  )
                ],
              ),
            ),
            Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  CircleAvatar(
                    radius: 60 * w(context),
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/wide-angle-shot-single-tree-growing-clouded-sky-during-sunset-surrounded-by-grass_181624-22807.jpg?w=900&t=st=1683216147~exp=1683216747~hmac=128a94c36f2721aea861dc30a724ed1ac87211a88d0200919f6cb3fbc11ba17b'),
                  ),
                  CircleAvatar(
                    radius: 22 * w(context),
                    backgroundColor: AppColors.whiteColor,
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.primaryColor,
                        )),
                  ).marginOnly(left: 10 * w(context), top: 10 * h(context)),
                ],
              ).marginOnly(bottom: 54 * h(context)),
            ),
            CustomTextField(
                controller: TextEditingController(), hint: 'خالد احمد').marginOnly(bottom: 20*h(context)).marginSymmetric(horizontal: 30*w(context)),
            CustomTextField(
                controller: TextEditingController(), hint: 'khaled@gmail.com').marginOnly(bottom: 20*h(context)).marginSymmetric(horizontal: 30*w(context)),
            CustomTextField(
                controller: TextEditingController(), hint: '12365544').marginOnly(bottom: 20*h(context)).marginSymmetric(horizontal: 30*w(context)),
            CustomTextField(controller: TextEditingController(), hint: 'ذكر').marginOnly(bottom: 20*h(context)).marginSymmetric(horizontal: 30*w(context)),
            SizedBox(
              height: 30*h(context),
            ),
            CustomButton(text: 'حفظ التغييرات').marginOnly(bottom: 30*h(context)).marginOnly(bottom: 20*h(context)).marginSymmetric(horizontal: 30*w(context))



          ],
        ),
      ),
    ));
  }
}

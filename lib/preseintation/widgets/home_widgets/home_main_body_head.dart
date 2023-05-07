import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constant/assets_route.dart';
import '../../../core/constant/main_constants.dart';

class HomeMainBodyHead extends StatelessWidget {
  void Function() notificationOnPressed;
   HomeMainBodyHead({Key? key,required this.notificationOnPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20*h(context),start: 21*w(context),bottom: 32*h(context)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(start: 85*w(context),end: 37*w(context)),
            child: Text('واشنج لاين',style: GoogleFonts.getFont('Roboto',textStyle:const TextStyle(fontWeight: FontWeight.w900,fontSize: 22,color: Color(0xff756B6B)) ) ,),),

          Container(
            margin: EdgeInsetsDirectional.only(start: 136*w(context)),
            child: InkWell(
                onTap: notificationOnPressed,
                child: SvgPicture.asset('${AppAssetUrl.rootIcons}/home_icon_second.svg',width: 26.5*w(context),height: 28.5*h(context),)),
          )
        ],
      ),
    );
  }
}

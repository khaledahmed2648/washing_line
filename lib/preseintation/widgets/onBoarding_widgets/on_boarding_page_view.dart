import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washing_line/core/constant/color.dart';
import 'package:washing_line/core/constant/main_constants.dart';

import '../../../controller/on_boarding_controller.dart';
import '../../../data/datasource/static/static.dart';

// ignore: must_be_immutable
class OnBoardingPageView extends StatelessWidget {
   OnBoardingPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GetBuilder<OnBoardingControllerImp>(builder: (controller)=>Container(
      width: double.infinity,
      height: 600*h(context),
      child: PageView.builder(
          controller: controller.pageController,
          onPageChanged: (index){
            controller.currentPage=index;
            controller.update();
          },
          itemCount: onBoardingList.length,
          itemBuilder: (context, index) => Column(
            children: [
              Image.asset(
                '${onBoardingList[index].image}',
                height: 390*h(context),
                width: 413*w(context),
              ),
              SizedBox(
                height: 5*h(context),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  '${onBoardingList[index].title}',
                  style:Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 15*h(context),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  '${onBoardingList[index].body}',
                  style:Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
              )
            ],
          )),
    ));
  }
}

Widget onBoardingController(BuildContext context){

  return GetBuilder<OnBoardingControllerImp>(
      builder: (controller){
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
                onBoardingList.length,
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 900),
                  margin:  EdgeInsets.only(right: 5*w(context)),
                  height: 10*h(context),
                  width:controller.currentPage==index? 28*w(context):17*w(context),
                  decoration: BoxDecoration(
                    color:controller.currentPage==index?AppColors.primaryColor:const Color(0xffDDDDDD),
                    borderRadius: BorderRadius.circular(10*h(context)),
                  ),
                ))],);
      }
  );
}

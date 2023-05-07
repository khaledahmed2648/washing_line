import 'package:flutter/material.dart';
import 'package:get/get.dart';
abstract class OnBoardingController extends GetxController{
  next();

  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnBoardingController{
   PageController pageController=PageController(initialPage: 0);
  int currentPage=0;

  @override
  next() {
    currentPage++;
    pageController.animateToPage(currentPage, duration: const Duration(milliseconds: 900), curve: Curves.easeInOut);
    update();
  }

  @override
  onPageChanged(int index) {
    currentPage=index;
    update();
  }
  @override
  void onInit(){
    pageController=PageController();
    super.onInit();

  }

}
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class OnBoardingController extends GetxController {
  //this is the getter function in dart

  static OnBoardingController get instance => Get.find();

  //variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  /// update index while scrolling

  void updatePageIndicator(index) => currentPageIndex.value = index;

  //jump
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // next page

  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write("isFirstTime", false);
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
      currentPageIndex.value = page;
    }
  }

  //

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}

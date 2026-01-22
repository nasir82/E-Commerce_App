import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/onboarding_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/device/device_utils.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = HelperFunctions.isDarkMood(context);
    return Positioned(
      bottom: DeviceUtils.getStatusBarHeight(),
      left: Sizes.defaultSpace,
      
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
         count: 3,
         effect:  ExpandingDotsEffect(activeDotColor: dark ? MyColor.light : MyColor.dark,dotHeight: 6),
         ),
         
         );
  }
}

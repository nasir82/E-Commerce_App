import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/onboarding_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/device/device_utils.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:iconsax/iconsax.dart';

class OnBoardingCirculerButton extends StatelessWidget {
  const OnBoardingCirculerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    return Positioned(
      right: Sizes.defaultSpace,
      bottom: DeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
      onPressed: (){
        OnBoardingController.instance.nextPage();
      },
      style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark ? MyColor.primaryColor: MyColor.black),
      child:const Icon(Iconsax.arrow_right_3),));
  }
}



import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/onboarding_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/device/device_utils.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
     top: DeviceUtils.getStatusBarHeight(),
     right: Sizes.defaultSpace,
      child: TextButton(onPressed: (){
       OnBoardingController.instance.skipPage();
      }, child: const Text("Skip")),
    );
  }
}


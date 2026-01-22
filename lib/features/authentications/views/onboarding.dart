import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/onboarding_controller.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/onboarding_circuler_button.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/onboarding_navigation.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/onboarding_page.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/onboarding_skip.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Stack(
        children: [
          // Horizontal scrollable page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children:const [
            OnBoardingPage(title: TextString.onboardingTitle1, subtitle: TextString.onboardingSubtitle1, image: ImageString.simpleLottie1),
            OnBoardingPage(title: TextString.onboardingTitle2, subtitle: TextString.onboardingSubtitle2, image: ImageString.simpleLottie2),
            OnBoardingPage(title: TextString.onboardingTitle3, subtitle: TextString.onboardingSubtitle3, image: ImageString.simpleLottie3),
           
            ],
          ),

          // skip button
           const OnBoardingSkip(),
          // dot navigation
         const OnBoardingNavigation(),

          // circuler button

         const OnBoardingCirculerButton()
        ],
      ),
    );
  }
}



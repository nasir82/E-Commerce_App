import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/styles/divider_with_text.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/login_with_social_button.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/sign_up_form.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    return Scaffold(
      appBar: const MyAppBar(
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.only(left:  Sizes.defaultSpace,right:Sizes.defaultSpace,top: 10,bottom: Sizes.defaultSpace, ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                TextString.registerTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              //form

              SignUpForm(dark: dark),
              const SizedBox(height: Sizes.spaceBtwSections,),
              DividerWithText(dark: dark, text: TextString.orSignUp),
              
              const SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}


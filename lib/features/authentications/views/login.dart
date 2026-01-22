import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/styles/spacing_style.dart';
import 'package:flutter_e_commerce_app/commons/styles/divider_with_text.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/login_form.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/login_header.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/widgets/login_with_social_button.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppbarHeigh,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LoginHeader(),
              const LoginForm(),
              DividerWithText(dark: dark,text: TextString.orSignIn,),
              const SocialButton()
            ],
          ),
        ),
      ),
    );
  }
}



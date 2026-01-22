import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/forget_password_controller.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/login.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key,required this.email});
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: ()=> Get.back(),
            icon: const Icon(CupertinoIcons.clear,color: MyColor.primaryColor,))
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [

              Image(
                width: HelperFunctions.getScreenWidth()*.8,
                height: HelperFunctions.getScreenHeight()*.3,
                image: const AssetImage(ImageString.simpleLottie1)),
                const SizedBox(height: Sizes.spaceBtwSections,),
                Text("Password Reset Email Sent to $email",style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
                const SizedBox(height: Sizes.spaceBtwInputField,),
                Text("Your account security is our priority. We have sent you a secure link to change your password safely and keep your password protected",style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
                const SizedBox(height: Sizes.spaceBtwSections,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()=> Get.offAll(()=>const LoginScreen()), child: const Text("Done"))
                  ),

                  const SizedBox(height: Sizes.spaceBtwSections,),
                   SizedBox(
                  width: double.infinity,
                  child: TextButton(onPressed: ()=> ForgetPasswordController.instance.resendPasswordResetEmail(email), child: const Text("Resend Email"))
                  ),
         
            ],
          ),
        ),
      ),
    );
  }
}
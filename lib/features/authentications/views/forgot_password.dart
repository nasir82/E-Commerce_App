import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/forget_password_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/validator/validator_helper.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return  Scaffold(
      appBar: AppBar(),
      body:  SingleChildScrollView(
        child: Padding(
          padding:const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // headings
              Text("Forgot password ",style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: Sizes.spaceBtwItems,),
              Text("Don't worry sometmes people can forget too, enter your email and we will send you a password reset link. ",style: Theme.of(context).textTheme.labelMedium,),
              const SizedBox(height: Sizes.spaceBtwSections,),

              //textfied
              Form(
                key: controller.forgetPasswordFormKey,
                child: TextFormField(
                  controller: controller.email,
                  validator:(value)=> ValidatorHelper.validateEmail(controller.email.text.trim()),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct),
                    labelText: "enter your mail",
                  ),
                ),
              ),
              const SizedBox(height: Sizes.spaceBtwSections,),

              //submit button

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=> controller.sentPasswordResetEmail(), child: const Text("submit")))
              
            ],
          ),
        ),
      ),
    );
  }
}
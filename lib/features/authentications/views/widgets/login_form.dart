import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/login_controller.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/sign_up.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/forgot_password.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:flutter_e_commerce_app/utils/validator/validator_helper.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: Sizes.spaceBtwSections),
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
       
            validator: (value)=>ValidatorHelper.validateEmail(value),
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: "Email",
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputField,
          ),
          Obx(
            ()=>TextFormField(
              controller: controller.password,
              obscureText: controller.isShowPassword.value,
              validator: (value)=>ValidatorHelper.validateEmptyString("Password", value),
              decoration:  InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: ()=> controller.isShowPassword.value = !controller.isShowPassword.value,
                  icon:  Icon(  controller.isShowPassword.value ? Iconsax.eye_slash : Iconsax.eye)),
                labelText: "Password",
              ),
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputField / 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged:(value)=> controller.rememberMe.value = !controller.rememberMe.value)),
                  const Text(TextString.rememberMe)
                ],
              ),
              TextButton(
                  onPressed: () {
                    Get.to(()=> const ForgetPassword());
                  }, child: const Text(TextString.forgotPassword))
            ],
          ),
          const SizedBox(
            height: Sizes.spaceBtwSections,
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: ()=> controller.signInWithEmailAndPassword(), child: const Text("sign in"))),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () {
                    Get.to(()=>const SignUpScreen());
                  }, child:const Text("Create account"))),
        ],
      ),
    ));
  }
}

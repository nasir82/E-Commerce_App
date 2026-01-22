import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/signup_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:flutter_e_commerce_app/utils/validator/validator_helper.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
      key: controller.signUpFormkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => ValidatorHelper.validateEmptyString("First Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "First name",
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: Sizes.spaceBtwInputField,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => ValidatorHelper.validateEmptyString("Last Name", value),
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: "Last name",
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputField,
          ),
          TextFormField(
            controller: controller.userName,
            validator: (value) => ValidatorHelper.validateEmptyString("user Name", value),
            expands: false,
            decoration: const InputDecoration(
              labelText: "User name",
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputField,
          ),
          TextFormField(
            controller: controller.email,
            validator: (value) => ValidatorHelper.validateEmail(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: "E-mail",
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputField,
          ),
          TextFormField(
            controller: controller.phoneNumber,
             validator: (value) => ValidatorHelper.validatorPhone(value),
            expands: false,
            decoration: const InputDecoration(
              labelText: "phone",
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwInputField,
          ),
          Obx(
            ()=> TextFormField(
              controller: controller.password,
               validator: (value) => ValidatorHelper.validatorPassword(value),
              expands: false,
              obscureText: controller.isShow.value,      
              decoration:  InputDecoration(
                labelText: "password",
                prefixIcon: const Icon(Iconsax.password_check),
                suffixIcon: IconButton(
                  onPressed: ()=> controller.isShow.value = !controller.isShow.value,
                  icon: controller.isShow.value ?const Icon(Iconsax.eye_slash):const Icon(Iconsax.eye)                
                  ),
              ),
            ),
          ),
            const SizedBox(
        height: Sizes.spaceBtwSections,
      ),
      Row(
        children: [
          SizedBox(child: Obx(()=> Checkbox(value: controller.privacy.value, onChanged: (it) {
            controller.privacy.value = !controller.privacy.value;
          }))),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          Flexible(
            flex: 3,
            child: Text.rich(
              TextSpan(children: [
              TextSpan(
                  text: "I agree to ",
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: "Privacy policy ",
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? MyColor.white : MyColor.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          dark ? MyColor.white : MyColor.primaryColor)),
              TextSpan(
                  text: "and ",
                  style: Theme.of(context).textTheme.bodySmall),
              TextSpan(
                  text: "Terms of use ",
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                      color: dark ? MyColor.white : MyColor.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor:
                          dark ? MyColor.white : MyColor.primaryColor)),
            ])),
          )
        ],
      ),
      const SizedBox(height: Sizes.spaceBtwSections,),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(onPressed: ()=> controller.signUp(), 
        child: const Text(TextString.createAccaunt))),                 
        ],
      ),
    );
  }
}

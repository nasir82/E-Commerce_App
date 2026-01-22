import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/validator/validator_helper.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ReAuthenticateUi extends StatelessWidget {
  const ReAuthenticateUi({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Re-Authenticate User",
      )),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Use real name for easy verification. This name will appear in several page.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            Form(
                key: controller.reAuthFormKey,
                child: Column(
              children: [
                TextFormField(
                   controller: controller.verifyEmail,
                  validator: (value) =>
                      ValidatorHelper.validateEmail(value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "Email", prefixIcon: Icon(Icons.email)),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputField,
                ),
                Obx(
                  ()=> TextFormField(
                    controller: controller.verifyPassword,
                    validator: (value) => ValidatorHelper.validateEmptyString('password',value),
                    expands: false,
                    obscureText: controller.hidePassword.value,
                    decoration: InputDecoration(
                      labelText: "password",
                      prefixIcon: const Icon(Iconsax.password_check),
                      suffixIcon: IconButton(
                          onPressed: () =>
                              controller.hidePassword.value = !controller.hidePassword.value,
                          icon: controller.hidePassword.value
                              ? const Icon(Iconsax.eye_slash)
                              : const Icon(Iconsax.eye)),
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=> controller.reAuthenticateEmailAndPasswordUser(), child: const Text("Verify")))
          ],
        ),
      ),
    );
  }
}

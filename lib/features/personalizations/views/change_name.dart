import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_update_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/validator/validator_helper.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.defaultSpace,
        ),
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
                key: controller.updateUserNameKey,
                child: Column(
              children: [
                TextFormField(
                  controller: controller.firstName,
                  validator: (value) =>
                      ValidatorHelper.validateEmptyString("first name", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "First Name", prefixIcon: Icon(Iconsax.user)),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwInputField,
                ),
                TextFormField(
                  controller: controller.lastName,
                  validator: (value) =>
                      ValidatorHelper.validateEmptyString("last name", value),
                  expands: false,
                  decoration: const InputDecoration(
                      labelText: "Last Name", prefixIcon: Icon(Iconsax.user)),
                ),
              ],
            )),
            const SizedBox(
              height: Sizes.spaceBtwSections,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: ()=> controller.updateUserName(), child: const Text("Save")))
          ],
        ),
      ),
    );
  }
}

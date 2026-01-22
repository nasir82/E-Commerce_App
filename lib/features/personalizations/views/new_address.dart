import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/address_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/validator/validator_helper.dart';
import 'package:iconsax/iconsax.dart';

class CreateNewAddress extends StatelessWidget {
  const CreateNewAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;

    return Scaffold(
      appBar: const MyAppBar(
        title: Text("Add new Address"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: controller.addressFormKey,
              child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                validator:(value)=> ValidatorHelper.validateEmptyString("Name", value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.user),
                  labelText: "Name",
                ),
              ),
              const SizedBox(
                height: Sizes.spaceBtwInputField,
              ),
              TextFormField(
                controller: controller.phoneNumber,
                validator:(value)=> ValidatorHelper.validatorPhone(value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  labelText: "Phone Number",
                ),
              ),
              const SizedBox(
                height: Sizes.spaceBtwInputField,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.street,
                validator:(value)=> ValidatorHelper.validateEmptyString("Street", value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building_31),
                        labelText: "Street",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.postalCode,
                validator:(value)=> ValidatorHelper.validateEmptyString("PostalCode", value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.code),
                        labelText: "Postal Code",
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: Sizes.spaceBtwInputField,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.city,
                validator:(value)=> ValidatorHelper.validateEmptyString("City", value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.building),
                        labelText: "City",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: controller.state,
                validator:(value)=> ValidatorHelper.validateEmptyString("State", value),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.activity),
                        labelText: "State",
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: Sizes.spaceBtwInputField,
              ),
              TextFormField(
                controller: controller.country,
                validator:(value)=> ValidatorHelper.validateEmptyString("Country", value),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.global),
                  labelText: "Country",
                ),
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
               SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: ()=> controller.addNewAddress(), child: const Text("Save")))
            ],
          )),
        ),
      ),
    );
  }
}

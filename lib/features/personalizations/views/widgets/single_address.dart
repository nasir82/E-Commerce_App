import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/data/repositories/address/address_model.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/address_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SingleAddress extends StatelessWidget {
  const SingleAddress({super.key, required this.address, required this.onTap});
  final AddressModel address;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    final controller = AddressController.instance;

    return Obx(
      (){

        final selectedAddressId = controller.selectedAddress.value.id;
        final selectedAddress = address.id == selectedAddressId;

        return InkWell(
        onTap: onTap,
        child: MyCirculerContainer(
          width: double.infinity,
          showBorder: true,
          padding: const EdgeInsets.all(Sizes.md),
          backgroundColor:
              selectedAddress ? MyColor.primaryColor.withOpacity(0.5) : Colors.transparent,
          borderColor: selectedAddress
              ? Colors.transparent
              : dark
                  ? MyColor.darkerGrey
                  : MyColor.grey,
          margin: const EdgeInsets.only(bottom: 16),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 5,
                child: Icon(
                  selectedAddress ? Iconsax.tick_circle5 : null,
                  color: selectedAddress
                      ? dark
                          ? MyColor.light
                          : MyColor.dark
                      : null,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: Sizes.sm / 2,
                  ),
                  Text(
                    address.phoneNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: Sizes.sm / 2,
                  ),
                  Text(
                    address.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: Sizes.sm / 2,
                  ),
                ],
              )
            ],
          ),
        ),
      );
      }
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/address_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class BillingAddress extends StatelessWidget {
  const BillingAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Obx(
      ()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(
            title: "Shipping address",
            buttonTitle: "Change",
            isShowButton: true,
            onPressed: () => controller.selectNewAddressPopup(context),
          ),
          if (controller.selectedAddress.value.id.isNotEmpty) Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.selectedAddress.value.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.phone,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(
                      width: Sizes.spaceBtwItems,
                    ),
                    Text(
                      controller.selectedAddress.value.phoneNumber,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems / 2,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_history,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(
                      width: Sizes.spaceBtwItems,
                    ),
                    Expanded(
                        child: Text(
                      controller.selectedAddress.value.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ))
                  ],
                ),
              ],
            )
           else Text("Select address")
        ],
      ),
    );
  }
}

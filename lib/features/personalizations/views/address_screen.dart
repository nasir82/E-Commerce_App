import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/new_address.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/widgets/single_address.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/address_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddressController());
    return Scaffold(
      appBar: const MyAppBar(
        title: Text("My Address"),
        showBackArrow: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const CreateNewAddress()),
        backgroundColor: MyColor.primaryColor,
        child: const Icon(
          Iconsax.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Obx(
              ()=> FutureBuilder(
                key: Key(controller.refreshData.value.toString()),
                  future: controller.allUserAddresses(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // should be replace by horizontal shimmer
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
              
                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    }
                    final addresses = snapshot.data!;
              
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: addresses.length,
                        itemBuilder: (_, index) {
                          return SingleAddress(address: addresses[index],onTap: ()=> controller.selectAddress(addresses[index]),);
                        });
                  }),
            )),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/widgets/settings_menu.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/widgets/user_profile_tile.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/views/cart/cart.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/header_container.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/views/order/order_screen.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/address_screen.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {

    final controller  = CartController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
                child: Column(
              children: [
                MyAppBar(
                  title: Text(
                    "Account",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),

                //user profile card

                const UserProfileTile(),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
              ],
            )),
             Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  //
                  const SectionHeading(title: "Account setting"),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                   SettingMenu(
                      icon: Iconsax.activity,
                      title: "Address",
                      subtitle: "subtitle",
                      onTap: ()=> Get.to(()=> const UserAddressScreen()),),
                   SettingMenu(
                      icon: Iconsax.activity,
                      title: "My Cart",
                      subtitle: "subtitle",
                      onTap: ()=> Get.to(()=> const MyCart()),
                      ),
                   SettingMenu(
                      icon: Iconsax.activity,
                      title: "My Order",
                      subtitle: "subtitle",
                      onTap: ()=> Get.to(()=> const OrderScreen()),),
                  const SettingMenu(
                      icon: Iconsax.activity,
                      title: "Bank Account",
                      subtitle: "subtitle"),
                  const SettingMenu(
                      icon: Iconsax.activity,
                      title: "My Coupons",
                      subtitle: "subtitle"),
                  const SettingMenu(
                      icon: Iconsax.activity,
                      title: "Notifications",
                      subtitle: "subtitle"),
                  const SettingMenu(
                      icon: Iconsax.activity,
                      title: "Acount Privacy",
                      subtitle: "subtitle"),

                 const SectionHeading(title: "App Settings") ,    
                    SettingMenu(
                      icon: Iconsax.activity,
                      title: "Load Data",
                      subtitle: "subtitle",
                      onTap: () => controller.loadDummyData(),
                     ),
                   const SettingMenu(
                      icon: Iconsax.activity,
                      title: "Geolocation",
                      subtitle: "subtitle",
                      trailing: Iconsax.toggle_off,),
                   const SettingMenu(
                      icon: Iconsax.activity,
                      title: "Safe mode",
                      subtitle: "subtitle",
                      trailing: Iconsax.toggle_off,),
                   const SettingMenu(
                      icon: Iconsax.activity,
                      title: "HD Image Quality",
                      subtitle: "subtitle",
                      trailing: Iconsax.toggle_off,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: ()=>UserController.instance.deleteAccountWarnigPopup(), child: const Text("Close account")),
                )
                      
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



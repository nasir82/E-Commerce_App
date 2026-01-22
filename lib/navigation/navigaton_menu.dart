
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/views/home.dart';
import 'package:flutter_e_commerce_app/features/store/store.dart';
import 'package:flutter_e_commerce_app/features/shop/views/wish_list/wish_list.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/settings.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    final controller = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          backgroundColor: dark ? MyColor.dark: MyColor.white,
          indicatorColor: dark ? MyColor.white.withOpacity(0.1): MyColor.black.withOpacity(0.1),
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=> controller.selectedIndex.value = index,
          destinations:
          const [
        
              NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
              NavigationDestination(icon: Icon(Iconsax.shop), label: 'Store'),
              NavigationDestination(icon: Icon(Iconsax.heart), label: 'Wishlist'),
              NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile')
        ],),
        
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{

  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    
    const HomeScreen(),
    const Store(),
    const WishList(),
    const Settings()
    ];
}
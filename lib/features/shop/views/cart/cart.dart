import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/loader/animation_loader.dart';
import 'package:flutter_e_commerce_app/features/shop/views/cart/widget/cart_items.dart';
import 'package:flutter_e_commerce_app/features/shop/views/checkout/checkout.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/navigation/navigaton_menu.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = HelperFunctions.isDarkMood(context);
    final controller = CartController.instance;

    return Scaffold(
      appBar: const MyAppBar(
        title: Text("Cart"),
        showBackArrow: true,
      ),
      body: Obx(() {
        // empty animation

        final emptyAnimation = AnimationLoaderWidget(
          text: "Your cart is empty.",
          animation: ImageString.successLotie,
          showAction: true,
          actionText: "Let's fill it",
          onActionClick: (){ 
            Get.off(() => const NavigationMenu());}
        );
        if (controller.cartItems.isEmpty) {
          return emptyAnimation;
        } else {
          return  const SingleChildScrollView(
            child: Padding(
            padding: EdgeInsets.all(Sizes.defaultSpace),
            child: CartItems(),
                    ),
          );
        }
      }),
      bottomNavigationBar:
      controller.cartItems.isEmpty?
      const SizedBox()
      :Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => const Checkout()),
            child:  Obx(()=> Text("Checkout \$${controller.totalCartPrice.value}"))),
      ),
    );
  }
}

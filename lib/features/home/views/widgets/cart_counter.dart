import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/shop/views/cart/cart.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({
    super.key,
    required this.iconColor,
    this.counterBgColor,
    this.counterTextColor
  });
  final Color? iconColor,counterBgColor, counterTextColor;
 

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());

    return Stack(children: [
      IconButton(
          onPressed: ()=> Get.to(()=> const MyCart()),
          icon: Icon(
            Iconsax.shopping_bag,
            color: iconColor,
          )),
      Positioned(
        right: 0,
        child: Container(
          height: 18,
          width: 18,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: MyColor.black.withOpacity(0.6)),
          child:  Center(
            child: Obx(()=> Text(controller.noOfCartItems.value.toString(), style: const TextStyle(color: MyColor.white))),
          ),
        ),
      )
    ]);
  }
}

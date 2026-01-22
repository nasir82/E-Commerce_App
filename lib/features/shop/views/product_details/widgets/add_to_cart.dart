import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/custom_shapes/circle_icon.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key,required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: Sizes.defaultSpace / 2, horizontal: Sizes.defaultSpace),
      decoration: BoxDecoration(
          color: dark ? MyColor.darkerGrey : MyColor.light,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.cardRadiusLg),
            topRight: Radius.circular(Sizes.cardRadiusLg),
          )),
      child: Obx(
        ()=> Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Row(
                children: [
                   CirculerIcon(
                    icon: Iconsax.minus,
                    height: 40,
                    width: 40,
                    backgroundColor: MyColor.darkGrey,
                    color: MyColor.white,
                    onTap:()=> controller.productQuantityInCart.value< 1 ? null : controller.productQuantityInCart.value -=1,
                  ),
                  const SizedBox(
                    width: Sizes.spaceBtwItems,
                  ),
                  Text(
                    controller.productQuantityInCart.value.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    width: Sizes.spaceBtwItems,
                  ),
                   CirculerIcon(
                    icon: Iconsax.add,
                    height: 40,
                    width: 40,
                    backgroundColor: MyColor.black,
                    color: MyColor.white,
                     onTap:()=> controller.productQuantityInCart.value +=1,
                  ),
                ],
              ),
            
            Obx(
              ()=> ElevatedButton(
              onPressed: controller.productQuantityInCart.value < 1 ? null : ()=> controller.addToCart(product),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(Sizes.md),
                backgroundColor: MyColor.black,
                side: const BorderSide(color: MyColor.black)
              ),
               child:  Text("Add to Cart",style: Theme.of(context).textTheme.bodyMedium,)),
            ),
          ],
        ),
      ),
    );
  }
}

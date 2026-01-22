import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_price_text.dart';
import 'package:flutter_e_commerce_app/features/shop/views/cart/widget/cart_item.dart';
import 'package:flutter_e_commerce_app/features/shop/views/cart/widget/ProductQuantityWithAddRemove.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/state_manager.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    this.showButtons = true
  });
  final bool showButtons;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    return Obx(
      ()=> ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(
          height: Sizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (_, index) =>  Obx(
          (){ 
            final item = controller.cartItems[index];
            return Column(
            children: [
               CartItem(item:item),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
             showButtons ?  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 70,),
                      ProductQuantityWithAddRemove(quaitity: item.quantity,add:()=> controller.addOneToCart(item),remove: () => controller.removeOneFromCart(item),),
                    ],
                  ),
                  
                  ProductPriceText(price: (item.price * item.quantity).toStringAsFixed(1),)
                ],
              ):const SizedBox(height: 1,),
            ],
          );}
        ),
      ),
    );
  }
}

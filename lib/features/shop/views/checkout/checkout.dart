import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/shop/views/cart/widget/cart_items.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/shop/views/checkout/widgets/billing_address.dart';
import 'package:flutter_e_commerce_app/features/shop/views/checkout/widgets/billingpayment.dart';
import 'package:flutter_e_commerce_app/features/shop/views/checkout/widgets/billing_amount.dart';
import 'package:flutter_e_commerce_app/features/shop/views/checkout/widgets/cupon.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/order_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:flutter_e_commerce_app/utils/helpers/pricing_calculator.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:get/get.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    final controller = CartController.instance;
    final subtotal = controller.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          "Checkout",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              const CartItems(
                showButtons: false,
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              // kupons

              CuponCode(dark: dark),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              MyCirculerContainer(
                showBorder: true,
                padding: const EdgeInsets.all(Sizes.md),
                backgroundColor: dark ? MyColor.darkerGrey : MyColor.light,
                child: const Column(
                  children: [
                    //pricing
                    BillingAmount(),
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    //Diveder
                    Divider(),
                    SizedBox(
                      height: Sizes.spaceBtwItems / 2,
                    ),
                    // payment method
                    Billingpayment(),
                    // address
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    BillingAddress()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ElevatedButton(
            onPressed: subtotal > 0 ? () => orderController.processOrder(subtotal)
            : ()=> Loaders.warnigSnackbar(title: "Empty Cart",message: "Add items to the cart in order to process."),
            
            //  Get.to(() => SuccessScreen(
            //       image: ImageString.successLotie,
            //       title: TextString.successTitle,
            //       subtitle: TextString.successSubtitle,
            //       onPressed: () {},
            //     )),

            child: Text(
                "Checkout \$${MyPricingCalculator.calculateTotalPrice(subtotal, "US")}")),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/pricing_calculator.dart';

class BillingAmount extends StatelessWidget {
  const BillingAmount({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    final subTotal = controller.totalCartPrice.value;

    return  Column(
      children: [
    
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("subtotal",style: Theme.of(context).textTheme.bodyMedium,),
            Text("\$$subTotal",style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems/2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping",style: Theme.of(context).textTheme.bodyMedium,),
            Text("\$${MyPricingCalculator.calculateShippingCost(subTotal,"US")}",style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems/2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tax",style: Theme.of(context).textTheme.bodyMedium,),
            Text("\$${MyPricingCalculator.calculateTax(subTotal,"US")}",style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems/2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order total",style: Theme.of(context).textTheme.bodyMedium,),
            Text("\$${MyPricingCalculator.calculateTotalPrice(subTotal,"US")}",style: Theme.of(context).textTheme.titleMedium,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems/2,),
       
    
    
      ],
    );
  }
}
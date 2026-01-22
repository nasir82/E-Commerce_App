import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/checkout_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/payment_method_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Billingpayment extends StatelessWidget {
  
  const Billingpayment({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    final controller = CheckoutController.instance;
    return  Column(
      children: [
        SectionHeading(title: "Payment method",isShowButton: true,buttonTitle: "Change",onPressed: ()=> controller.selectPaymentMethod(context),),
        const SizedBox(height: Sizes.spaceBtwItems/2,),
        Obx(
          ()=> Row(
            children: [
               MyCirculerContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? MyColor.light:MyColor.white,
              padding: const EdgeInsets.all(Sizes.sm),
              child:  Image(image: AssetImage(controller.selectedPaymentMethod.value.image),fit: BoxFit.contain,),
            ),
            SizedBox(width: Sizes.spaceBtwItems/2,),
            Text(controller.selectedPaymentMethod.value.name,style: Theme.of(context).textTheme.bodyLarge,),
            ],
          ),
        )
      ],
    );
  }
}

class PaymentTile extends StatelessWidget {
  const PaymentTile({
    super.key,
    required this.paymentMethod
  });

  final PaymentMethodModel paymentMethod;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    final controller = CheckoutController.instance;

    return ListTile(
          contentPadding: const EdgeInsets.all(0),
          onTap: (){
            controller.selectedPaymentMethod.value = paymentMethod;
            Get.back();
          },
          leading:  MyCirculerContainer(
            width: 60,
            height: 35,
            backgroundColor: dark ? MyColor.light:MyColor.white,
            padding: const EdgeInsets.all(Sizes.sm),
            child:  Image(image: AssetImage(controller.selectedPaymentMethod.value.image),fit: BoxFit.contain,),
          ),
          
          title:  Text(paymentMethod.name,style: Theme.of(context).textTheme.bodyLarge,),
         trailing: const Icon(Iconsax.arrow_right_34),
    );
  }
}
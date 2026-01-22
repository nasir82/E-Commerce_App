import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/views/checkout/widgets/billingpayment.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/payment_method_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController{
static CheckoutController get instance => Get.find();

Rx<PaymentMethodModel> selectedPaymentMethod = PaymentMethodModel.empty().obs;


@override
void onInit() {
    selectedPaymentMethod.value = PaymentMethodModel(name: "Paypal", image: "assets/icons/paypal.png");
    super.onInit();
  }

Future<dynamic> selectPaymentMethod(BuildContext context){
  return showModalBottomSheet(context: context,
   builder: (_) => SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(Sizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(title: "Select Payment Method", isShowButton: false,),
          const SizedBox(height: Sizes.spaceBtwSections,),
          PaymentTile(paymentMethod:PaymentMethodModel(name: "Paypal", image: "assets/icons/paypal.png")),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          PaymentTile(paymentMethod:PaymentMethodModel(name: "Google Pay", image: "assets/icons/googlepay.png")),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          PaymentTile(paymentMethod:PaymentMethodModel(name: "Apple Pay", image: "assets/icons/applepay.png")),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          PaymentTile(paymentMethod:PaymentMethodModel(name: "Master Card", image: "assets/icons/visa.png")),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          PaymentTile(paymentMethod:PaymentMethodModel(name: "Paytm", image: "assets/icons/paytm.png")),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          PaymentTile(paymentMethod:PaymentMethodModel(name: "Paystack", image: "assets/icons/paypal.png")),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          PaymentTile(paymentMethod:PaymentMethodModel(name: "Credit Card", image: "assets/icons/card.png")),
          const SizedBox(height: Sizes.spaceBtwItems/2,),
          const SizedBox(height: Sizes.spaceBtwSections,),
        ],
      ),
    ),
   )
   
   );
}
}
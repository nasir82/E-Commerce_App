import 'package:flutter_e_commerce_app/features/personalizations/controllers/address_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/checkout_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/variation_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(VariationController());
    Get.put(CheckoutController());
    Get.put(AddressController());
    
  }
}
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/data/repositories/order/order_repository.dart';
import 'package:flutter_e_commerce_app/env/env.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/succes_screen.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/address_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/checkout_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/order_model.dart';
import 'package:flutter_e_commerce_app/navigation/navigaton_menu.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/popup/full_screenloader.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instanc => Get.find();

// variables

  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepo = Get.put(OrderRepository());

// fetch users order history
  Future<List<OrderModel>> fetchUserOrders() async {
    try {
      final userOrders = await orderRepo.fetchUserOrders();
      return userOrders;
    } catch (e) {
      Loaders.warnigSnackbar(title: "title", message: e.toString());
      return [];
    }
  }
// add method for order processing
void processOrder(double totalAmount) async {
  try {
    // Show the loading dialog
    FullScreenloader.openLoadingDialogue(
        "Processing your order", ImageString.successLotie);

    final userId = AuthenticationRepository.instance.authUser?.uid;
    if (userId == null || userId.isEmpty) {
      throw Exception("User is not authenticated.");
    }

    // Initialize SSLCommerz
    Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
            multi_card_name: "visa,master,bkash",
            currency: SSLCurrencyType.BDT,
            product_category: "Food",
            sdkType: SSLCSdkType.TESTBOX,
            store_id: storeId,
            store_passwd: storePassword,
            total_amount: totalAmount,
            tran_id: "transaction1234"));

    // Execute the payment process
    final response = await sslcommerz.payNow();
    FullScreenloader.stopLoading();

    // Log the full response for debugging
    print("SSLCommerz Response: ${response.toJson()}");

    // Handle response status
    switch (response.status) {
      case "VALID":
        print("Payment is valid. Proceeding to create an order.");
        
        final order = OrderModel(
          id: UniqueKey().toString(),
          userId: userId,
          status: OrderStatus.pending,
          items: cartController.cartItems.toList(),
          totalAmount: totalAmount,
          orderDate: DateTime.now(),
          paymentMethod: checkoutController.selectedPaymentMethod.value.name,
          address: addressController.selectedAddress.value,
          deliveryDate: DateTime.now().add(const Duration(days: 5)),
        );

        // Save the order
        await orderRepo.saveOrder(order, userId);

        // Clear the cart
        cartController.clear();

        // Navigate to the success screen
        Get.off(() => SuccessScreen(
            image: ImageString.successLotie,
            title: "Payment Success",
            subtitle: "Your item will be shipped soon.",
            onPressed: () => Get.offAll(() => const NavigationMenu())));
        break;

      case "FAILED":
        print("Payment failed. Showing error message.");
        Loaders.errorSnackbar(
            title: "Payment Failed", message: "Transaction could not be completed. Please try again.");
        break;

      case "closed":
        break;

      case "PROCESSING":
        FullScreenloader.openLoadingDialogue("transaction...",ImageString.successLotie);

      default:
        print("Unhandled payment status: ${response.status}");
        Loaders.errorSnackbar(
            title: "Payment Error",
            message: "An unexpected error occurred. Status: ${response.status}");
        break;
    }
  } catch (e) {
    print("On exectionss");
    FullScreenloader.stopLoading();
    print("Error occurred during payment processing: $e");
    Loaders.errorSnackbar(
        title: "Processing Error", message: "An error occurred: ${e.toString()}");
  } finally {
    // Ensure the loader is stopped in all cases
    FullScreenloader.stopLoading();
  }
}


  // void processOrder(double totalAmount) async {
  //   try {
  //     FullScreenloader.openLoadingDialogue(
  //         "Processing your order", ImageString.successLotie);
  //     final userId = AuthenticationRepository.instance.authUser!.uid;
  //     if (userId.isEmpty) return;

  //     Sslcommerz sslcommerz = Sslcommerz(
  //         initializer: SSLCommerzInitialization(
  //             //   ipn_url: "www.ipnurl.com",
  //             multi_card_name: "visa,master,bkash",
  //             currency: SSLCurrencyType.BDT,
  //             product_category: "Food",
  //             sdkType: SSLCSdkType.TESTBOX,
  //             store_id: "quant678e8b17194ce",
  //             store_passwd: "quant678e8b17194ce@ssl",
  //             total_amount: totalAmount,
  //             tran_id: "transaction1234"));
     
  //     final response = await sslcommerz.payNow();
  //      FullScreenloader.stopLoading();
  //     if(response.status == "VALID"){
  //            final order = OrderModel(
  //         id: UniqueKey().toString(),
  //         userId: userId,
  //         status: OrderStatus.pending,
  //         items: cartController.cartItems.toList(),
  //         totalAmount: totalAmount,
  //         orderDate: DateTime.now(),
  //         paymentMethod: checkoutController.selectedPaymentMethod.value.name,
  //         address: addressController.selectedAddress.value,
  //         deliveryDate: DateTime.now().add(Duration(days: 5)));
  //     // save order
  //     await orderRepo.saveOrder(order, userId);
  //     // update cart
  //     cartController.clear(); 
  //     Get.off(() => SuccessScreen(
  //          image: ImageString.successLotie,
  //          title: "Payment success",
  //          subtitle: "Your item will be shipped soon",
  //          onPressed: () => Get.offAll(() => const NavigationMenu())));
  //     }else{
          
  //     }

  //     // show success screen
  //     // Get.off(() => SuccessScreen(
  //     //     image: ImageString.successLotie,
  //     //     title: "Payment success",
  //     //     subtitle: "Your item will be shipped soon",
  //     //     onPressed: () => Get.offAll(() => const NavigationMenu())));
  //   } catch (e) {
  //      FullScreenloader.stopLoading();
  //     Loaders.errorSnackbar(title: "title", message: e.toString());
  //   }
  // }
}

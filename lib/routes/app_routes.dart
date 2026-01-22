import 'package:flutter_e_commerce_app/features/shop/views/cart/cart.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/login.dart';
import 'package:flutter_e_commerce_app/features/home/views/home.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/onboarding.dart';
import 'package:flutter_e_commerce_app/features/shop/views/order/order_screen.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/product_review.dart';
import 'package:flutter_e_commerce_app/features/store/store.dart';
import 'package:flutter_e_commerce_app/features/shop/views/wish_list/wish_list.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/sign_up.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/verify_email.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/address_screen.dart';
import 'package:flutter_e_commerce_app/features/shop/views/checkout/checkout.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/profile.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/settings.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/forgot_password.dart';
import 'package:flutter_e_commerce_app/routes/routes.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final pages = [
      GetPage(name: MyRoutes.home, page: ()=> const HomeScreen()),
      GetPage(name: MyRoutes.store, page: ()=> const Store()),
      GetPage(name: MyRoutes.favourites, page: ()=> const WishList()),
      GetPage(name: MyRoutes.settings, page: ()=> const Settings()),
     // GetPage(name: MyRoutes.productDetails, page: ()=>  ProductDetailsScreen(product: ProductModel.empty(),)),
      GetPage(name: MyRoutes.productReviews, page: ()=> const ReviewAndRatings()),
      GetPage(name: MyRoutes.order, page: ()=> const OrderScreen()),
      GetPage(name: MyRoutes.checkout, page: ()=> const Checkout()),
      GetPage(name: MyRoutes.cart, page: ()=> const MyCart()),
      GetPage(name: MyRoutes.userProfile, page: ()=> const ProfileScreen()),
      GetPage(name: MyRoutes.userAddress, page: ()=> const UserAddressScreen()),
      GetPage(name: MyRoutes.signup, page: ()=> const SignUpScreen()),
      GetPage(name: MyRoutes.verifyEmail, page: ()=> const VerifyEmailScreem()),
      GetPage(name: MyRoutes.signIn, page: ()=> const LoginScreen()),
      GetPage(name: MyRoutes.forgetPassword, page: ()=> const ForgetPassword()),
      GetPage(name: MyRoutes.onBoarding, page: ()=> const OnBoardingScreen())
  ];
}
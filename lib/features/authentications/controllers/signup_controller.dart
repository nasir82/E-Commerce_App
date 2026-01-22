import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/models/user_model.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/verify_email.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/popup/full_screenloader.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get intance => Get.find();

  //variable
  final isShow = true.obs;
  final privacy = true.obs;
  final TextEditingController email = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  GlobalKey<FormState> signUpFormkey = GlobalKey<FormState>();

  // Signup

  void signUp() async {
    try {
      /// start loading
      FullScreenloader.openLoadingDialogue(
          "we are processing your information as you called", ImageString.simpleLottie1);

      /// check internet connectivity
      //final isConnected = await NetworkM
      /// form validation
      if (!signUpFormkey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }

      /// policy check
      if (!privacy.value) {
        Loaders.warnigSnackbar(
            title: "Accept Privacy policy",
            message:
                "In order to creat an account you must have read and accept Privacy policy and terms of use");

        return;
      }

      /// register and save info
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailandPassword(
              email.text.trim(), password.text.trim());
      final user = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');
      final userRepo = Get.put(UserRepository());
      await userRepo.saveUserInfo(user);

       FullScreenloader.stopLoading();

      /// show success message
      Loaders.succesSnackbar(
          title: "Congratulation",
          message: 'Your account has been created! Verify your email.');

      /// move to verify email
      Get.to(() =>  VerifyEmailScreem(email:email.text.trim() ,));
    } catch (e) {
       FullScreenloader.stopLoading();
      Loaders.errorSnackbar(title: "oh no!", message: e.toString());
    }
  }
}

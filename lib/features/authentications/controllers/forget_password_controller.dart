import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/reset_password.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/popup/full_screenloader.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  Future<void> sentPasswordResetEmail()async{
      try {
        FullScreenloader.openLoadingDialogue("Sending email to $email", ImageString.successLotie);

        if(!forgetPasswordFormKey.currentState!.validate()){
            FullScreenloader.stopLoading();
            return;
        }
        await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());
        
        FullScreenloader.stopLoading();

        Loaders.succesSnackbar(title: "Email sent",message: "Email link has been sent to your account");

        Get.to(()=> ResetPassword(email: email.text.trim()));
      } catch (e) {
        FullScreenloader.stopLoading();
        Loaders.errorSnackbar(title: "opss", message: e.toString());
      }
  }
  Future<void> resendPasswordResetEmail(String email)async{
  try {
        FullScreenloader.openLoadingDialogue("Sending email to $email", ImageString.successLotie);

        await AuthenticationRepository.instance.sendPasswordResetEmail(email);
        FullScreenloader.stopLoading();

        Loaders.succesSnackbar(title: "Email sent",message: "Email link has been sent to your account");

      } catch (e) {
        FullScreenloader.stopLoading();
        Loaders.errorSnackbar(title: "opss", message: e.toString());
      }
  }

}
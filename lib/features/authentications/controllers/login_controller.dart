import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/popup/full_screenloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final rememberMe = true.obs;
  final isShowPassword = true.obs;
  @override
  onInit() {
    email.text = localStorage.read("rememberemail") ?? '';
    password.text = localStorage.read("rememberpassword") ?? '';
    super.onInit();
  }

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userController = Get.put(UserController());

  Future<void> signInWithEmailAndPassword() async {
    try {
      FullScreenloader.openLoadingDialogue(
          "You are logging in...", ImageString.successLotie);

      if (!loginFormKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }
      //save if remember is on
      if (rememberMe.value) {
        localStorage.write("rememberemail", email.text.trim());
        localStorage.write("rememberpassword", password.text.trim());
      }

      //login
       await AuthenticationRepository.instance
          .logInWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      FullScreenloader.stopLoading();
      AuthenticationRepository.instance.screenRedirect();
      
    } catch (e) {
      FullScreenloader.stopLoading();
      Loaders.errorSnackbar(title: "Error occured", message: e.toString());
      print("\n\n\n\n\n\n ######################");
      print(e.toString()); 
    }
  }

  Future<void> googleSignIn() async {
    try {
      FullScreenloader.openLoadingDialogue(
          "Loging you ...", ImageString.successLotie);

      // final credential =
      //     await AuthenticationRepository.instance.signInWithGoogle();

      //save the record
     // await userController.saveUserRecord(credential);

      FullScreenloader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenloader.stopLoading();
      Loaders.errorSnackbar(title: "error", message: e.toString());
    }
  }
}

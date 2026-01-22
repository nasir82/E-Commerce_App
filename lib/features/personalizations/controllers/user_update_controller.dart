import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/profile.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/popup/full_screenloader.dart';
import 'package:get/get.dart';

class UpdateNameController extends GetxController {

  static UpdateNameController get instance => Get.find();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializedName();
  }
  Future<void> initializedName()async{
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;

  }

  Future<void> updateUserName()async{
    try {
      FullScreenloader.openLoadingDialogue("Updating user name ", "animation");

      if (!updateUserNameKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }
      Map<String,dynamic> updatedName = {'FirstName': firstName.text.trim(),'LastName':lastName.text.trim()};
      //print("###### before called #####");
      await userRepository.updateSingleUserInfoField(updatedName);
     // print("###### after call called #####");
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();
      FullScreenloader.stopLoading();
      Loaders.succesSnackbar(title: "Congratulations",message: "Your name has been updated");
      Get.off(()=> const ProfileScreen());
    } catch (e) {
      FullScreenloader.stopLoading();
      Loaders.errorSnackbar(title: "oh no",message: e.toString());
      
    }
  }

}
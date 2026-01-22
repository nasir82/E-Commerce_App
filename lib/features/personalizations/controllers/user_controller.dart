import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/data/repositories/user/user_repository.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/login.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/models/user_model.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/re_authenticate_ui.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/popup/full_screenloader.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final hidePassword = false.obs;
  final isLoadingImage = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {

      final user = await userRepository.fetchUserInfo();
      this.user(user);
      this.user.refresh();
    } catch (e) {

      user(UserModel.empty());
    }
  }

  Future<void> saveUserRecord(UserCredential? credential) async {
    try {
      await fetchUserRecord();

      if (credential != null) {
        //
        final nameParts =
            UserModel.nameParts(credential.user?.displayName ?? '');
        final userName =
            UserModel.generateUserName(credential.user?.displayName ?? '');
        final user = UserModel(
            id: credential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            userName: userName,
            email: credential.user!.email ?? '',
            phoneNumber: credential.user!.phoneNumber ?? '',
            profilePicture: credential.user!.photoURL ?? '');

        await userRepository.saveUserInfo(user);
      }
    } catch (e) {
      Loaders.warnigSnackbar(
          title: "data not save",
          message: "Somethin went wrong while saving data");
    }
  }

  //delete account warning popup
  void deleteAccountWarnigPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(Sizes.md),
        title: "Delete account",
        middleText:
            "Are you sure you want to delete your account permanently? This action is not reversilbe and all of you r data will be removed permanently.",
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.lg),
              child: Text("Delete"),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text("Cancel")));
  }

  void deleteUserAccount() async {
    try {
      FullScreenloader.openLoadingDialogue("Processing..", "animation");

      final auth = AuthenticationRepository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        if (provider == 'google.com') {
         // await auth.signInWithGoogle();
          await auth.deleteAccount();
          FullScreenloader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          FullScreenloader.stopLoading();
          Get.to(() => const ReAuthenticateUi());
        }
      }
    } catch (e) {
      FullScreenloader.stopLoading();
      Loaders.warnigSnackbar(title: "Error!!", message: e.toString());
    }
  }

  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      FullScreenloader.openLoadingDialogue("Processing...", "animation");

      if (!reAuthFormKey.currentState!.validate()) {
        FullScreenloader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reauthenticateWithEmailAndPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRepository.instance.deleteAccount();
      FullScreenloader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenloader.stopLoading();
      Loaders.warnigSnackbar(title: "Error!!", message: e.toString());
    }
  }

  Future<void> uploadUserProfilePicture() async {

    try {
      
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512);
    if(image != null){
      isLoadingImage.value = true;
      final imageUrl = await userRepository.uploadImage("Users/Images/Profiles", image); 

      Map<String,dynamic> json ={
          'ProfilePicture': imageUrl
      };
      await userRepository.updateSingleUserInfoField(json);
      user.value.profilePicture = imageUrl;
      user.refresh();

      Loaders.succesSnackbar(title: "Congratulations",message: "Profile updated");
    }
    } catch (e) {
      Loaders.errorSnackbar(title: "Error!!",message: "Something went wrong try again");
    }finally{
      isLoadingImage.value = false;
    }
    
  }
}

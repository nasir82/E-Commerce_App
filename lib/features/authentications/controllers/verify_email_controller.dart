
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/features/authentications/views/succes_screen.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController{

  static VerifyEmailController get instance  => Get.find();

  /// send email and set timer
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  
  }

  //Send email verification link
  Future<void> sendEmailVerification()async{
    try{
        await AuthenticationRepository.instance.sendEmailVerificaton();
        Loaders.errorSnackbar(title: "Email sent",message: "Please check your inbox and verify email.");
    }catch(e){

      Loaders.errorSnackbar(title: "oh snap",message: e.toString());
    }
  }
  // Time to automatically redirect an Email verification
  void setTimerForAutoRedirect(){
    Timer.periodic(const Duration(seconds: 1), (callback)async{
     await FirebaseAuth.instance.currentUser?.reload();
     final user = FirebaseAuth.instance.currentUser;
     if(user?.emailVerified ?? false){
        callback.cancel();
        Get.off( SuccessScreen(
          image: ImageString.successLotie,
          title: TextString.successTitle,
          subtitle: TextString.successSubtitle,
          onPressed: (){},
        ));
     }
    });
  }
  // Manually check is email is verified
  Future<void> checkEmailVerificationStatus() async{
    final currentUser = FirebaseAuth.instance.currentUser;

    if(currentUser!=null && currentUser.emailVerified){
      Get.off(SuccessScreen(image: ImageString.successLotie, title: TextString.successTitle, subtitle: TextString.successSubtitle, onPressed: ()=> AuthenticationRepository.instance.screenRedirect));
    }
  }
}
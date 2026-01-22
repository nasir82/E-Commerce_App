import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class Loaders{

  static void hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

    static void customToast({required message}){
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              elevation: 0,
              duration:const Duration(seconds: 3),
              backgroundColor: Colors.transparent,
              content: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: HelperFunctions.isDarkMood(Get.context!) ? MyColor.darkerGrey : MyColor.grey
                ),
                child: Center(
                  child: Text(message,style: Theme.of(Get.context!).textTheme.labelLarge,),
                ),
              ))
        );
    }

    static void succesSnackbar({required title,message = '',duration=3}){
      Get.snackbar(
        title, 
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: MyColor.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Iconsax.check,color: Colors.white,)
      );
    }
    static void warnigSnackbar({required title,message = ''}){
      Get.snackbar(
        title, 
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: MyColor.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        duration:const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.warning_2,color: Colors.white,)
      );
    }
    static void errorSnackbar({required title,message = ''}){
      Get.snackbar(
        title, 
        message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: MyColor.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        duration:const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Iconsax.warning_2,color: Colors.white,)
      );
    }
}
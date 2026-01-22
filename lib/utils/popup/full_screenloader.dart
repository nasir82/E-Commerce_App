import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/loader/animation_loader.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';

class FullScreenloader {
  
  static void openLoadingDialogue(String text, String animation) {
  
    showDialog(context: Get.overlayContext!, 
    builder: (_)=> PopScope(
      canPop: false,
      child: Container(
          color: HelperFunctions.isDarkMood(Get.context!) ? MyColor.dark : MyColor.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250,),
              AnimationLoaderWidget(text: text, animation: animation)
            ],
          ),
      )));
  }

  static void stopLoading(){
    print("############################################\n stop called\n ###################");
    Navigator.of(Get.overlayContext!).pop();
  }
}

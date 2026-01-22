import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/verify_email_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';

class VerifyEmailScreem extends StatelessWidget {
  final String? email;
  const VerifyEmailScreem({super.key,this.email});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(VerifyEmailController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()=>AuthenticationRepository.instance.logOut(), icon:const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(

          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(

            children: [ 
            //image 
            Image(image: const AssetImage(ImageString.simpleLottie1),height: HelperFunctions.getScreenHeight()*.3,),

           const SizedBox(height: Sizes.spaceBtwSections,),
            //title
          Text(TextString.verificationTitle,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
            //subtitle
          const SizedBox(height: Sizes.spaceBtwItems,),
          Text(email ?? '',style: Theme.of(context).textTheme.labelLarge,textAlign: TextAlign.center,),
          
          const SizedBox(height: Sizes.spaceBtwItems,),
          Text(TextString.verificationSubtitle,style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
          const SizedBox(height: Sizes.spaceBtwSections,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: (){
              Get.to(()=>  controller.checkEmailVerificationStatus());
            }, child: const Text("Continue"))),
          const SizedBox(height: Sizes.spaceBtwItems,),
          SizedBox(
            width: double.infinity,
            child: TextButton(onPressed: ()=> controller.sendEmailVerification(), child: const Text("Resend email."))),
          
              ]  //button
          ),
        ),
      ),
    );
  }
}
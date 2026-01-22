import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/authentications/controllers/login_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
            border: Border.all(color: MyColor.grey)),
            child: IconButton(onPressed: ()=>controller.googleSignIn, icon: const Image(
              
              width: Sizes.iconmd,
              height: Sizes.iconmd,
              image: AssetImage('assets/icons/communication.png'))),
          ),
          const SizedBox(width: Sizes.spaceBtwItems,),
         Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),
            border: Border.all(color: MyColor.grey)),
            child: IconButton(onPressed: (){}, icon: const Image(
              
              width: Sizes.iconmd,
              height: Sizes.iconmd,
              image: AssetImage('assets/icons/search.png'))),
          ),
        ],
      ),
    );
  }

  
}


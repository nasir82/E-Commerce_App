import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/circuler_image.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/features/personalizations/views/profile.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading:   CirculerImage(
        image: controller.user.value.profilePicture,
        width: 60,
        height: 60,
        isNetworkImage: true,
        padding: EdgeInsets.zero,
        fit: BoxFit.cover,
      ),
      title: Obx(
        ()=> Text(
          controller.user.value.fullname,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: MyColor.white),
        ),
      ),
      subtitle: Obx(
         ()=> Text(
          controller.user.value.email,
          style:
              Theme.of(context).textTheme.bodyMedium!.apply(color: MyColor.white),
        ),
      ),
      trailing: IconButton(onPressed: () {
        Get.to( const ProfileScreen());
      }, icon: const Icon(Iconsax.edit)),
    );
  }
}

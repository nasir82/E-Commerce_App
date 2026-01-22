
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/cart_counter.dart';
import 'package:flutter_e_commerce_app/features/personalizations/controllers/user_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:get/get.dart';

class MyHomeAppBar extends StatelessWidget {
  const MyHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return MyAppBar(
      title: Column(
        children: [
          Text(
            TextString.appbarWishText,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: MyColor.grey),
          ),
         
          Obx(
            ()=> Text(
              controller.user.value.fullname,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: MyColor.white),
            ),
          )
        ],
      ),
      actions: const [
        CartCounter(
          iconColor: MyColor.white,
        )
      ],
    );
  }
}
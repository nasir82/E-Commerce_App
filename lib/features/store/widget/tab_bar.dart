import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/device/device_utils.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';

class MyTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MyTabBar({super.key, required this.tabs});

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    return Material(
      color: dark ? MyColor.black : MyColor.white,
      child: TabBar(
          isScrollable: true,
          indicatorColor: MyColor.primaryColor,
          labelColor: HelperFunctions.isDarkMood(context)
              ? MyColor.white
              : MyColor.primaryColor,
          tabs: tabs),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getStatusBarHeight());
}

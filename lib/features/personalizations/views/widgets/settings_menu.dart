import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle,
      this.trailing,
      this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final IconData? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: 28,
        color: MyColor.primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .apply(color: MyColor.primaryColor),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .apply(color: MyColor.primaryColor),
      ),
      trailing: IconButton(onPressed: () {}, icon:  Icon(trailing)),
    );
  }
}
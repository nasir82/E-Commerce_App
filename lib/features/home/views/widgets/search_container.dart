
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/device/device_utils.dart';
import 'package:iconsax/iconsax.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    required this.text,
    this.icon,
    required this.showBackground,
    required this.showBorder,
    this.padding = const EdgeInsets.all(Sizes.defaultSpace)
  });
  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: DeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(Sizes.md),
        decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(Sizes.cardRadiusLg),
            border: showBorder ? Border.all(color: MyColor.grey):null) ,
        child: Row(
          children: [
            const Icon(
              Iconsax.search_normal,
              color: MyColor.darkGrey,
            ),
            const SizedBox(
              width: Sizes.spaceBtwItems,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.apply(
                color: MyColor.darkerGrey
              ),
            )
          ],
        ),
      ),
    );
  }
}

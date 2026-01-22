import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_title.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class BrandTitleTextWithVerifiedIcon extends StatelessWidget {
  const BrandTitleTextWithVerifiedIcon({
    super.key,
    required this.title,
    this.textColor,
    this.maxLines = 1,
    this.iconColor = MyColor.primaryColor,
    this.textAlign = TextAlign.center,
    this.textSize = TextSizes.small,
  });
  final String title;
  final Color? textColor, iconColor;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes textSize;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BrandTitleText(
            title: title,
            textColor: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            textSize: textSize),
            const SizedBox(width: Sizes.xs,),
            Icon(Iconsax.verify5,color: iconColor,size: Sizes.iconxs,)
            ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/custom_shapes/circle_icon.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class ProductQuantityWithAddRemove extends StatelessWidget {
  const ProductQuantityWithAddRemove({
    super.key,
    required this.quaitity,
    this.add,
    this.remove
  });

  final int quaitity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         CirculerIcon(
          icon: Iconsax.minus,
          height: 40,
          width: 40,
          backgroundColor: MyColor.darkGrey,
          color: MyColor.white,
          onTap: remove,
        ),
        const SizedBox(
          width: Sizes.spaceBtwItems,
        ),
        Text(
          quaitity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: Sizes.spaceBtwItems,
        ),
         CirculerIcon(
          icon: Iconsax.add,
          height: 40,
          width: 40,
          backgroundColor: MyColor.black,
          color: MyColor.white,
          onTap: add,
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/verified_brand_title_text.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/circuler_image.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/brand_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({
    super.key,
    required this.brand,
    this.showBorder = true,
    this.onTap,
  });
  final BrandModel brand;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyCirculerContainer(
        padding: const EdgeInsets.all(Sizes.sm/2),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            Flexible(
              child: CirculerImage(
                isNetworkImage: true,
                image: brand.image,
                backgroundColor: Colors.transparent,
                overlayColor: HelperFunctions.isDarkMood(context)
                    ? MyColor.white
                    : MyColor.black,
              ),
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   BrandTitleTextWithVerifiedIcon(
                    title: brand.name,
                    textSize: TextSizes.large,
                  ),
                  Text(
                    '${brand.productCount ?? 0} products',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

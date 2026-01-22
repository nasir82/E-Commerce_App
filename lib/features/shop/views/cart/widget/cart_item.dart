
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_title.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/rounded_image.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/verified_brand_title_text.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/cart_item_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key, 
    required this.item
  });

  final CartItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    print(item.image ?? " null ");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedImage(
          imageUrl: item.image ?? '',
          isNetworkImage: true,
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(Sizes.sm),
          backgroundColor:  dark ?  MyColor.darkerGrey: MyColor.light,
        ),
        const SizedBox(
          width: Sizes.spaceBtwItems,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               BrandTitleTextWithVerifiedIcon(title: item.brandName ?? ''),
               BrandTitleText(title: item.title, maxLines: 1,),
             Text.rich(
              TextSpan(
                children:(item.selectedVariation ?? {}).entries.map((e)=> TextSpan(
                  children: [
                    TextSpan(text: e.key, style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: e.value, style: Theme.of(context).textTheme.bodyLarge),
                  ]
                )
                )
                .toList()
              )
             ),
             
            ],
          ),
        )
      ],
    );
  }
}
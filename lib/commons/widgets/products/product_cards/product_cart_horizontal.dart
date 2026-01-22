import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/rounded_image.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_title.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_title.dart';
import 'package:flutter_e_commerce_app/commons/styles/promo_slider.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/product_details.dart';
import 'package:flutter_e_commerce_app/commons/widgets/icons/favourite_icon/favourite_icon.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/product_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCartHorizontal extends StatelessWidget {
  const ProductCartHorizontal({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
     final controller = ProductController.instance;
    final salePercetage = controller.calculateSalePercentage(product.price, product.salePrice);
  
    final dark = HelperFunctions.isDarkMood(context);
    return GestureDetector(
      onTap: ()=> Get.to(()=>  ProductDetailsScreen(product: product,)),
      child: Container(
        width: 310,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [ShadowStyleCustom.vericalProductShadow],
            borderRadius: BorderRadius.circular(Sizes.productImageRadius),
            color: dark ? MyColor.darkerGrey : MyColor.softGrey),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyCirculerContainer(
              height: 120,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? MyColor.dark : MyColor.light,
              child: Stack(
                children: [
                   SizedBox(
                    height: 120,
                    width: 120,
                    child: RoundedImage(imageUrl: product.thumbnail,applyImageRadius: true,isNetworkImage: true,)),
                  Positioned(
                    top: 12,
                    child: MyCirculerContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.sm, vertical: Sizes.xs),
                      radius: Sizes.sm,
                      backgroundColor: MyColor.secondaryColor.withOpacity(0.8),
                      child: Text(
                        '\$$salePercetage',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: MyColor.black),
                      ),
                    ),
                  ),
                   Positioned(
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(productId: product.id,),
                  )
                ],
              ),
            ),
           
            SizedBox(
              width: 172,
              child: Padding(
                padding: const EdgeInsets.only(left: Sizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                     ProductTitle(
                      title: product.title,
                      isSmall: true,
                    ),
                    const SizedBox(
                      height: Sizes.xs,
                    ),
                     Row(
                      children: [
                        BrandTitleText(
                          title: product.brand == null ? " " : product.brand!.name,
                          textSize: TextSizes.small,
                        ),
                        const SizedBox(
                          height: Sizes.xs,
                        ),
                        const Icon(
                          Iconsax.verify5,
                          color: MyColor.primaryColor,
                          size: Sizes.iconxs,
                        )
                      ],
                    ),
                    //const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "\$35.5",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: MyColor.dark,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(Sizes.cardRadiusMd),
                                bottomRight: Radius.circular(Sizes.cardRadiusMd),
                              )),
                          child: const SizedBox(
                              height: Sizes.iconlg * 1.2,
                              width: Sizes.iconlg * 1.2,
                              child: Center(
                                  child: Icon(
                                Iconsax.add,
                                color: MyColor.white,
                              ))),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
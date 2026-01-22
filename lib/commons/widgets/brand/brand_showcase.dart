
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/data/repositories/product/brand_product.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/brand_model.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_card.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/shimmer.dart';
import 'package:get/get.dart';

class BrandShowCase extends StatelessWidget {
  const BrandShowCase({super.key, required this.images, required this.brand});
  final List<String> images;
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> Get.to(()=> BrandProducts(brand: brand)),
      child: MyCirculerContainer(
        showBorder: true,
        borderColor: MyColor.darkGrey,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.all(Sizes.md),
        margin: const EdgeInsets.only(bottom: Sizes.spaceBtwItems),
        child: Column(
          children: [
             BrandCard(
              showBorder: true,
              brand:brand,
            ),
            SizedBox(height: Sizes.spaceBtwItems/2,),
            Row(
                children: images
                    .map((image) => brandToProductImages(image, context))
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget brandToProductImages(String image, context) {
    return Expanded(
      child: MyCirculerContainer(
        height: 100,
        backgroundColor: HelperFunctions.isDarkMood(context)
            ? MyColor.darkerGrey
            : MyColor.light,
        margin: const EdgeInsets.only(right: Sizes.sm),
        padding: const EdgeInsets.all(Sizes.md),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: image,
            progressIndicatorBuilder: (context,url, erro)=> const MyShimmerEffect(height: 100, width: 100),
            errorWidget: (context,url,error)=> const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
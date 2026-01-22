import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/rounded_image.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/custom_shapes/custom_cliper.dart';
import 'package:flutter_e_commerce_app/commons/widgets/icons/favourite_icon/favourite_icon.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/product_image_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);
    final controller = Get.put(ImageController());
    final images = controller.getAllProductImages(product);
    return CustomShapeClipPath(
      child: Container(
        color: dark ? MyColor.darkerGrey : MyColor.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.productImageRadius),
                  child: Center(child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargeImage(image),
                      child: CachedNetworkImage(imageUrl: image,
                      progressIndicatorBuilder: (_,__,download)=> CircularProgressIndicator(value: download.progress,color: MyColor.primaryColor,),),
                    );
                  })),
                )),

            //image slider
            Positioned(
              bottom: 30,
              right: 0,
              left: Sizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Obx(
                      (){
                        final isSelected = controller.selectedProductImage.value == images[index];
                        return  RoundedImage(
                        imageUrl: images[index],
                        isNetworkImage: true,
                        width: 80,
                        border: isSelected ? Border.all(color: MyColor.primaryColor) : Border.all(color:Colors.transparent),
                        onPressed: ()=> controller.selectedProductImage.value = images[index],
                        backgroundColor: dark ? MyColor.dark : MyColor.white,
                        padding: const EdgeInsets.all(Sizes.sm),
                      );
                  }
                    );
                  },
                  itemCount: images.length,
                  separatorBuilder: (_, __) => const SizedBox(
                    width: Sizes.spaceBtwItems,
                  ),
                ),
              ),
            ),

             MyAppBar(
              showBackArrow: true,
              actions: [
                FavouriteIcon(productId: product.id,)
              ],
            )
          ],
        ),
      ),
    );
  }
}

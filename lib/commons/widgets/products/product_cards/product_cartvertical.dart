import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/rounded_image.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_title.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_title.dart';
import 'package:flutter_e_commerce_app/commons/styles/promo_slider.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/product_details.dart';
import 'package:flutter_e_commerce_app/commons/widgets/icons/favourite_icon/favourite_icon.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/cart_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/product_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key,required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercetage = controller.calculateSalePercentage(product.price, product.salePrice);
    final dark = HelperFunctions.isDarkMood(context);
    return GestureDetector(
      onTap: ()=> Get.to(()=>  ProductDetailsScreen(product: product,)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [ShadowStyleCustom.vericalProductShadow],
            borderRadius: BorderRadius.circular(Sizes.productImageRadius),
            color: dark ? MyColor.darkerGrey : MyColor.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyCirculerContainer(
              height: 120,
              width: 180,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? MyColor.dark : MyColor.light,
              child: Stack(
                children: [
                   Center(
                    child: RoundedImage(imageUrl: product.thumbnail,applyImageRadius: true,isNetworkImage: true,)),
                  Positioned(
                    top: 12,
                    child: MyCirculerContainer(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.sm, vertical: Sizes.xs),
                      radius: Sizes.sm,
                      backgroundColor: MyColor.secondaryColor.withOpacity(0.8),
                      child: Text(
                        "$salePercetage%",
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
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(left: Sizes.sm),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        title: product.brand!.name,
                        textSize: TextSizes.small,
                      ),
                     const SizedBox(
                        height: Sizes.xs,
                      ),
                      const Icon(
                        Iconsax.verify5,
                        color: MyColor.primaryColor,
                        size: Sizes.iconxs,
                      ),
                    ],
                  ),
                  //const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //price
                      //separate widget chilo
                      Flexible(
                        child: Column(
                          children: [
                            if(product.productType==ProductType.single.toString() && product.salePrice > 0)
                             Padding(
                              padding: const EdgeInsets.only(left: Sizes.sm),
                              child: Text(
                                controller.getProductPrice(product),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineMedium!.apply(
                                  decoration: TextDecoration.lineThrough
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: Sizes.sm),
                              child: Text(
                                controller.getProductPrice(product),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // add to cart
                      ProductCartAddToTheCartButton(product:product)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCartAddToTheCartButton extends StatelessWidget {
  const ProductCartAddToTheCartButton({
    super.key,
    required this.product
  });

  final ProductModel product;
  @override
  Widget build(BuildContext context) {

    final controller = CartController.instance;
    return InkWell(
      onTap: (){
        // if the product have variations then show the product details for variation selection
        //else add producat to the cart
        if(product.productType == ProductType.single.name){
            final cartItem = controller.convertToCartItem(product, 1);
            controller.addOneToCart(cartItem);
        }else{
            Get.to(()=> ProductDetailsScreen(product: product));
        }
      },
      child: Obx(
        (){
          final productQuantityInCart = controller. getProductQuantityInCart(product.id);
          return  Container(
          decoration:  BoxDecoration(
              color: productQuantityInCart > 0 ? MyColor.primaryColor : MyColor.dark,
              borderRadius:const BorderRadius.only(
                topLeft: Radius.circular(Sizes.cardRadiusMd),
                bottomRight: Radius.circular(Sizes.cardRadiusMd),
              )),
          child:  SizedBox(
              height: Sizes.iconlg * 1.2,
              width: Sizes.iconlg * 1.2,
              child: Center(
                  child:productQuantityInCart>0 ? Text(productQuantityInCart.toString(),style: Theme.of(context).textTheme.bodyLarge!.apply(color: MyColor.white),) : const Icon(
                Iconsax.add,
                color: MyColor.white,
              ))),
        );
  }
      ),
    );
  }
}
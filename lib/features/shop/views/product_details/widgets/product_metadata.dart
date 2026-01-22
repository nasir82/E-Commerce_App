import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_title.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/verified_brand_title_text.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/circuler_image.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/product_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';

class ProductMetada extends StatelessWidget {
  const ProductMetada({super.key,required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(product.price, product.salePrice);
  // final dark = HelperFunctions.isDarkMood(context);
    return Column(
      children: [
        //price
        Row(
          children: [
            MyCirculerContainer(
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.sm, vertical: Sizes.xs),
              radius: Sizes.sm,
              backgroundColor: MyColor.secondaryColor.withOpacity(0.8),
              child: Text(
                "$salePercentage%",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: MyColor.black),
              ),
            ),
            const SizedBox(
              width: Sizes.spaceBtwItems,
            ),

            if(product.productType==ProductType.single.toString() && product.salePrice>0)
            Text(
              "\$${product.price}",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            if(product.productType==ProductType.single.toString() && product.salePrice>0)
            const SizedBox(
              width: Sizes.spaceBtwItems,
            ),
            Text("${controller.getProductPrice(product)}\$", style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(
          height: Sizes.spaceBtwItems / 1.5,
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProductTitle(
              title: product.title,
              textALign: TextAlign.start,
            ),
          ],
        ),
        const SizedBox(
          height: Sizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            const ProductTitle(title: "Status:"),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            Text(
              controller.getProductStockStatus(product.stock),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(
          height: Sizes.spaceBtwItems / 1.5,
        ),

         Row(
          children: [
            CirculerImage(
              image: product.brand != null ? product.brand!.image : '',
              width: 32,
              height: 32,
              isNetworkImage: true,
            ),
          const  SizedBox(
              width: Sizes.spaceBtwItems,
            ),
            BrandTitleTextWithVerifiedIcon(
              title: product.brand != null ? product.brand!.name : '',
              textSize: TextSizes.medium,
            ),
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

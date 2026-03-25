import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/add_to_cart.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/product_attribute.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/product_image_slider.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/product_metadata.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/product_review.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/rating_and_share.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key,required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
   // final dark = HelperFunctions.isDarkMood(context);
    return Scaffold(
      bottomNavigationBar:  AddToCart(product: product,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //product image slider
             ProductImageSlider(product:product),
            //product details
            Padding(
              padding: const EdgeInsets.only(
                  right: Sizes.defaultSpace,
                  left: Sizes.defaultSpace,
                  bottom: Sizes.defaultSpace),
              child: Column(
                children: [
                  //rating and share
                  const RatingAndShare(),
                  
                  // price title stock brand
                   ProductMetada(product: product,),
                  //atribute

                  if(product.productType == "variable")
                   ProductAttribute(product: product,),

                  
                  if(product.productType != ProductType.variable.name)
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  // checkout button
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            print(product);
                          }, child: const Text("Checkout"))),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  //description
                   const SectionHeading(title: "Descriptions"),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                   ReadMoreText(
                      //"This is a Product description for blue nike sleeve less vest. There are more things thath can be added but i am happy with that.",
                      product.description != null ? product.description! : '',
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: "See more",
                      trimExpandedText: "less",
                      moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800
                      ),
                      lessStyle:  const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800
                      ),),
                  // reviews
                  const Divider(),
                  const SizedBox(height: Sizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SectionHeading(title: "Reviews(199)"),
                      IconButton(onPressed: (){
                        Get.to(()=> const ReviewAndRatings());
                      }, icon: const Icon(Icons.arrow_right,size: 32))
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwSections,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

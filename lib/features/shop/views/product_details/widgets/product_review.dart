import  'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/ratting/rating_indicator_bar.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/overall_product_ratings.dart';
import 'package:flutter_e_commerce_app/features/shop/views/product_details/widgets/user_review_card.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';

class ReviewAndRatings extends StatelessWidget {
  const ReviewAndRatings({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: const MyAppBar(title: Text("Review & Ratings"),showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and reviews are verified and are from people who use the same type of device that you use"),
              const SizedBox(height: Sizes.spaceBtwItems,),
              //overall product ratins
              const OverAllProductRating(),
              const MyRatingBarIndicator(rating: 4.5,),
              Text("12,201",style: Theme.of(context).textTheme.bodySmall,),
              const SizedBox(height: Sizes.spaceBtwSections,),


              //user riview list

              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard()
            ],
          ),
        ),
      ),
    );
  }
}


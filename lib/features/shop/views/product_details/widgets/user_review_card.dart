import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/ratting/rating_indicator_bar.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/image_strings.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMood(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(ImageString.products),
                  radius: 18,
                ),
                const SizedBox(
                  width: Sizes.spaceBtwItems,
                ),
                Text(
                  "Nasir",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(
          height: Sizes.spaceBtwItems,
        ),
        const Row(
          children: [
            MyRatingBarIndicator(rating: 4),
            SizedBox(
              width: Sizes.spaceBtwItems,
            ),
            Text("11 jul 2024")
          ],
        ),
        const SizedBox(
          height: Sizes.spaceBtwItems,
        ),
        const ReadMoreText(
          "The user interface of this app is quite intuitive. I was able to navigate and purchses seamlessly. Great job! Best of luck",
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: "Show more",
          trimCollapsedText: "show less",
        ),
        const SizedBox(
          height: Sizes.spaceBtwItems,
        ),
        MyCirculerContainer(
          backgroundColor: dark ? MyColor.darkerGrey : MyColor.grey,
          child: Padding(
            padding: const EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nasir",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text("11 jul 2024",
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                const ReadMoreText(
                  "The user interface of this app is quite intuitive. I was able to navigate and purchses seamlessly. Great job! Best of luck",
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: "Show more",
                  trimCollapsedText: "show less",
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Sizes.spaceBtwSections,)
      ],
    
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key, required this.title, required this.subtitle, required this.image});
  final String title;
  final String subtitle;
  final String image;
   

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.defaultSpace),
      child: Column(
        children: [
          Image(
            height: MediaQuery.of(context).size.height * .6,
            width: MediaQuery.of(context).size.width * .8,
            image:  AssetImage(image),
            fit: BoxFit.fill,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
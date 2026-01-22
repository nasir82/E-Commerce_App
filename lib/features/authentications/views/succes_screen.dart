import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/styles/spacing_style.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed});
  final String image, title, subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: SpacingStyle.paddingWithAppbarHeigh,
          child: SuccessWidget(
            title: title,
            subtitle:
                subtitle,
            image: image,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });
  final String image, title, subtitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(
          image: AssetImage(image),
          height: HelperFunctions.getScreenHeight() * .2,
        ),

        const SizedBox(
          height: Sizes.spaceBtwSections,
        ),
        //title
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
          style: Theme.of(context).textTheme.labelMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: Sizes.spaceBtwSections,
        ),
        SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: onPressed, child: const Text("Continue"))),
      ],
    );
  }
}

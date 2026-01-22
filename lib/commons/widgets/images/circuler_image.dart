import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/shimmer.dart';

class CirculerImage extends StatelessWidget {
  const CirculerImage({
    super.key,
    this.height = 56,
    this.width = 56,
    this.overlayColor,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    required this.image,
    this.padding = const EdgeInsets.all(Sizes.sm),
    this.isNetworkImage = false,
  });

  final double height;
  final double width;
  final Color? overlayColor;
  final Color? backgroundColor;
  final BoxFit? fit;
  final String image;
  final EdgeInsetsGeometry padding;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      decoration: BoxDecoration(
          color: backgroundColor ??
              (HelperFunctions.isDarkMood(context)
                  ? MyColor.white
                  : MyColor.black),
          borderRadius: BorderRadius.circular(100)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage && image.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: image,
                  fit: fit,
                  color: overlayColor,
                  progressIndicatorBuilder:
                      (context, url, downloadLoadProgress) =>
                          const MyShimmerEffect(height: 190, width: double.infinity,),
                          errorWidget: (context,url,error)=> const Icon(Icons.error),
                )
              : Image(
                  fit: fit,
                  image: AssetImage(image),
                  color: overlayColor),
        ),
      ),
    );
  }
}

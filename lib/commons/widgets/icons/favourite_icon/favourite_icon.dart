import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/custom_shapes/circle_icon.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/favourite_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});
  final String productId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return  Obx(()=>  CirculerIcon(
      icon: controller.isFavourite(productId) ? Iconsax.heart5 : Iconsax.heart,
      color: controller.isFavourite(productId) ? MyColor.error : null,
      onTap: ()=> controller.toggleFavouriteProduct(productId),
    ));
  }
}
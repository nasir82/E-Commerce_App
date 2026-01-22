import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/rounded_image.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/features/home/controller/banner_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/shimmer.dart';
import 'package:get/get.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    return Obx(
      (){
        if(controller.isLoading.value) return const MyShimmerEffect(height: 190, width: double.infinity);
        if(controller.banners.isEmpty) return const Center(child: Text("no data found"),);
         return Column(
        children: [
          CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) =>
                    controller.updatePageIndicator(index),
              ),
              items: controller. banners.map((e) => RoundedImage(imageUrl: e.imageUrl,isNetworkImage: true,onPressed:()=> Get.toNamed(e.targetScreen),)).toList()),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i <controller.banners.length; i++)
                  MyCirculerContainer(
                    height: 4,
                    width: 20,
                    margin: const EdgeInsets.only(right: 10),
                    backgroundColor: controller.carouselCurrentIndex.value == i
                        ? MyColor.primaryColor
                        : MyColor.grey,
                  ),
      
                //const  ProductCardVertical()
              ],
            ),
          )
        ],
      );
  }
    );
  }
}



class ShadowStyleCustom {
  static final vericalProductShadow = BoxShadow(
      color: MyColor.darkGrey.withValues( alpha: 0.1),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2));
}

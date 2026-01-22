import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';

class ImageController extends GetxController{

  static ImageController get instance => Get.find();
  RxString selectedProductImage = ''.obs;
  List<String> getAllProductImages(ProductModel product){
      // Use set for getting unique images

      Set<String> images = {};
      // Load thumbnail images
      images.add(product.thumbnail);
      // add thumnail image as current one
      selectedProductImage.value = product.thumbnail;
      // get all the images of the product

      if(product.images !=null && product.images!.isNotEmpty){
          images.addAll(product.images!);
      }
      if(product.productVariations !=null && product.productVariations!.isNotEmpty){
          images.addAll(product.productVariations!.map((e)=> e.image));
      }
    return images.toList();
  }

  void showEnlargeImage(String image){
      Get.to(
        fullscreenDialog: true,
        ()=> Dialog.fullscreen(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: Sizes.defaultSpace * 2, horizontal: Sizes.defaultSpace),
              child: CachedNetworkImage(imageUrl: image),),
              const SizedBox(height: Sizes.spaceBtwSections,),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  child: OutlinedButton(onPressed: ()=> Get.back(), child:const Text("Close")),
                ),
              )

            ],
          ),

        )
      );
  }
}
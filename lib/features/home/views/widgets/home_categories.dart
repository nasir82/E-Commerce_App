import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/features/home/views/home.dart';
import 'package:flutter_e_commerce_app/features/shop/views/sub_category/subcategory_screen.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:get/get.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {

    final controler = Get.put(CategoryController());

    return  Obx(
      (){

        if(controler.isLoading.value) return const CircularProgressIndicator();
        if(controler.featureCategories.isEmpty) return const Center(child: Text("No Data Found"),);

        return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controler.featureCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_,index){
            final category = controler.featureCategories[index];

            return VerticalImageText(image: category.image, title: category.name, onTap: ()=>Get.to(()=>  SubcategoryScreen(category: category)),);
          },
        ),
      );
      }
    );
  }
}
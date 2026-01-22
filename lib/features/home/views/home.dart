import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_e_commerce_app/commons/styles/promo_slider.dart';
import 'package:flutter_e_commerce_app/features/shop/views/all_products/all_products.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/circuler_image.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/header_container.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/home_appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_cards/product_cartvertical.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/search_container.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/views/sub_category/subcategory_screen.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/product_controller.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/constants/text_string.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/category_shimmer.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/vertical_product_shimmer.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderContainer(
                child: Column(
              children: [
                const MyHomeAppBar(),
                const SizedBox(
                  height: Sizes.spaceBtwItems / 2,
                ),
                const SearchContainer(
                  text: "Search the item",
                  showBackground: true,
                  showBorder: true,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.defaultSpace),
                  child: Column(
                    children: [
                      SectionHeading(
                        title: TextString.popCat,
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: Sizes.spaceBtwItems / 2,
                      ),
                      const HomeCategories(),
                      const SizedBox(
                        height: Sizes.spaceBtwSections,
                      )
                    ],
                  ),
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  const PromoSlider(),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  SectionHeading(
                    title: "Populer Products",
                    isShowButton: true,
                    onPressed: () => Get.to(() => const AllProducts(title: "Populer Products",)),
                  ),
                  Obx(
                    (){
                      if(controller.isLoading.value) return const VerticalProductShimmer();
                      if(controller.featureProducts.isEmpty) {
                        return Center(
                        child:  Text("No data found",style: Theme.of(context).textTheme.bodyMedium,)
                      );
                      }
                      return GridLayoutImp(
                      itemBuilder: ((context, index) {
                        return  ProductCardVertical(product: controller.featureProducts[index],);
                      }),
                      itemCount: controller.featureProducts.length,
                    );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return Obx(
      () {
      
        if (categoryController.isLoading.value) return const CategoryShimmer();
        if (categoryController.featureCategories.isEmpty) {
          return Center(
            child: Text(
              'No Data Found!',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(color: Colors.white),
            ),
          );
        }
        return SizedBox(
          height: 90,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => const SizedBox(
                    width: 10,
                  ),
              shrinkWrap: true,
              itemCount: categoryController.allCategories.length,
              itemBuilder: (_, index) {
                final category = categoryController.allCategories[index];
                return VerticalImageText(
                  image: category.image,
                  title: category.name,
                  onTap: () => Get.to(()=> SubcategoryScreen(category: category)),
                );
              }),
        );
      },
    );
  }
}

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    this.textColor = Colors.white,
    required this.image,
    required this.title,
    this.backgroundColor,
    this.isNetworkImage = true,
    this.onTap,
  });

  final Color textColor;
  final String image, title;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CirculerImage(image: image,
          fit: BoxFit.cover,
          padding: const EdgeInsets.all(Sizes.sm * .1),
          isNetworkImage: isNetworkImage,
          backgroundColor: backgroundColor,
          ),
          const SizedBox(
            height: Sizes.spaceBtwItems / 2,
          ),
           Text(title)
        ],
      ),
    );
  }
}

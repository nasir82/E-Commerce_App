import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/images/rounded_image.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_cards/product_cart_horizontal.dart';
import 'package:flutter_e_commerce_app/features/shop/views/all_products/all_products.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/category_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/vertical_product_shimmer.dart';
import 'package:get/get.dart';

class SubcategoryScreen extends StatelessWidget {
  const SubcategoryScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;

    return Scaffold(
      appBar: MyAppBar(
        title: Text(category.name),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              RoundedImage(
                width: double.infinity,
                imageUrl: category.image,
                applyImageRadius: true,
                isNetworkImage: true,
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const VerticalProductShimmer(); // should be replace by horizontal shimmer
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error"),
                      );
                    }

                    if (!snapshot.hasData ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    }

                    final subcategories = snapshot.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: subcategories.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        final subCategory = subcategories[index];
                        FutureBuilder(
                            future: controller.getCategoryProducts(
                                categoryId: subCategory.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const VerticalProductShimmer(); // should be replace by horizontal shimmer
                              }
                              if (snapshot.hasError) {
                                return const Center(
                                  child: Text("Error"),
                                );
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data == null ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                  child: Text("No Data Found"),
                                );
                              }

                              final products = snapshot.data!;
                              return Column(
                                children: [
                                  SectionHeading(
                                    title: subCategory.name,
                                    onPressed: () => Get.to(() => AllProducts(
                                          title: subCategory.name,
                                          futureMethod:
                                              controller.getCategoryProducts(
                                                  categoryId: subCategory.id,
                                                  limit: -1),
                                        )),
                                  ),
                                  const SizedBox(
                                    height: Sizes.spaceBtwItems / 2,
                                  ),
                                  SizedBox(
                                    height: 120,
                                    child: ListView.separated(
                                        itemBuilder: (_, index) =>
                                             ProductCartHorizontal(product: products[index]),
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (_, __) =>
                                            const SizedBox(
                                              width: Sizes.spaceBtwItems,
                                            ),
                                        itemCount: products.length),
                                  )
                                ],
                              );
                            });
                        return null;
                      },
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

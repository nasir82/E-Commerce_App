import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_cards/product_cartvertical.dart';
import 'package:flutter_e_commerce_app/features/shop/views/all_products/all_products.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/category_model.dart';
import 'package:flutter_e_commerce_app/features/store/widget/category_brands.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/vertical_product_shimmer.dart';
import 'package:get/get.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
   
    final controller = CategoryController.instance;

    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                /// brands
                CategoryBrands(category: category),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),

                /// products
                FutureBuilder(
                  future: controller.getCategoryProducts(categoryId: category.id),
                  builder: (context, snapshot) {

                     if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: VerticalProductShimmer(),
                        );
                      }

                      if (!snapshot.hasData ||
                          snapshot.hasError ||
                          snapshot.data!.isEmpty) {
                        return  Center(
                          child: Text("No Data Found"),
                        );
                      }

                    final products = snapshot.data!;
                    return Column(
                      children: [
                        SectionHeading(
                          title: "You might like",
                          onPressed: ()=> Get.to(()=> AllProducts(title: category.name,futureMethod: controller.getCategoryProducts(categoryId: category.id, limit:  -1),)),
                          isShowButton: true,
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwItems,
                        ),
                        GridLayoutImp(
                            itemCount: products.length,
                            itemBuilder: (_, index) {
                              return ProductCardVertical(
                                product: products[index],
                              );
                            })
                      ],
                    );
                  }
                ),
              ],
            ),
          ),
        ]);
  }
}

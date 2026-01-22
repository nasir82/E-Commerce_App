import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_e_commerce_app/data/repositories/product/brand_product.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/cart_counter.dart';
import 'package:flutter_e_commerce_app/features/store/widget/category_tab.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/search_container.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/store/widget/tab_bar.dart';
import 'package:flutter_e_commerce_app/features/shop/views/brand/all_brands.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/category_controller.dart';
import 'package:flutter_e_commerce_app/features/store/controller/brand_controller.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_card.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/brand_shimmer.dart';
import 'package:get/get.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BrandController());
    final categories = CategoryController.instance.allCategories;
    return DefaultTabController(
      length: categories.length, // categories.length,
      child: Scaffold(
          appBar: const MyAppBar(
            title: Text("Store"),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: CartCounter(
                    iconColor: MyColor.primaryColor),
              )
            ],
          ),
          body: NestedScrollView(
              headerSliverBuilder: (context, innScrol) {
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: true,
                    backgroundColor: HelperFunctions.isDarkMood(context)
                        ? MyColor.black
                        : MyColor.white,
                    expandedHeight: 440,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(Sizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const SizedBox(
                            height: Sizes.spaceBtwItems,
                          ),
                          const SearchContainer(
                            text: "Search product",
                            showBackground: false,
                            showBorder: true,
                            padding: EdgeInsets.zero,
                          ),
                          const SizedBox(
                            height: Sizes.spaceBtwSections,
                          ),
                          SectionHeading(
                            title: "Features Brand",
                            isShowButton: true,
                            onPressed: ()=> Get.to(()=> const AllBrands()),
                          ),
                          const SizedBox(
                            height: Sizes.spaceBtwItems / 1.5,
                          ),
                          Obx(
                            (){
                              if(controller.isLoading.value) return const BrandShimmer();
                              if(controller.allBrands.isEmpty){
                                print("##########\n there is no brand \n ##############");
                                return  Center(
                                  child: Text("No data found",style: Theme.of(context).textTheme.bodyMedium!.apply(
                                    color: Colors.white
                                  ),),
                                  
                                );
                              }
                              return  GridLayoutImp(
                                itemCount: controller.featureBrands.length > 4 ? 4 : controller.featureBrands.length,
                                mainAxisSpacing: 16,
                                mainAxisExtent: 80,
                                itemBuilder: (context, index) {
                                  final brand = controller.allBrands[index];
                                  return  BrandCard(showBorder: true, brand: brand,onTap: ()=> Get.to(()=> BrandProducts(brand: brand)),);
                                });
                            }
                          )
                        ],
                      ),
                    ),
                    bottom: MyTabBar(tabs: 
                    categories.map((category)=>Tab(
                        text: category.name,
                      ), ).toList()
                    ),
                  )
                ];
              },
              body:  TabBarView(children:categories.map((cat)=> CategoryTab(category: cat)).toList()))),
    );
  }
}


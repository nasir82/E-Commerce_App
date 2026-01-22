import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_e_commerce_app/data/repositories/product/brand_product.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/store/controller/brand_controller.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_card.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/shimmer/brand_shimmer.dart';
import 'package:get/get.dart';

class AllBrands extends StatelessWidget {
  const AllBrands({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return  Scaffold(
      appBar: const MyAppBar(
        title: Text("Brand"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: Column(
          children: [
            const SectionHeading(title: 'Brands', isShowButton: false,),
            const SizedBox(height: Sizes.spaceBtwItems,),
            Obx(
              (){
                if(brandController.isLoading.value) return  const BrandShimmer();
                if(brandController.allBrands.isEmpty){
                  return const Center(child: Text("No data found"),);
                }
                return GridLayoutImp(itemCount: brandController.allBrands.length, mainAxisExtent: 80,
                 itemBuilder: (_,index){
                  final brand = brandController.allBrands[index];
                  return BrandCard(brand: brand, onTap: ()=>Get.to(()=>  BrandProducts(brand: brand)),);
                 });
              }
            )
          ],
        ),),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/appbar/appbar.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/sortable_product.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/brand_model.dart';
import 'package:flutter_e_commerce_app/features/store/controller/brand_controller.dart';
import 'package:flutter_e_commerce_app/commons/widgets/brand/brand_card.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
        appBar: MyAppBar(
          title: Text(brand.name),
          showBackArrow: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              children: [
                BrandCard(
                  brand: brand,
                  showBorder: true,
                ),
                const SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                FutureBuilder(
                    future: controller.getBrandProduct(brandId:brand.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (!snapshot.hasData ||
                          snapshot.hasError ||
                          snapshot.data!.isEmpty) {
                        return const Center(child: Text("No Data Found"));
                      }

                      final products = snapshot.data!;

                      return SortableProduct(products: products);
                    })
              ],
            ),
          ),
        ));
  }
}

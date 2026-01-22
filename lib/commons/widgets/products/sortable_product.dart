import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/layouts/grid_layout.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_cards/product_cartvertical.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/all_product_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SortableProduct extends StatelessWidget {
  const SortableProduct({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(AllProductController());
    controller.assignAll(products); 
    return Column(
      children: [
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            initialValue: controller.selectedOption.value,
            onChanged: (value) {
              controller.selectedOption.value = value!;
              controller.sortProducts(value);
            },
            items: [
              "Name",
              "Higher Price",
              "Lower Price",
              "Sale",
              "Newest",
              "Populerity"
            ]
                .map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(option),
                  ),
                )
                .toList()),
        const SizedBox(
          height: Sizes.spaceBtwSections,
        ),
        Obx(
          ()=> GridLayoutImp(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => ProductCardVertical(
                    product: controller. products[index],
                  )),
        )
      ],
    );
  }
}

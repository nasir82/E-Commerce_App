import 'package:flutter/material.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_price_text.dart';
import 'package:flutter_e_commerce_app/commons/widgets/products/product_title.dart';
import 'package:flutter_e_commerce_app/features/home/views/widgets/my_circulercontainer.dart';
import 'package:flutter_e_commerce_app/commons/widgets/utils_widgets/section_heading.dart';
import 'package:flutter_e_commerce_app/features/shop/controllers/variation_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/color.dart';
import 'package:flutter_e_commerce_app/utils/constants/sizes.dart';
import 'package:flutter_e_commerce_app/utils/helpers/helper_funtions.dart';
import 'package:get/get.dart';

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key, required this.product});

  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = HelperFunctions.isDarkMood(context);
    return Obx(
      ()=> Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(controller.selectedVariation.value.id.isNotEmpty)
          MyCirculerContainer(
            padding: const EdgeInsets.all(Sizes.md),
            backgroundColor: dark ? MyColor.darkerGrey : MyColor.grey,
            child: Column(
              children: [
                Row(
                  children: [
                    const SectionHeading(title: "Variation"),
                    const SizedBox(
                      width: Sizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const ProductTitle(
                              title: "Price",
                              isSmall: true,
                            ),
                            const SizedBox(
                              width: Sizes.spaceBtwItems,
                            ),
                            Text(
                              "\$${controller.selectedVariation.value.price}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .apply(decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(
                              width: Sizes.spaceBtwItems,
                            ),
                             ProductPriceText(price: "\$${controller.getVariationPrice()}"),
                          ],
                        ),
                        Row(
                          children: [
                            const ProductTitle(
                              title: "Stock",
                              isSmall: true,
                            ),
                            const SizedBox(
                              width: Sizes.spaceBtwItems,
                            ),
                            Text(
                              "In Stock",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                 ProductTitle(
                  title: controller.selectedVariation.value.description?? "",
                  isSmall: true,
                  maxLines: 4,
                )
              ],
            ),
          ),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
      
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (e) =>  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeading(title: e.name ?? ''),
                      const SizedBox(
                        height: Sizes.spaceBtwItems / 2,
                      ),
                      Obx(
                        ()=> Wrap(
                          spacing: 8,
                          children: e.values!.map((value){
                          final isSelected = controller.selectedAttributes[e.name] == value;
                          final available = controller.getAllAttributeAvailabilityInVariation(product.productVariations!, e.name!).contains(value);
                          return MyChoiceChip(text: value, selected: isSelected, onSelected: available ? (selected) {  
                            if(selected && available) {
                              controller.onAttributeSelected(product, e.name ?? "", value);
                            }
                            else{
                               controller.onAttributeSelected(product, e.name ?? "", value);
                            }
                          }:null,); }).toList(),
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
    
        ],
      ),
    );
  }
}

class MyChoiceChip extends StatelessWidget {
  const MyChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.isCircle = true,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final bool isCircle;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = HelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? MyColor.white : null),
        avatar: isColor
            ?  MyCirculerContainer(
                height: 50,
                width: 50,
                backgroundColor:  HelperFunctions.getColor(text) ?? Colors.grey,
              )
            : null,
        shape: isColor ? const CircleBorder() : null,
        backgroundColor: isColor ? HelperFunctions.getColor(text) : Colors.white,
        labelPadding: isColor ? EdgeInsets.zero : null,
        padding: const EdgeInsets.all(0),
        selectedColor: isColor ? HelperFunctions.getColor(text) : null,
      ),
    );
  }
}

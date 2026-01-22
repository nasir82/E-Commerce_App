import 'package:flutter_e_commerce_app/features/shop/controllers/product_image_controller.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_varriation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //variable
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVarriationModel> selectedVariation =
      ProductVarriationModel.empty().obs;

  // select attribute and variations

  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
        (variation) => _isSameAttributeValues(
            variation.attributeValues, selectedAttributes),
        orElse: () => ProductVarriationModel.empty());

    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    this.selectedVariation.value = selectedVariation;

    getProductVariationsStockStatus();
  }

  bool _isSameAttributeValues(Map<String, dynamic> variationsAttribute,
      Map<String, dynamic> selectedAttributes) {
    if (variationsAttribute.length != selectedAttributes.length) return false;
    for (final key in variationsAttribute.keys) {
      if (variationsAttribute[key] != selectedAttributes[key]) return false;
    }
    return true;
  }

  // check attribute availability and stock status
  Set<String?> getAllAttributeAvailabilityInVariation(
      List<ProductVarriationModel> variations, String attributeName) {
    final availableVariationAttributeValue = variations
        .where((variation) =>
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValue;
  }

  //check product variation stock status

  void getProductVariationsStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }
  //reset

  void resetSelectedAttribute() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVarriationModel.empty();
  }
}

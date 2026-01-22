import 'package:flutter_e_commerce_app/data/repositories/product/product_repository.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/constants/enums.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {

  static ProductController get instance => Get.find();
  final productRepo = Get.put(ProductRepository());
  RxList<ProductModel> featureProducts = <ProductModel>[].obs;
  final isLoading = false.obs;
  @override
  void onInit() {
    fetchFeatureProduct();
    super.onInit();
  }


  void fetchFeatureProduct() async{

    try {
      isLoading.value = true;
      //fetch
      final product = await productRepo.getFeatureProduct();
      //assign
      featureProducts.assignAll(product);
      
    } catch (e) {
      Loaders.errorSnackbar(title: "Oh no",message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
  Future<List<ProductModel>> fetchAllFeatureProduct() async{

    try {
      //fetch
      final products = await productRepo.getFeatureProduct();
      return products;
    } catch (e) {
      Loaders.errorSnackbar(title: "Oh no",message: e.toString());
      return [];
    }
  }
  //get product price

  String getProductPrice(ProductModel product){
    double smallestPrice = double.infinity;
    double lasrgestPrice = 0.0;
    // if no variation return the simple price
    if(product.productType == ProductType.single.name){
    
      return product.salePrice > 0 ? product.salePrice.toString() : product.price.toString();
    }else{
      // calculate the largest and smallest value

      for(var variation in product.productVariations!){
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        if(priceToConsider<smallestPrice){
          smallestPrice = priceToConsider;
        }
        if(priceToConsider> lasrgestPrice){
          lasrgestPrice = priceToConsider;
        }
      }
      if(smallestPrice.isEqual(lasrgestPrice)){
        return lasrgestPrice.toString();
      }else{
        return '$smallestPrice - $lasrgestPrice';
      }
    }
    //
  }

  String? calculateSalePercentage(double originalPrice,double? salePrice){
    if(salePrice == null || salePrice<=0.0) return null;
    if(originalPrice<=0) return null;
    double parcentage = ((originalPrice - salePrice)/originalPrice) * 100;
    return parcentage.toStringAsFixed(0);
  }

  String getProductStockStatus(int stock){
    return stock > 0 ? "In stock" : "Out of stock";
  }
}
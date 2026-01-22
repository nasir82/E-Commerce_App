import 'package:flutter_e_commerce_app/data/repositories/brands/brand_repository.dart';
import 'package:flutter_e_commerce_app/data/repositories/product/product_repository.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/brand_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:get/get.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

  final isLoading = true.obs;
  final  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final  RxList<BrandModel> featureBrands = <BrandModel>[].obs;
  final brandRepo = Get.put(BrandRepository());
  @override
  void onInit() {
    // TODO: implement onInit
    getFeatureBrands();
    super.onInit();
  }

  Future<void> getFeatureBrands() async{
    try {

      isLoading.value = true;
      final brands = await brandRepo.getAllBrand();
      allBrands.assignAll(brands);

      featureBrands.assignAll(allBrands.where((brand)=> brand.isFeatured ?? false).take(4));
    } catch (e) {
      Loaders.errorSnackbar(title: "oh snake",message: e.toString());
      
    }finally{
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getBrandProduct({ required String brandId,int limit = -1}) async{
    try {
      final products = await ProductRepository.instance.getBrandProduct(brandId: brandId);
      return products;
    } catch (e) {
      Loaders.errorSnackbar(title: "Error",message: e.toString());
      return [];
    }
    
  }


  // get brands for category

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
    try {
      final brands = await brandRepo.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      Loaders.errorSnackbar(title: "title222",message: e.toString());
      return [];
    }
  }

}
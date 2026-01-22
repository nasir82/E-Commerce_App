import 'package:flutter_e_commerce_app/data/repositories/categories/category_repository.dart';
import 'package:flutter_e_commerce_app/data/repositories/product/product_repository.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/category_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  static CategoryController get instance => Get.find();
  final _categoryRepo = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories =  <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories =  <CategoryModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    fetchCategory();
    super.onInit();
  }

  // Load category data 
  Future<void> fetchCategory() async{
    try {
      
      // show loader
       isLoading.value = true;
      // fetch category
       
       final categories = await _categoryRepo.getAllCategory();
       print("########### number of received ${ categories.length } #####");
      // Update category list
      allCategories.assignAll(categories);
      // filter featured category

      featureCategories.assignAll(allCategories.where((p)=> p.isFeatured && p.parentId.isEmpty).take(8).toList());
      print("########### ${ featureCategories.length } #####");
      print("########### all category update ${ allCategories.length } #####");

    } catch (e) {
      Loaders.warnigSnackbar(title: "Oh no ",message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
  // Load selected category

  // Get Category or sub category product


  Future<List<CategoryModel>> getSubCategories(String categoryId)async{
    try {
      final subCategories = await _categoryRepo.getSubCategories(categoryId);
      return subCategories;
    } catch (e) {
      Loaders.errorSnackbar(title: "error", message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async{
    try {
      final products = await ProductRepository.instance.getAllCategoryProducts(categoryId:categoryId,limit:limit);
      return products;
    } catch (e) {
      Loaders.errorSnackbar(title: "error", message: e.toString());
      return [];
    }
    
  }
}
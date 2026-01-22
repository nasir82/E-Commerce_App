import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/data/repositories/product/product_repository.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:get/get.dart';

class AllProductController extends GetxController {
  static AllProductController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  Future<List<ProductModel>> fetchProductByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final prod = await repository.getProductByQuery(query);
      print("############## fetch products $prod");
      return prod;
    } catch (e) {
      Loaders.errorSnackbar(title: "Oh chorry", message: e.toString());
      return [];
    }
  }

  Future<List<ProductModel>> getAllProduct() async {
    try {
     
      final products = await repository.getAllProduct();
      print("############## fetch products $products");
      return products;
    } catch (e) {
      Loaders.errorSnackbar(title: "Oh chorry", message: e.toString());
      return [];
    }
  }

  void sortProducts(String shortOption){
    selectedOption.value = shortOption;

    switch(shortOption){
      case 'Name':
      print("Name is called");
      products.sort((a,b)=> a.title.compareTo(b.title));
      break;
      case 'Higher Price':
      print("higer is called");
      products.sort((a,b)=> b.price.compareTo(a.price));
      break;
      case 'Lower Price':
      print("lower is called");
      products.sort((a,b)=> a.price.compareTo(b.price));
      break;
      case 'Newest':
      print("newest is called");
      products.sort((a,b)=> a.date!.compareTo(b.date!));
      break;
      case 'Sale':
      print("sale is called");
      products.sort((a,b){
          if(b.salePrice>0){
            return b.salePrice.compareTo(a.salePrice);
          }else if(a.salePrice>0){
            return -1;
          }else{
            return 1;
          }
      }) ;
      break;
      default:
      print("def is called");
      products.sort((a,b)=> a.title.compareTo(b.title));

    }
  }

  void assignAll(List<ProductModel> products){
    this.products.assignAll(products);
    sortProducts("Name");
  }
}

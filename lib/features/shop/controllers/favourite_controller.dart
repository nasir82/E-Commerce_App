import 'dart:convert';

import 'package:flutter_e_commerce_app/data/repositories/product/product_repository.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/loader/loader.dart';
import 'package:flutter_e_commerce_app/utils/local_storage/local_storage.dart';
import 'package:get/get.dart';

class FavouriteController extends GetxController{

  static FavouriteController get instance => Get.find();

  final favorites = <String, bool>{}.obs;


  @override
  void onInit() {
    super.onInit();
    initFavourite();
  }

  Future<void> initFavourite()async{
    final json = LocalStorageHelper.instance().readData('favourites');
    if(json != null){
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(storedFavorites.map((key,value)=> MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productId){
    return favorites[productId] ?? false;
  }


  void toggleFavouriteProduct(String productId){
    if(!favorites.containsKey(productId)){
      favorites[productId]=true;
      saveFavoritesToStorage();
      Loaders.customToast(message: "Added to wishlist");
    }else{
      LocalStorageHelper.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      Loaders.customToast(message: "Remove from wishlist");
    }
  }

  void saveFavoritesToStorage(){
    final encodedFavourites = json.encode(favorites);
    LocalStorageHelper.instance().saveData("favourites", encodedFavourites);
  }
  Future<List<ProductModel>> favouritesProducts() async{
    return await ProductRepository.instance.getFavouriteProducts(favorites.keys.toList());
  }
}
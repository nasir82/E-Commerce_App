import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/brand_model.dart';
import 'package:flutter_e_commerce_app/utils/exceptions/exceptions.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController{

  static BrandRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  //get all category

  Future<List<BrandModel>> getAllBrand() async{
      try {
      final snapshot = await _db.collection("Brands").get();
      final result = snapshot.docs.map((doc)=> BrandModel.fromSnapshot(doc)).toList();
      return result;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  // get brand for category

  // this is for getting brand based on different category 
  // let say for sports shoes category there are many brand like nike, air
  
 Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
      try {
        print('searching in brandcategory for categoryId $categoryId');
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();
      List<String> brands = brandCategoryQuery.docs.map((doc)=> doc['brandId'] as String).toList();
      if(brands.isEmpty){
        print('no brands found for this category');
        return [];
      }else{
          print('now finding brands for this category with brand ids ${brands.length} and ${brands[0]}');
  
      final brandsQuery  = await _db.collection("Brands").where('Id', whereIn: brands).limit(2).get();
      print('object found brands for this category ${brandsQuery.docs.length}');
      List<BrandModel> result = brandsQuery.docs.map((doc)=> BrandModel.fromSnapshot(doc)).toList();
      print('returning brands for category ${result.length}');
      return result;
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      print(e.toString());
      throw "Something went wrong. Please try again";
    }
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/brand_model.dart';
import 'package:flutter_e_commerce_app/features/shop/data/models/product_model.dart';
import 'package:flutter_e_commerce_app/utils/exceptions/exceptions.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();
  final db = FirebaseFirestore.instance;

  // get limited feature product
//  @override
//   onInit() {
//      uploadDummyData();
//     super.onInit();
//   }
  Future<List<ProductModel>> getFeatureProduct() async {
    try {
      final snapshot = await db
          .collection("Products")
          .where('isFeatured', isEqualTo: true)
          .limit(4)
          .get();

      return snapshot.docs.map((e)=> ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
     // print('############################ ${e.toString()}  ####');
      throw e.toString();
    }
  }

  
  Future<List<ProductModel>> getAllProduct() async {
    try {
  
      final snapshot = await db
          .collection("Products")
          .get();
  
      return snapshot.docs.map((e)=> ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
  Future<List<ProductModel>> getAllFeatureProduct() async {
    try {
      final snapshot = await db
          .collection("Products")
          .where('isFeatured', isEqualTo: true)
          .get();

      return snapshot.docs.map((e)=> ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
     throw e.toString();
    }
  }



  Future<List<ProductModel>> getProductByQuery(Query query) async {
    try {
      final snapshot = await query.get();
    return snapshot.docs.map((e)=> ProductModel.fromQuerySnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      //print('############################ ${e.toString()}  ####');
      throw e.toString();
    }
  }
  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async {
    try {
      final snapshot = await db.collection("Products").where(FieldPath.documentId, whereIn: productIds).get();
      return snapshot.docs.map((e)=> ProductModel.fromQuerySnapshot(e)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }


  Future<List<ProductModel>> getBrandProduct({required String brandId, int limit = -1})async{
    try {
    final querySnap = limit == -1 ? await db.collection("Products").where('Brand.Id', isEqualTo: brandId).get() : await db.collection("Products").where('Brand.Id', isEqualTo: brandId).limit(limit).get();
    final products = querySnap.docs.map((doc)=> ProductModel.fromSnapshot(doc)).toList();
    return products;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw e.toString();

    }
  }
  Future<List<ProductModel>> getAllCategoryProducts({required String categoryId, int limit = -1})async{
    try {
      print('getting category products for $categoryId with limit $limit');
    final querySnap = limit == -1 ? await db.collection("Products").where('Brand.Id', isEqualTo: categoryId).get() : await db.collection("Products").where('Brand.Id', isEqualTo: categoryId).limit(limit).get();
    final products = querySnap.docs.map((doc)=> ProductModel.fromSnapshot(doc)).toList();
    return products;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw e.toString();

    }
  }



  /// upload dummy data
  ///
  ///
  ///
  Future<void> uploadDummyData() async {
    try {
      for (var product in products) {
        await db
            .collection("Products")
            .doc(product.id)
            .set(product.toJson());
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }
}




final BrandModel logitech = BrandModel(
  id: 'b1',
  name: 'Logitech',
  image: 'https://example.com/brands/logitech.png',
  isFeatured: true,
  productCount: 2,
);

final BrandModel redragon = BrandModel(
  id: 'b2',
  name: 'Redragon',
  image: 'https://example.com/brands/redragon.png',
  isFeatured: true,
  productCount: 1,
);

final List<ProductModel> products = [
  ProductModel(
    id: 'p101',
    stock: 45,
    sku: 'ELEC-MOUSE-001',
    price: 1200.0,
    salePrice: 1099.0,
    title: 'Wireless Optical Mouse',
    brand: logitech,
    date: DateTime.now(),
    thumbnail:
        'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwireless%20mouse%20(1).png?alt=media&token=2bd50227-23ef-41ed-b3da-56eee24c1007',
    isFeatured: true,
    description:
        'High-precision wireless optical mouse with adjustable DPI and smooth tracking. Designed for everyday use, office work, and casual gaming.',
    categoryId: 'electronics',
    images: [
      'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwireless%20mouse%20(1).png?alt=media&token=2bd50227-23ef-41ed-b3da-56eee24c1007',
      'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwireless%20mouse%20(2).png?alt=media&token=2cd30f88-e8c6-4ade-9891-2373c7e1cfcf',
      'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fwireless%20mouse%20(3).png?alt=media&token=aacfd850-e308-445f-84c7-1735740bb2b3',
    ],
    productType: 'single',
    productAttributes: [],
    productVariations: [],
  ),

  ProductModel(
    id: 'p2202',
    stock: 25,
    sku: 'ELEC-KEY-002',
    price: 3200.0,
    salePrice: 2999.0,
    title: 'Mechanical Gaming Keyboard',
    brand: redragon,
    date: DateTime.now(),
    thumbnail:
        'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmechanical%20keybord%20(2).png?alt=media&token=4327aeb4-2e08-4488-8329-1386ea8dde2a',
    isFeatured: true,
    description:
        'Durable mechanical keyboard with tactile switches and customizable RGB lighting. Built for gamers and power users.',
    categoryId: 'electronics',
    images: [
      'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmechanical%20keybord%20(3).png?alt=media&token=9c5f5ea4-c0e0-441c-8381-953abecc6b28',
      'https://firebasestorage.googleapis.com/v0/b/firestoreimage-24c12.appspot.com/o/products%2Fmechanical%20keybord%20(1).png?alt=media&token=74f3f945-15b1-463d-8bf5-18d72b2e854c',
    ],
    productType: 'single',
    productAttributes: [],
    productVariations: [],
  )];

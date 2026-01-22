import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/features/home/data/model/banner_model.dart';
import 'package:flutter_e_commerce_app/utils/exceptions/exceptions.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController{

static BannerRepository get instance => Get.find();


// variables 

final _db = FirebaseFirestore.instance;

 Future<List<BannerModel>> fetchBanners() async {
    try {
      final result = await _db.collection("Banners").where('active', isEqualTo: true).get();
      return result.docs.map((doc)=>BannerModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
}
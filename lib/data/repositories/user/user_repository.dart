import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/repository/authentication_repository.dart';
import 'package:flutter_e_commerce_app/features/authentications/data/models/user_model.dart';
import 'package:flutter_e_commerce_app/utils/exceptions/exceptions.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> saveUserInfo(UserModel user) async {
    try {
      await db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
  Future<UserModel> fetchUserInfo() async {
    try {
      if(AuthenticationRepository.instance.authUser == null){
       print('Auth user is null in fetchUserInfo');
      }
      final documentSnapshot =  await db.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }
Future<void> updateUserInfo(UserModel user) async {
    try {
      await db.collection("Users").doc(user.id).update(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> updateSingleUserInfoField(Map<String,dynamic> json) async {
    try {
      await db.collection("Users").doc(AuthenticationRepository.instance.authUser!.uid).update(json);
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  Future<void> removeUserInfo(String id) async {
    try {
      await db.collection("Users").doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }
  }

  //uploading image function
  Future<String> uploadImage(String path,XFile image)async{
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e) {
      throw FirebaseExceptionsCustom(e.code).message;
    } catch (e) {
      throw "Something went wrong. Please try again";
    }

  }
 
}

import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  //conver json to model

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      //map json to the model

      return CategoryModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          parentId: data['ParentId'],
          isFeatured: data['isFeatured'] ?? false
          );
    }else {
      return CategoryModel.empty();
    }
  }

  // convert model to json

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'isFeatured': isFeatured
    };
  }
}

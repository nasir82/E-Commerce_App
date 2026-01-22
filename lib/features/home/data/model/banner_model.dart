import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  String imageUrl;
  final String targetScreen;
  final bool active;

  BannerModel({
    required this.imageUrl,
    required this.targetScreen,
    required this.active,
  });

  static BannerModel empty() =>
      BannerModel(imageUrl: '', targetScreen: '', active: false);
  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'targetScreen': targetScreen,
      'active': active
    };
  }

  factory BannerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      //map json to the model

      return BannerModel(
          imageUrl: data['imageUrl'] ?? '',
          targetScreen: data['targetScreen'] ?? '',
          active: data['active'] ?? false);
    } else {
      return BannerModel.empty();
    }
  }
}

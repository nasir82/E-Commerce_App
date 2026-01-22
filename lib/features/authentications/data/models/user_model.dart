import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_e_commerce_app/utils/formatters/formatters.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  String get fullname => '$firstName $lastName';
  String get formattedPhoneNO => MyFormatter.formatPhoneNumber(phoneNumber);
  static List<String> nameParts(fullname) => fullname.split(" ");

  // A function to generate user name from full name

  static String generateUserName(fullname) {
    List<String> nameParts = fullname.split(" ");
    String fName = nameParts[0].toLowerCase();
    String lName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String userName = "pks_$fName$lName";
    return userName;
  }

  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      userName: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'Phone': phoneNumber,
      'ProfilePicture': profilePicture
    };
  }

  // factory method use for creating an usermodel from firebase document snapshot

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      document.data();
      return UserModel(
          id: document.id,
          firstName: document['FirstName'],
          lastName: document['LastName'],
          userName: document['UserName'],
          email: document['Email'],
          phoneNumber: document['Phone'],
          profilePicture: document['ProfilePicture']);
    }
    return UserModel.empty();
  }
}

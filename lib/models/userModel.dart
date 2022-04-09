import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String? email;
  final String? name;
  final String? id;
  final String? pictureModel;

  UserModel({this.email, this.id, this.name, this.pictureModel});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        id: json['id'] as String?,
        name: json['name'],
        pictureModel: json['pictureModel']);
  }
}

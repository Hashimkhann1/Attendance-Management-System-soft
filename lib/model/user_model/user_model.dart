import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userName;
  String? userEmail;
  String? userId;
  String? userImage;
  String? userType;
  Timestamp? registerData;

  UserModel(
      {this.userName,
        this.userEmail,
        this.userId,
        this.userImage,
        this.userType,
        this.registerData});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    userEmail = json['userEmail'];
    userId = json['userId'];
    userImage = json['userImage'];
    userType = json['userType'];
    registerData = json['registerData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['userEmail'] = this.userEmail;
    data['userId'] = this.userId;
    data['userImage'] = this.userImage;
    data['userType'] = this.userType;
    data['registerData'] = this.registerData;
    return data;
  }
}

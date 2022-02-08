import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel{

  String city = "", balance = "", province = "", avatar ="",  gender= "", phoneNumber= "", email = "", username= "", name = "", role = "", userID = "" ;
  bool isApproved = false;


  UserModel({this.balance, this.city, this.province, this.avatar, this.gender,
    this.phoneNumber, this.username, this.name, this.role, this.email, this.userID});

  UserModel.fromSnapshotJson(DocumentSnapshot snapshot):
        this.userID= snapshot.data["userId"],
        this.province = snapshot.data["province"],
        this.balance = snapshot.data["balance"].toString(),
        this.city = snapshot.data["city"],
        this.role = snapshot.data["role"],
        this.phoneNumber = snapshot.data['phoneNumber'],
        this.username = snapshot.data['username'],
        this.email = snapshot.data['email'],
        this.avatar = snapshot.data['avatar'],
        this.isApproved = snapshot.data["isApproved"];


  static Map<String, dynamic> stringToMap(String s) {
    Map<String, dynamic> map = json.decode(s);
    return map;
  }



}

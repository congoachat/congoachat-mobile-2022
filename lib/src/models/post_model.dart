import 'dart:convert';
import 'package:congoachat/main.dart';
import 'package:congoachat/src/models/image_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {

   String Id = "", aDiD = "", userId = "", category = "", subCategory = "", productName = "", model = "";
   String manufactureYear = "", color = "";

   String description = "",  adTime;
   String amount = '0';
   String expireDate = "", lastBillDate = "", longitude = "", latitude = "", status= "";
   bool isApproved;
   bool isFeatured;
   bool isAvailable = true;// Payment Pending

   bool isExchange = false;
   bool isPaid = false;
   String paymentID = "";
   String city = "";
   String province = "";
   String condition = "";
   String phoneNumber = "";
   String mark;
   Map myList;
   String adDate ;
   List<dynamic> photos;
   List<String> maListe;
   List<String> maList;

  PostModel(
      {this.Id,this.aDiD,this.userId = '', this.category, this.subCategory, this.productName, this.model,
        this.manufactureYear,this.photos,this.description, this.adDate, this.adTime, this.amount,
        this.expireDate, this.lastBillDate,  this.longitude, this.latitude,  this.status, this.isApproved,
        this.isFeatured, this.isAvailable, this.isExchange, this.isPaid, this.paymentID, this.city, this.province,
      this.condition, this.phoneNumber, this.color,this.mark, this.myList, this.maListe, this.maList});

   PostModel.fromSnapshotJson(DocumentSnapshot snapshot):
         this.Id = snapshot.documentID,
         this.aDiD =  snapshot.data["aDiD"],
         this.userId= snapshot.data["userId"],
         this.adTime = snapshot.data["adTime"] == null ? "Pas d'information" : snapshot.data["adTime"].toString() ,
         this.adDate = snapshot.data["adDate"] == null ? "Pas d'information" : snapshot.data["adDate"].toString() ,
         this.amount =  snapshot.data["amount"] == null ? "Pas d'information": snapshot.data["amount"].toString() ,
         this.category = snapshot.data["category"] == null ? "Pas d'information" : snapshot.data["category"],
         this.city = snapshot.data["city"] == null ? "Pas d'information": snapshot.data["city"],
         this.color = snapshot.data['color'] == null ? "Pas d'information" : snapshot.data['color'],
         this.condition = snapshot.data['condition'] == null ? "Pas d'information" : snapshot.data['condition'],
         this.description = snapshot.data['description'] == null ? "Pas d'information" : snapshot.data['description'],
         this.expireDate = snapshot.data['expireDate'],
         this.isApproved = snapshot.data["isApproved"] == null ? false : snapshot.data["isApproved"],
         this.isFeatured = snapshot.data['isFeatured'] == null ? false : snapshot.data['isFeatured'],
         this.isAvailable = snapshot.data['isAvailable'] == null ? false : snapshot.data['isAvailable'],
         this.isExchange = snapshot.data['isExchange'] == null ? false : snapshot.data['isExchange'],
         this.isPaid = snapshot.data['isPaid'] == null ? false : snapshot.data['isPaid'],
         this.model = snapshot.data['model'],
         this.lastBillDate = snapshot.data['lastBillDate'],
         this.latitude = snapshot.data['latitude'],
         this.longitude = snapshot.data['longitude'],
         this.manufactureYear = snapshot.data['manufactureYear'],
         this.paymentID = snapshot.data['paymentID'],
         this.phoneNumber = snapshot.data['phoneNumber'],
         this.productName = snapshot.data['productName'],
         this.province = snapshot.data['province'],
         this.subCategory = snapshot.data['subCategory'] == null ? "Pas d'information": snapshot.data['subCategory'],
         this.status = snapshot.data['status'] == null ? "" : snapshot.data['status'],
         this.myList = snapshot.data['myList'] ,
         //this.maListe = getFavorites(maList),
         this.photos = List.from(snapshot.data['photos']);


  static Map<String, dynamic> stringToMap(String s) {
    Map<String, dynamic> map = json.decode(s);
    return map;
  }

}

Future<void> getFavorites(List<String> liste) async{

  DocumentSnapshot querySnapshot = await Firestore.instance.collection("users")
      .document(userId).get();
  if(querySnapshot.exists && querySnapshot.data.containsKey("myList") &&
      querySnapshot.data["myList"] is List){
    return liste.add(querySnapshot.data["myList"]) ; List.from(querySnapshot.data["myList"]);

  }
  return [];

}
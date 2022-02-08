import 'package:cloud_firestore/cloud_firestore.dart';

class ImageModel {
  final String Url;
  ImageModel({this.Url = ''});



 ImageModel.fromMap(List<String> data) : Url = data.toString();

  toJson() {
    return {"Url": this.Url};
  }



  /*Map<String, dynamic> toMap() =>
      {
        "photos": this.Url,
      };

  ImageModel.fromMap(Map<dynamic, dynamic> map)
      : Url = map['Url'].map((set) {
    return ImageModel.fromMap(set);
  }).toList();*/
}

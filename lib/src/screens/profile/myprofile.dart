import 'dart:io';

import 'package:congoachat/main.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/screens/menu_screen.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {

  String citeSelected = "", province = "", avatar = "https://firebasestorage.googleapis.com/v0/b/congo-achat.appspot.com/o/profiles%2Favatar%2Ficons8_contacts_52px.png?alt=media&token=c36b7df7-ebcc-4304-892d-c399f336b262", gender= "", phoneNumber= "", email = "", username= "", name = "", role = "", userID="" ;
  bool isApproved, isLoading = false;
  String balance = "0";
  File avatarImageFile;
  final picker = ImagePicker();


  Future<void> yourInfos() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    Firestore.instance.collection('users').document(user.uid).get().then((DocumentSnapshot snapshot){
      setState(() {
        userID = user.uid;
        name = snapshot.data["name"];
        username = snapshot.data["username"] == null ? "Chargement..." : snapshot.data["username"];
        gender = snapshot.data["gender"] == null ? "Chargement..." : snapshot.data["gender"];
        email = snapshot.data["email"] == null ? "Chargement..." : snapshot.data["email"];
        phoneNumber = snapshot.data["phoneNumber"] == null ? "Chargement..." : snapshot.data["phoneNumber"];
        avatar = snapshot.data["avatar"];
        role = snapshot.data["role"] == null ? "Chargement..." : snapshot.data["role"];
        isApproved = snapshot.data["isApproved"];
        citeSelected = snapshot.data["city"] == null ? "Chargement..." : snapshot.data["city"];
        province = snapshot.data["province"] == null ? "Chargement..." : snapshot.data["province"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    //this.getSession();
    this.yourInfos();;
  }


  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setSession() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("userID", null);
    preferences.setString("name", null);
    preferences.setString("username", null);
    preferences.setString("email", null);
    preferences.setString("phoneNumber", null);
    preferences.setString("gender", null);
    preferences.setString("province", null);
    preferences.setString("city", null);
    preferences.setString("role", null);
    preferences.setString("isApproved", null);
    preferences.setString("avatar", null);

    await preferences.commit();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {

    var leng = int.parse(balance);
    int length = leng.bitLength;
    String amount = length < 4 ? balance : NumberFormat.decimalPattern().format(leng.toInt());
    var _size = MediaQuery.of(context).size;
    return Scaffold(
        body: ResponsiveLayout(
          iphone: Scaffold(
              appBar:  AppBar(
                title: Text("Mon compte",
                  style: TextStyle(color:black),
                ),
                backgroundColor: white,
                leading : IconButton(
                    icon: Icon(Icons.arrow_back,
                      size: 28,
                      color: black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              body: _profileUI()
          ),
          ipad: Row(
            children: [
              Expanded(
                  flex: 9,
                  child: Scaffold(
                      appBar:  AppBar(
                        title: Text("Mon compte",
                          style: TextStyle(color:black),
                        ),
                        backgroundColor: white,
                        leading : IconButton(
                            icon: Icon(Icons.arrow_back,
                              size: 28,
                              color: black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      body: _profileUI()
                  )
              ),
            ],
          ),
          macbook: Row(
            children: [
              Expanded(
                  flex: _size.width > 1340 ? 8 : 10,
                  child: MenuScreen() //ECommerceItems(),
              ),
              Expanded(
                  flex: _size.width > 1340 ? 3 : 5,
                  child: Scaffold(
                      appBar:  AppBar(
                        title: Text("Mon compte",
                          style: TextStyle(color:black),
                        ),
                        backgroundColor: white,
                        leading : IconButton(
                            icon: Icon(Icons.arrow_back,
                              size: 28,
                              color: black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      body: _profileUI()
                  ) //ECommerceItems(),
              ),

            ],
          ),
        )
    );
  }

  Widget _profileUI(){
    return  ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
          child: Container(
            height: 240,
            // color: Colors.green,
            child: Stack(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: NetworkImage("$avatar"),
                          fit: BoxFit.cover)),
                ),
                Positioned(
                  top: 120,
                  left: MediaQuery.of(context).size.width / 3.3,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: new Offset(0.0, 0.0),
                          blurRadius: 2.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage:
                        NetworkImage("$avatar"),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: //MediaQuery.of(context).size.height / 4.6,
                  155,
                  right: 10,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: isLoading == false ? IconButton(icon: Icon(Icons.add_a_photo,
                          size: 25,
                        ),
                          onPressed: chooseImage,
                        ) : CircularProgressIndicator()
                    ),
                  ),
                ),
                Positioned(
                  top: //MediaQuery.of(context).size.height / 3.6,
                  195,

                  left: MediaQuery.of(context).size.width / 3.3,
                  child: Text(
                    '$username',
                    style: TextStyle(
                      fontFamily: 'Ubuntu-Regular',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: //MediaQuery.of(context).size.height / 3.3,
                  215,
                  right: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    '$name',
                    style: TextStyle(
                      fontFamily: 'Ubuntu-Regular',
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: ListTile(
            title: Text(
              'Téléphone',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Ubuntu-Regular',
                  color: Colors.black54),
            ),
            subtitle: Text(
              '$phoneNumber',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu-Regular',
                  fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.phone,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10),
          child: ListTile(
            visualDensity: VisualDensity(vertical: -4),
            title: Text(
              'E-mail',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Ubuntu-Regular',
                  color: Colors.black54),
            ),
            subtitle: Text(
              '$email',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Ubuntu-Regular',
                  fontWeight: FontWeight.bold),
            ),
            trailing: Icon(Icons.email,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10),
          child: ListTile(
            title: Text(
              'Adresse',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Ubuntu-Regular',
                  color: Colors.black54),
            ),
            subtitle: Text(
              '$citeSelected',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'Ubuntu-Regular',
              ),
            ),
            trailing: Icon(
              Icons.location_on,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 10.0),
          child: ListTile(
            title: Text(
              'Rôle',
              style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Ubuntu-Regular',
                  color: Colors.black54),
            ),
            subtitle: Text(
              '$role',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Ubuntu-Regular',
                  color: Colors.black),
            ),
            trailing: Icon(Icons.male,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
       /* Padding(
          padding: EdgeInsets.all(20.0),
          child: RaisedButton(

            color: red,
            onPressed: () {
              //
            },
            child: Text(
              "Modifier",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),

          ),
        )*/
      ],
    );
  }

  selectedItem(BuildContext context, String holder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(holder),
          actions: <Widget>[
            FlatButton(
              child: new Text("Non"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Oui"),
              onPressed: () {
                Navigator.of(context).pop();
                uploadFile();
              },
            ),
          ],
        );
      },
    );
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      avatarImageFile = File(pickedFile?.path);
      if(avatarImageFile != null){
        selectedItem(context, "Vous êtes sur le point de modifier la photo de votre profile , Continuer ? Cette action va changer la photo");
      }else{
        Fluttertoast.showToast(msg: 'Imposible de changer votre profile');
      }
    });
  }

  Future uploadFile() async {
    setState(() {
      isLoading = true;
    });
    String photoUrl;
    var uuid = Uuid().v1();
    final DateTime now = DateTime.now();
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String year = now.year.toString();
    final String today = ('$year-$month-$date');

    StorageReference reference = FirebaseStorage.instance.ref().child("avatar").child(today).child("avatar_$uuid.jpeg");;
    StorageUploadTask uploadTask = reference.putFile(avatarImageFile, StorageMetadata(contentType: "image/jpeg"));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    StorageTaskSnapshot storageTaskSnapshot;
    uploadTask.onComplete.then((value) {
      if (value.error == null) {
        storageTaskSnapshot = value;
        storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
          photoUrl = downloadUrl;
          Firestore.instance
              .collection('users')
              .document(userID)
              .updateData({
            'photoUrl': photoUrl
          }).then((data) async {
            await prefs.setString('avatar', photoUrl);
            setState(() {
              isLoading = false;
              avatar = photoUrl;
            });
            Fluttertoast.showToast(msg: "Upload success");
          }).catchError((err) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: err.toString());
          });
        }, onError: (err) {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: 'This file is not an image');
        });
      } else {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: 'This file is not an image');
      }
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: err.toString());
    });
  }
}

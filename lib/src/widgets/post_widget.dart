import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/screens/paiement_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/widgets/DetailPage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:fluttertoast/fluttertoast.dart';


class  PostWidget extends  StatefulWidget{

  final PostModel post;
  const PostWidget({Key key,@required this.post}): super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}


class _PostWidgetState extends State<PostWidget> {

  Fluttertoast flutterToast;


  bool liked = false;
  bool myListCheck = false, okCheck = false;
  DateTime toDay;
  final SwiperController _controller = SwiperController();
  String userID = "", username = "", usernamePost = '';
  final formatter = intl.NumberFormat.decimalPattern();
  String df;
  final collection = Firestore.instance.collection('ads');

  final FlareControls flareControls = FlareControls();

  getSessionClient() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      client =  prefs.getString("client");
      username = prefs.getString("username");
    });
  }

  Future<void> deletePost(String adsID) async{
    collection
        .document(adsID) // <-- Doc ID to be deleted.
        .updateData({
      "isApproved": false,
      "isAvailable": false
    }).then((_) => messageToast("Suppresion éffectuée", Colors.red))
        .catchError((error) => messageToast("Suppresion non éffectuée", Colors.red));
  }

  @override
  void initState() {
    super.initState();
    getSessionClient();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var width10 = MediaQuery.of(context).size.shortestSide / 10;
    final orientation = MediaQuery.of(context).orientation;
    return Container(
           child: postView(widget.post, themeData, size));
  }


  Widget postView(PostModel post, ThemeData themeData, size){
    myListCheck =  post.myList[client] ?? false;
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);

    var leng = int.parse(post.amount);
    int length = leng.bitLength;
    String amount = length < 4 ? post.amount : NumberFormat.decimalPattern().format(leng.toInt());

    var width10 = MediaQuery.of(context).size.shortestSide / 30;
    var size = MediaQuery.of(context).size;
    Firestore.instance.collection('users').document(post.userId).get().then((DocumentSnapshot snapshot){
      setState(() {
        usernamePost = snapshot.data["username"];
      });
    });

    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        color: white,
        child:GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailScreen(
                  itemData: post,
                  username: username,
                )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Swiper(
                    itemCount: post.photos.length,
                    pagination: const SwiperPagination(),
                    controller: _controller,
                    itemBuilder: (BuildContext context, int index) =>  ClipRRect(
                      borderRadius: BorderRadius.circular(0.0),
                      child: Image.network(
                        post.photos[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    autoplay: post.photos == null ? false : false,
                    itemWidth: size.height,
                    itemHeight: 200.0,
                    layout: SwiperLayout.STACK,
                  ),
                  post.isPaid ? Padding(
                    padding: const EdgeInsets.only(left: 0.0, right: 20),
                    child: Text('Sponsorisé', style: TextStyle(backgroundColor: red, fontSize: 14.0, fontWeight: FontWeight.bold, color: white)),
                  ) : Container(),
                 okCheck == true ?  Padding(
                    padding: const EdgeInsets.only(left: 150.0, right: 0.0, top: 80.0),
                    child: Opacity(
                      opacity: 0.85,
                      child: Icon(Icons.check, size: 60, color: red),
                    ),
                  ) : Container()
                ],
              ),
              const SizedBox(height: 5.0),
              Center(
                child: Row(
                  children: <Widget>[
                    post.userId == userId ? post.isPaid ? Container() : RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            userId == null || userId == "" ?    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return PhoneAuth();
                                },
                              ),
                            ) :
                             Navigator.of(context).push(CupertinoPageRoute(
                                builder: (BuildContext context) => PaiementScreen(aDid: post.Id)));
                          },
                          child: const Text(
                            "Booster",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),

                    ): Container(),

                    IconButton(icon: Icon(Icons.share, color: red), onPressed:(){
                        sharePost(context, "https://congo-achat.web.app/ad/"+post.Id, post.productName);
                      },),

                    myListCheck == true ?
                   IconButton(icon: Icon(Icons.remove_shopping_cart_outlined, color: red),
                        onPressed:(){
                          setState(() {
                            ToMyList(post.Id, false,context);
                            myListCheck = false;
                          });
                          maList = maList-1;
                          SharedPreferenceHelper().saveMalist(maList);
                          _showToast("Article retiré du panier avec succès");
                        },
                    ):
                    IconButton(icon:  Icon(Icons.add_shopping_cart_outlined, color: red),
                        onPressed:(){
                          setState(() {
                            ToMyList(post.Id, true, context);
                            myListCheck = true;
                            _showToast("Article ajouté au panier avec succès");
                          });
                          maList = maList+1;
                          SharedPreferenceHelper().saveMalist(maList);
                        },),
                    IconButton(icon: Icon(Icons.call, color: red),
                        onPressed:(){
                            if(Platform.isIOS){
                              _calling(phone: post.phoneNumber);
                            }else{
                              selectedItem(context, post.phoneNumber);
                            }

                        },),

                    IconButton(icon: Icon(Icons.chat, color: red,),
                        onPressed:(){
                          userId == null || userId == "" ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PhoneAuth();
                              },
                            ),
                          ) :  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(usernamePost, username)));
                        }
                    ),
                   post.userId == userId ? Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: IconButton(icon: Icon(Icons.delete, color: red),
                        onPressed:(){
                        //popUp(context);
                          selectedConfirm(context,  "Etes-vous sur de vouloir supprimer cet article ?", post.Id);
                        },),
                    ) : Container(),
                  ],
                ),
              ),
               Padding(
                padding:  const EdgeInsets.only(left: 11.0),
                child:   Row(
                  children: [
                     Wrap(
                        children: <Widget>[
                          Text(
                            post.productName,
                            style: const TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ])
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 11.0),
                  child: Row(
                    children: [
                      Text("$amount FC",
                          style: const TextStyle(color: Colors.redAccent, fontSize: 14.0, fontWeight: FontWeight.normal)
                      ),
                    ],
                  )
              ),
               Padding(
                  padding:  const EdgeInsets.only(left: 8.0),
                  child:  Row(
                    children: [
                      Icon(Icons.location_on, color: red, size: 20),
                      Text(post.city+", "+post.province+"  "+timeAgoSinceDate(post.adDate),style: const TextStyle(fontSize: 14.0),),
                    ],
                  )
              ),

              const SizedBox(height: 2.0,),
              // Divider(color: Colors.black),
            ],
          ),)
    );
  }

  void _calling({@required String phone}){
    launchCall(phone: phone);
  }

  selectedItem(BuildContext context, String number) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Text("Voulez-vous vraiment passer un appel à cet numéro ?"),
          actions: <Widget>[
            FlatButton(
              child:  const Text("Non"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text("Oui"),
              onPressed: () {
                Navigator.of(context).pop();
                _calling(phone: number);
              },
            ),
          ],
        );
      },
    );
  }

  selectedConfirm(BuildContext context, String holder, aDiD) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(holder),
          actions: <Widget>[
            FlatButton(
              child:  const Text("Non"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text("Oui"),
              onPressed: () {
                deletePost(aDiD);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  popUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          title:  const Text(''),
          actions: <Widget>[
            Center(child: Icon(Icons.favorite, size: 150, color: red)),
          ],
        );
      },
    );
  }

  _showToast(String msg) {
    // this will be our toast UI
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("This is a Custom Toast"),
        ],
      ),
    );


    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black,
      //toastLength: msg.length
    );
  }




}

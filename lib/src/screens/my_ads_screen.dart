import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/screens/menu_screen.dart';
import 'package:congoachat/src/screens/paiement_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/DetailPage.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAdsScreen extends StatefulWidget {

   final String refUser ;
   const MyAdsScreen({Key key, @required this.refUser}) : super(key: key);

  @override
  _MyAdsScreenState createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {

  final collection = Firestore.instance.collection('ads');
  List<PostModel> fetchedFavoris = [];
  bool myListCheck;
  SwiperController _controller = SwiperController();
  String username, balance = "0.0";

  @override
  void initState() {
    super.initState();
    print(widget.refUser);
  }

  Future<void> deletePost(String adsID) async{

    collection
        .document('$adsID') // <-- Doc ID to be deleted.
        .updateData({
          "isApproved": false,
          "isAvailable": false
         }) // <-- Delete
        .then((_) => messageToast("Suppresion éffectuée", Colors.red))
        .catchError((error) => messageToast("Suppresion non éffectuée", Colors.red));
    getMyAds(userId);
  }

  Future<void> yourInfos() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    Firestore.instance.collection('users').document(userId).get().then((DocumentSnapshot snapshot){
      setState(() {
        balance = snapshot.data['balance'] == null ? "0.0" : NumberFormat.decimalPattern().format(snapshot.data['balance'].toInt());
      });
    });
  }

  Future<List<PostModel>> getMyAds(String user) async {
    List<PostModel> myads = [];

    final CollectionReference _dbs = Firestore.instance.collection("ads");

    QuerySnapshot query =
    await _dbs
        .where("userId", isEqualTo: user)
        .where("isApproved", isEqualTo: true)
        .where("isAvailable", isEqualTo: true)
        .orderBy("adTime", descending: false)
        .limit(600)
        .getDocuments();

    query.documents.forEach((DocumentSnapshot doc) {
      myads.add(PostModel.fromSnapshotJson(doc));
    });
    return myads;
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    return Scaffold(
        backgroundColor: Colors.white,
        body: ResponsiveLayout(
          iphone: Scaffold(
              appBar:  AppBar(
                title: Text('Mes Articles',
                  style: TextStyle(color:black),
                ),
                leading : IconButton(
                    icon: Icon(Icons.arrow_back,
                      size: 28,
                      color: black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                backgroundColor: white,
              ),
              body: ListView(
                children: [
                  Container(
                      child: FutureBuilder<List<PostModel>>(
                          future: getMyAds(userId),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) return Center(child: CircularProgressIndicator());
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics( ),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                PostModel post = snapshot.data[index] as PostModel;
                                return PostWidget(post: post);
                              },
                            );
                          }))
                ],
              )
          ),
          ipad: Row(
            children: [
              Expanded(
                  flex: 9,
                  child: Scaffold(
                      appBar:  AppBar(
                        title: Text('Mes Articles',
                          style: TextStyle(color:black),
                        ),
                        leading : IconButton(
                            icon: Icon(Icons.arrow_back,
                              size: 28,
                              color: black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        backgroundColor: white,
                      ),
                      body: ListView(
                        children: [
                          Container(
                              child: FutureBuilder<List<PostModel>>(
                                  future: getMyAds(userId),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) return Center(child: CircularProgressIndicator());
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics( ),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        PostModel post = snapshot.data[index] as PostModel;
                                        return PostWidget(post: post);
                                      },
                                    );
                                  }))
                        ],
                      )
                  )
              ),
            ],
          ),
          macbook: Row(
            children: [

              Expanded(
                  flex: size.width > 1340 ? 3 : 5,
                  child: Scaffold(
                      appBar:  AppBar(
                        title: Text('Mes Articles',
                          style: TextStyle(color:black),
                        ),
                        leading : IconButton(
                            icon: Icon(Icons.arrow_back,
                              size: 28,
                              color: black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        backgroundColor: white,
                      ),
                      body: ListView(
                        children: [
                          Container(
                              child: FutureBuilder<List<PostModel>>(
                                  future: getMyAds(userId),
                                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) return Center(child: CircularProgressIndicator());
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics( ),
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        PostModel post = snapshot.data[index] as PostModel;
                                        return  PostWidget(post: post);
                                      },
                                    );
                                  }))
                        ],
                      )
                  ) //ECommerceItems(),
              ),
              Expanded(
                  flex: size.width > 1340 ? 8 : 10,
                  child: MenuScreen() //ECommerceItems(),
              ),
            ],
          ),
        ) );
  }

  void _calling({@required String phone}){
    launchCall(phone: phone);
  }

  Widget postView(PostModel post, int index, ThemeData themeData, size){
    myListCheck =  post.myList[client];
    DateTime date = DateTime.parse(post.adDate);
    final date2 = DateTime.now();
    final difference = date2.difference(date);
    var leng = int.parse(post.amount);
    int length = leng.bitLength;
    String amount = length < 4 ? post.amount : NumberFormat.decimalPattern().format(leng.toInt());
    return Card(
        color: white,
        child:GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailScreen(
                  itemData: post
                )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Swiper(
                itemCount: post.photos.length,
                pagination: SwiperPagination(),
                controller: _controller,
                itemBuilder: (BuildContext context, int index) =>  ClipRRect(
                  borderRadius: BorderRadius.circular(0.0),
                  child: Image.network(
                    post.photos[index],
                    fit: BoxFit.cover,
                  ),
                ),
                autoplay: false,
                itemWidth: 800.0,
                itemHeight: 200.0,
                layout: SwiperLayout.STACK,
              ),

              SizedBox(height: 5.0,),
              Center(
                child: Row(
                  children: <Widget>[

                    new Padding(
                      padding: new EdgeInsets.only(right: 5.0),
                      child: new IconButton(icon: Icon(Icons.share, color: red), onPressed:(){
                        sharePost(context, "https://congo-achat.web.app/ad/"+post.aDiD, post.productName);
                      },),
                    ),
                    myListCheck == true ?
                    new Padding(
                      padding: new EdgeInsets.only(left: 5.0),
                      child: new IconButton(icon: Icon(Icons.remove_circle, color: red),
                        onPressed:(){
                          setState(() {
                            ToMyList(post.Id, false, context);
                            myListCheck = false;
                          });
                        },),
                    ):
                    new Padding(
                      padding: new EdgeInsets.only(left: 5.0),
                      child: new IconButton(icon:  Icon(Icons.add_outlined, color: red),
                        onPressed:(){
                          setState(() {
                            ToMyList(post.Id, true, context);
                            myListCheck = true;
                          });
                        },),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 5.0),
                      child: new IconButton(icon: Icon(Icons.delete, color: red),
                        onPressed:(){
                          selectedItem(context,  "Etes-vous sur de vouloir supprimer cet article ?", post.Id);
                        },),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 5.0),
                      child: new IconButton(icon: Icon(Icons.update, color: red),
                        onPressed:(){
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (BuildContext context) => PaiementScreen(aDid: post.Id)));
                        },),
                    ),
                  ],
                ),
              )
              ,

              new Padding(
                padding: new EdgeInsets.only(left: 11.0),
                child: new  Row(
                  children: [
                    Wrap(
                        children: <Widget>[
                          Text(
                            post.productName,
                            style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ])
                  ],
                ),
              ),

              new Padding(
                  padding: new EdgeInsets.only(left: 11.0),
                  child: new Row(
                    children: [
                      Text(amount+" FC",
                          style: TextStyle(color: Colors.redAccent, fontSize: 14.0, fontWeight: FontWeight.normal)
                      ),
                    ],
                  )
              ),
              new Padding(
                  padding: new EdgeInsets.only(left: 8.0),
                  child: new Row(
                    children: [
                      Icon(Icons.location_on, color: red, size: 20),
                      Text(post.city+", "+post.province+" "+timeAgoSinceDate(post.adDate),style: new TextStyle(fontSize: 14.0),),
                    ],
                  )
              ),

              SizedBox(height: 12.0,),
              // Divider(color: Colors.black),
            ],
          ),)
    );
  }

  selectedItem(BuildContext context, String holder, aDiD) {
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
                deletePost(aDiD);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget ItemEmpty(BuildContext context){
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset("assets/images/empty.png", width: 90.0, height: 90.0) ,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Vous n'avez ajouté aucun produit",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Les produits seront afficher ici",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ));
  }


}
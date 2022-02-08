import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/DetailPage.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MalisteScreen extends StatefulWidget {

  @override
  _MalisteScreenState createState() => _MalisteScreenState();
}

class _MalisteScreenState extends State<MalisteScreen> {

  bool didFetchFavoris = false;
  List<PostModel> fetchedFavoris = [];
  bool myListCheck;
  SwiperController _controller = SwiperController();

  String username =  "", usernamePost = "";

  getSessionClient() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString("username");
    await prefs.commit();
    setState((){});
  }

  @override
  void initState() {
    super.initState();
    this.getSessionClient();
  }


  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: ResponsiveLayout(
        iphone: Scaffold(
          appBar: AppBar(
            title: Text("Ma Liste",
              style: TextStyle(color:  white),
            ),
            backgroundColor: red,
          ),
          body: Container(
              child: buildPage()
          ),
        ),
        ipad: Row(
          children: [
            Expanded(
              flex: 9,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Ma Liste",
                    style: TextStyle(color:  white),
                  ),
                  backgroundColor: red,
                ),
                body: Container(
                    child: buildPage()
                ),
              )
            ),
          ],
        ),
        macbook: Row(
          children: [
            Expanded(
              flex: _size.width > 1340 ? 3 : 5,
              child: Scaffold(
                appBar: AppBar(
                  title: Text("Ma Liste",
                    style: TextStyle(color:  white),
                  ),
                  backgroundColor: red,
                ),
                body: Container(
                    child: buildPage()
                ),
              )
            ),
            Expanded(
                flex: _size.width > 1340 ? 8 : 10,
                child: ECommCat() //ECommerceItems(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPage() {
    return Container(
      child: ListView(
        children: [
            buildFavoris(),
        ],
      ));
  }


  Widget buildFavoris() {

      var size = MediaQuery.of(context).size;
      final ThemeData themeData = Theme.of(context);
      return  FutureBuilder<List<PostModel>>(
          future: getFavoris(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return snapshot.data.isNotEmpty ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics( ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                PostModel post = snapshot.data[index] as PostModel;
                return PostWidget(post: post);
              },
            ): ItemEmpty(context);

          });
  }

  Widget postView(PostModel post, int index, ThemeData themeData, size){
    myListCheck = post.myList[client] == null ? false: post.myList[client];
    var width10 = MediaQuery.of(context).size.shortestSide / 30;
    Firestore.instance.collection('users').document(post.userId).get().then((DocumentSnapshot snapshot){
      setState(() {
        usernamePost = snapshot.data["username"];
      });
    });
    return myListCheck == true ?  Card(
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
                        sharePost(context, "https://congo-achat.web.app/ad/"+post.Id, post.productName);
                      },),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 5.0),
                      child: new IconButton(icon: Icon(Icons.remove_circle, color: red),
                        onPressed:(){
                          setState(() {
                            ToMyList(post.Id, false, context);
                            myListCheck = false;
                          });
                        },),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 5.0),
                      child: new IconButton(icon: Icon(Icons.call, color: red),
                        onPressed:(){
                          _calling(phone: post.phoneNumber);
                        },),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: width10),
                      child: new IconButton(icon: Icon(Icons.chat, color: red,),
                        onPressed:(){
                          userId == null || userId == "" ?    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PhoneAuth();
                              },
                            ),
                          ) :  Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ChatScreen(usernamePost, username)));
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
                      Text(
                          post.amount.toString()+" FC",
                          style: TextStyle(color: Colors.redAccent, fontSize: 12.0, fontWeight: FontWeight.normal)
                      ),
                    ],
                  )
              ),
              new Padding(
                  padding: new EdgeInsets.only(left: 8.0),
                  child: new Row(
                    children: [
                      Icon(Icons.location_on, color: red, size: 20),
                      Text(post.city+", "+post.province+"-"+timeAgoSinceDate(post.adDate),style: new TextStyle(fontSize: 14.0),),
                    ],
                  )
              ),

              SizedBox(height: 12.0,),
              // Divider(color: Colors.black),
            ],
          ),)
    ): Container();
  }


  void _calling({@required String phone}){
    launchCall(phone: phone);
  }

  Widget ItemEmpty(BuildContext context){
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: Image.asset("assets/images/empty.png", width: 90.0, height: 90.0) ,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Votre liste est actuellement vide.",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Vos commandes produits apparaitrons ici",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ));
  }


}

Future<List<PostModel>> getFavoris() async {
  List<PostModel> favoris = [];

  final CollectionReference _dbs = Firestore.instance.collection("ads");
  QuerySnapshot query =
  await _dbs.where('myList.'+client, isEqualTo: true)
        .getDocuments();
  query.documents.forEach((DocumentSnapshot doc) {
    favoris.add(PostModel.fromSnapshotJson(doc));
  });
  return favoris;
}



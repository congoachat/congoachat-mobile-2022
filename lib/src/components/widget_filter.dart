import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/widgets/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FilterWidget extends StatefulWidget {
  String categorys, province, city, amount, amount2;
  FilterWidget({Key key,@required this.categorys, this.province, this.city, this.amount, this.amount2}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {

  bool didFetchFavoris = false;
  List<PostModel> fetchedFavoris = [];
  bool myListCheck;
  SwiperController _controller = SwiperController();
  String username, usernamePost = '';

  getSessionClient() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    client =  prefs.getString("client");
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
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          title: Text(" Filtre",
            style: TextStyle(color:  black),
          ),
          backgroundColor: white,
          leading : IconButton(
              icon: Icon(Icons.arrow_back,
                size: 28,
                color:  black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })
      ),
      body: Container(
          child: buildPage()
      ),
    );
  }

  Widget buildPage() {
    return Container(
      child: Column(
        children: [
          Expanded(
            child:
            buildFavoris(),
          ),
        ],
      ),);
  }


  Widget buildFavoris() {
    var size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var width10 = MediaQuery.of(context).size.shortestSide / 10;
    return FutureBuilder<List<PostModel>>(
        future: getFilters(widget.province, widget.city, widget.categorys.toUpperCase(), widget.amount, widget.amount2),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                child: CircularProgressIndicator() );
          return snapshot.data.isNotEmpty  ? ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              PostModel post = snapshot.data as PostModel;
              return  postView(post, index, themeData, size);
            },
          ) : ItemEmpty(context);
        });
  }

  Widget postView(PostModel post, int index, ThemeData themeData, size){
    myListCheck = post.myList[client] == null ? false: post.myList[client];
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
              Row(
                children: <Widget>[

                  new Padding(
                    padding: new EdgeInsets.only(left: 70.0),
                    child: new IconButton(icon: Icon(Icons.share, color: red), onPressed:(){
                      sharePost(context, "https://congo-achat.web.app/ad/"+post.aDiD, post.productName);
                    },),
                  ),
                  new Padding(
                    padding: new EdgeInsets.only(left: 5.0),
                    child: new IconButton(icon: Icon(Icons.remove_circle, color: red),
                      onPressed:(){
                        ToMyList(post.aDiD, false, context);
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
                    padding: new EdgeInsets.only(left: 5.0),
                    child: new IconButton(icon: Icon(Icons.chat, color: red,),
                      onPressed:(){
                        username == null || username == "" ?    Navigator.push(
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
              Divider(),
              new Padding(
                padding: new EdgeInsets.only(left: 3.0),
                child: new  Row(
                  children: [
                    Flexible(child: Expanded(child:  Wrap(
                        children: <Widget>[
                          Text(
                            post.productName,
                            style: themeData.textTheme.headline6,

                          ),
                        ])))
                  ],
                ),
              ),

              new Padding(
                  padding: new EdgeInsets.only(left: 3.0),
                  child: new Row(
                    children: [
                      Text(
                          post.amount.toString()+" FC",
                          style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.normal)
                      ),

                    ],
                  )
              ),
              new Padding(
                  padding: new EdgeInsets.only(left: 3.0),
                  child: new Row(
                    children: [
                      Text(timeSinceDate(post.adDate)
                        ,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  )
              ),

              new Padding(
                  padding: new EdgeInsets.only(left: 0.0),
                  child: new Row(
                    children: [
                      Icon(Icons.location_on, color: red),
                      Text(post.city+", "+post.province,style: new TextStyle(fontSize: 14.0),),
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
            Center(
              child: Image.asset("assets/images/empty.png", width: 90.0, height: 90.0) ,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Aucun produit trouvE",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Aucun produit disponible pour votre recherche",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ));
  }


}

Future<List<PostModel>> getFilters(@required String prov, @required cite, @required cat, amount, amount2) async {
  List<PostModel> filters = [];

  final CollectionReference _dbs = Firestore.instance.collection("ads");
  QuerySnapshot query =
  await _dbs
      .where('province', isEqualTo: prov)
      .where('city', isEqualTo: cite)
      .where('categoryUpperCase', isEqualTo: cat)
      .where("amount", isGreaterThan: amount)
      .where("amount", isGreaterThan: amount2)
      .getDocuments();
  query.documents.forEach((DocumentSnapshot doc) {
    filters.add(PostModel.fromSnapshotJson(doc));
  });
  return filters;
}



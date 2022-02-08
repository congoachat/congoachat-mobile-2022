import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/BorderIcon.dart';
import 'package:congoachat/src/components/OptionButton.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/screens/profile/public_profile.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/utils/widget_functions.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class DetailScreen extends StatefulWidget{

  final dynamic itemData;
  final String username;
  const DetailScreen({Key key,@required this.itemData, this.username}) : super(key: key);

  @override
  DetailScreenState createState() => new DetailScreenState(itemData: itemData, username: username);
}

class DetailScreenState  extends State<DetailScreen> {

  final dynamic itemData;
  final String username;
  DetailScreenState({Key key,@required this.itemData, this.username});


  String nameUser = "", usernamePost ='',avatar = "https://firebasestorage.googleapis.com/v0/b/congo-achat.appspot.com/o/profiles%2Favatar%2Ficons8_contacts_52px.png?alt=media&token=c36b7df7-ebcc-4304-892d-c399f336b262";
  bool isApproved = false;


  @override
  void initState() {
    super.initState();
    this.yourInfos(itemData.userId);
  }

  Future<void> yourInfos(String userID) async{
    Firestore.instance.collection('users').document("$userID").get().then((DocumentSnapshot snapshot){
      setState(() {
        nameUser = snapshot.data["name"] == null ? "Chargement..." : snapshot.data["name"];
        avatar = snapshot.data["avatar"];
        isApproved = snapshot.data["avatar"];
      });
    });
  }

  Future<List<PostModel>> getPost() async {
    List<PostModel> listPost = [];
    int current;
    final CollectionReference _dbs = Firestore.instance.collection("ads");

    QuerySnapshot query =
    await _dbs
        .where("isApproved", isEqualTo: true)
        .where("isAvailable", isEqualTo: true)
        .orderBy("adTime", descending: true)
        .limit(150)
        .getDocuments();

    query.documents.forEach((DocumentSnapshot doc) {
      DateTime date = DateTime.parse(doc.data["adDate"]);
      final date2 = DateTime.now();
      final difference = date2.difference(date);
      if(difference.inDays  <= 1460){
        listPost.add(PostModel.fromSnapshotJson(doc));
      }
    });
    return listPost;
  }

  @override
  Widget build(BuildContext context) {
    bool myListCheck = false;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 15;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    SwiperController _controller = SwiperController();
    myListCheck = itemData.myList[client] == null ? false: itemData.myList[client];

    var leng = int.parse(itemData.amount);
    int length = leng.bitLength;
    String amount = length < 4 ? itemData.amount : NumberFormat.decimalPattern().format(leng.toInt());

    return SafeArea(
      child: Scaffold(
        //appBar:
        backgroundColor: COLOR_WHITE,
        body: ResponsiveLayout(
          iphone: Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.black),
                      ),
                      SizedBox(width: 2,),
                      GestureDetector(
                        onTap:(){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PublicProfile(
                                userID: itemData.userId,
                              )));
                        },
                        child:CircleAvatar(
                          backgroundImage: NetworkImage("$avatar"),
                          maxRadius: 20,
                        ),
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('$nameUser',style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600, color: Colors.black)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: _container(),
          ),
          ipad: Row(
            children: [
              Expanded(
                flex: 9,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 2.0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,color: Colors.black),
                            ),
                            SizedBox(width: 2,),
                            GestureDetector(
                              onTap:(){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PublicProfile(
                                      userID: itemData.userId,
                                    )));
                              },
                              child:CircleAvatar(
                                backgroundImage: NetworkImage("$avatar"),
                                maxRadius: 20,
                              ),
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('$nameUser',style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600, color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: _container(),
                ), //ECommerceItemDescription(),
              ),
            ],
          ),
          macbook: Row(
            children: [
              Expanded(
                flex: size.width > 1340 ? 3 : 5,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 2.0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    flexibleSpace: SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(right: 16),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.arrow_back,color: Colors.black),
                            ),
                            SizedBox(width: 2,),
                            GestureDetector(
                              onTap:(){
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => PublicProfile(
                                      userID: itemData.userId,
                                    )));
                              },
                              child:CircleAvatar(
                                backgroundImage: NetworkImage("$avatar"),
                                maxRadius: 20,
                              ),
                            ),
                            SizedBox(width: 12,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('$nameUser',style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600, color: Colors.black)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: _container(),
                )
              ),
              Expanded(
                  flex: size.width > 1340 ? 8 : 10,
                  child: ListView(
                    children: [
                      Container(
                          child: FutureBuilder<List<PostModel>>(
                              future: getPost(),
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) return Center(child: CircularProgressIndicator());
                                return kIsWeb ? GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  //padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  itemCount: snapshot.data.length,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: size.width > 1340 ?  4 :  size.width <= 600 ? 1 : size.width < 900 ? 2 : 3,
                                    mainAxisSpacing: 16.0,
                                    crossAxisSpacing: 5,
                                    childAspectRatio: (150.0 / 220.0),

                                  ),
                                  itemBuilder: (BuildContext context, int index) {
                                    PostModel post = snapshot.data[index] as PostModel;
                                    return PostWidget(post: post);
                                  },
                                ) : ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    PostModel post = snapshot.data[index] as PostModel;
                                    return PostWidget(post: post);
                                  },
                                );
                              }))
                    ],
                  )//ECommCat() //ECommerceItems(),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _container(){
    bool myListCheck = false;
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 15;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    SwiperController _controller = SwiperController();
    myListCheck = itemData.myList[client] == null ? false: itemData.myList[client];

    var leng = int.parse(itemData.amount);
    int length = leng.bitLength;
    String amount = length < 4 ? itemData.amount : NumberFormat.decimalPattern().format(leng.toInt());
    Firestore.instance.collection('users').document(itemData.userId).get().then((DocumentSnapshot snapshot){
      setState(() {
        usernamePost = snapshot.data["username"];
      });
    });
    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Swiper(
                      itemCount: itemData.photos.length,
                      pagination: SwiperPagination(),
                      controller: _controller,
                      itemBuilder: (BuildContext context, int index) =>  ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.network(
                          itemData.photos[index],height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      autoplay: false,
                      itemWidth: size.width,
                      itemHeight: 400.0,
                      layout: SwiperLayout.STACK,
                    ),
                    itemData.isPaid ? Padding(
                      padding: EdgeInsets.only(left: 0.0, right: 20),
                      child: Text('Sponsorisé', style: TextStyle(backgroundColor: red, fontSize: 14.0, fontWeight: FontWeight.bold, color: white)),
                    ) : Container(),
                  ],
                ),
                addVerticalSpace(padding),
                Row(
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.only(left: 10.0),
                      child: new IconButton(icon: Icon(Icons.share, color: red), onPressed:(){
                        sharePost(context, "https://congo-achat.web.app/ad/"+itemData.aDiD, itemData.productName);
                      },),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 1.0),
                      child: new IconButton(icon: myListCheck == false ? Icon(Icons.add_shopping_cart_outlined, color: red) : Icon(Icons.remove_shopping_cart_outlined, color: red),
                        onPressed:(){
                          setState(() { myListCheck == false ? myListCheck = true : myListCheck = false;});
                          ToMyList(itemData.aDiD, myListCheck, context);
                        },),
                    ),

                    new Padding(
                      padding: new EdgeInsets.only(left: 1.0),
                      child: new IconButton(icon: Icon(Icons.call, color: red),
                        onPressed:(){
                          _calling(phone: itemData.phoneNumber);
                        },),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(left: 1.0),
                      child: new IconButton(icon: Icon(Icons.chat, color: red,),
                        onPressed:(){
                          username == null || username == "" ?    Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PhoneAuth();
                              },
                            ),
                          ) :   Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => ChatScreen(usernamePost, username)));
                        },),
                    ),

                  ],
                ),
                new Padding(
                  padding: sidePadding,
                  child: new  Row(
                    children: [
                      Flexible(child: Wrap(
                          children: <Widget>[
                            Text(
                              itemData.productName,
                              style: themeData.textTheme.headline6,
                            ),
                          ]))
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                 new Padding(
                      padding: sidePadding,
                      child: new Row(
                        children: [
                          Text("$amount FC",
                              style: TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.normal)
                          ),
                        ],
                      )
                ),
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      new Padding(
                          padding: new EdgeInsets.only(left: 3.0),
                          child: new Row(
                            children: [
                              Text("Posté : "+timeAgoSinceDate(itemData.adDate)
                                ,
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 20.0,),
                      new Padding(
                          padding: new EdgeInsets.only(left: 0.0),
                          child: new Row(
                            children: [
                              Icon(Icons.location_on, color: red),
                              Text(itemData.city+", "+itemData.province,style: new TextStyle(fontSize: 14.0),),
                            ],
                          )
                      ),
                      //BorderIcon(child: Text(itemData.montant,style: themeData.textTheme.headline5,),padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 25),)
                    ],
                  ),
                ),
                addVerticalSpace(padding),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Catégorie :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.category == null ? "Pas d'information" : itemData.category
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                addVerticalSpace(padding),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Sous-Catégorie :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.subCategory == null ? "Pas d'information" : itemData.subCategory
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                addVerticalSpace(padding),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Province :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.province == null ? "Pas d'information" : itemData.province
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                addVerticalSpace(padding),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Ville :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.city == null ? "Pas d'information" : itemData.city
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                addVerticalSpace(padding),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Couleur :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.color == null ? "Pas d'information" : itemData.color
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                Divider(),
                addVerticalSpace(padding),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Model :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.model == null ? "Pas d'information" : itemData.model
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                addVerticalSpace(padding),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Condition :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.condition == null ? "Pas d'information" : itemData.condition
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                addVerticalSpace(padding),
                Divider(),
                Row(
                  children: [
                    Padding(
                      padding: sidePadding,
                      child: Text("Année de Fabrication :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: sidePadding,
                      child: Text(itemData.lastBillDate == null ? "Pas d'information" : itemData.lastBillDate
                        ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                    )
                  ],
                ),
                addVerticalSpace(padding),
                Divider(),
                Padding(
                  padding: sidePadding,
                  child: Text("Description :",style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.normal)),
                ),
                addVerticalSpace(padding),
                Padding(
                  padding: sidePadding,
                  child: Text(itemData.description == "" ? "Pas d'information" : itemData.description
                    ,textAlign: TextAlign.justify,style: themeData.textTheme.bodyText2,),
                ),
                addVerticalSpace(50),
                Padding(
                  padding: sidePadding,
                  child: Text("Avertissement",style: TextStyle(color: red, fontSize: 18.0, fontWeight: FontWeight.normal)),
                ),
                addVerticalSpace(10),
                Card(
                  color: white,
                  child:  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Text("\t•\tVous ne devez jamais payer en avance \n" +
                        "\t•\tSe rencontrer uniquement dans un lieu public sûr\n" +
                        "\t•\tSe rencontrer uniquement pendant la journee\n" +
                        "\t•\tPayer uniquement après vérification\n" +
                        "\t•\tSignalez directement à la police en cas de suspicion ou danger",style: TextStyle(color: red, fontSize: 16, fontWeight: FontWeight.normal)),
                  ),
                ),
                addVerticalSpace(100),
              ],
            ),
          ),
          /*Positioned(
                bottom: 10,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OptionButton(text: "Sms",icon: Icons.message,width: size.width*0.30,
                        onPress: (){  username == null || username == "" ?    Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return PhoneAuth();
                            },
                          ),
                        ) :   Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    name: username,
                                    senderUid: userId,
                                    receiverUid: itemData.userId)));}, Couleur: red),
                    addHorizontalSpace(1.0),
                    OptionButton(text: "Profil",icon: Icons.account_circle,width: size.width*0.30,
                        onPress: (){
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PublicProfile(
                              userID: itemData.userId,
                            )));
                        }, Couleur: red),
                    addHorizontalSpace(1.0),
                    OptionButton(text: "Appel",icon: Icons.call,width: size.width*0.30,
                        onPress: (){ _calling(phone: itemData.phoneNumber);}, Couleur: red),
                  ],
                ),
              )*/
        ],
      ),
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


class InformationTile extends StatelessWidget{

  final String content;
  final String name;

  const InformationTile({Key key,@required this.content,@required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width*0.20;
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BorderIcon(
              width: tileSize,
              height: tileSize,
              child: Text(content,style: themeData.textTheme.headline3,)),
          addVerticalSpace(15),
          Text(name,style: themeData.textTheme.headline6,),
        ],
      ),
    );

  }

}

void _calling({@required String phone}){
  _launchURL(phone: phone);
}


_launchURL({@required String phone}) async {

  //const url = 'tel:$phone';
  if (await canLaunch('tel:'+phone)) {
    await launch('tel:'+phone);
  } else {
    throw 'Could not launch tel:$phone';
  }
}

void launchWhatsApp(
    {@required String phone,
      @required String message,
    }) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=${Uri.parse(message.toString())}";
    } else {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message.toString())}";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}
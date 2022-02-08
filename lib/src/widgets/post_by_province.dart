import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/webs/widget_tree.dart';
import 'package:congoachat/src/widgets/DetailPage.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "dart:async";

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PostByProvince extends StatefulWidget {
  String categorys, province, city;
  PostByProvince({Key key,@required this.categorys, this.province, this.city}) : super(key: key);

  @override
  _PostByProvince createState() => _PostByProvince();
}

class _PostByProvince extends State<PostByProvince> {

  bool didFetchFavoris = false;
  List<PostModel> fetchedFavoris = [];
  bool myListCheck;
  SwiperController _controller = SwiperController();
  String username, usernamePost = '';

  Future<void> getSession() async {

    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");

    await preferences.commit();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.getSession();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          title: Text(widget.province,
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
      body: ResponsiveLayout(
        iphone: buildPage(),
        ipad: Row(
          children: [
            Expanded(
              flex: 9,
              child:  Container(
                      child: buildPage()
              )
            ),
          ],
        ),
        macbook: Row(
          children: [
            /*Expanded(
                flex: _size.width > 1340 ? 8 : 10,
                child: ECommCat() //ECommerceItems(),
            ),*/
            Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: Padding(
                padding: EdgeInsets.only(left: 300, right: 300),
                child:  Scaffold(
                body: Container(
                    child: buildPage()
                ),
                floatingActionButtonLocation:  FloatingActionButtonLocation.startTop,
                floatingActionButton: FloatingActionButton(
                  // isExtended: true,
                  child: Icon(Icons.home_filled),
                  backgroundColor: red,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WidgetTree()),
                          (Route<dynamic> route) => false,
                    );
                  },
                ),
              ),
            ))
          ],
        ),
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
          future: getFavoris(widget.province, widget.city.toUpperCase(), widget.categorys.toUpperCase()),
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
                return PostWidget(post: post);
              },
            ) : ItemEmpty(context);
          });
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
              "Aucun produit pour "+"${widget.province}"+", "+"${widget.city}",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ));
  }


}

Future<List<PostModel>> getFavoris(@required String prov, @required cite, @required cat) async {
  List<PostModel> favoris = [];

  final CollectionReference _dbs = Firestore.instance.collection("ads");
  QuerySnapshot query =
  await _dbs
      .where('province', isEqualTo: prov)
      .where('city', isEqualTo: cite)
      .where('categoryUpperCase', isEqualTo: cat)
      .getDocuments();
  query.documents.forEach((DocumentSnapshot doc) {
    favoris.add(PostModel.fromSnapshotJson(doc));
  });
  return favoris;
}



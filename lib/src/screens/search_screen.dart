import 'package:congoachat/main.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class SearchScreen extends StatefulWidget {
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchScreen> with AutomaticKeepAliveClientMixin<SearchScreen>{

  String username;

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

  Future<QuerySnapshot> produitsDocs;
  buildSearchField() {
    return AppBar(
        leading : IconButton(
            icon: Icon(Icons.arrow_back,
              size: 28,
              color:  white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      backgroundColor:  red,
      title: Center(child: Form(
        child: TextFormField(
          autofocus: true,
          style: TextStyle(color: black),
          cursorColor: black,
          decoration: InputDecoration(labelText: 'Rechercher sur Congo Achat', fillColor: Colors.white, labelStyle : TextStyle(fontSize: 18,  color: black, fontWeight: FontWeight.normal),),
          onFieldSubmitted: submit,
        ),
      ),
    ));
  }

  ListView buildSearchResults(List<DocumentSnapshot> docs) {
    List<UserSearchItem> produitSearchItems = [];

    docs.forEach((DocumentSnapshot doc) {
      PostModel video = PostModel.fromSnapshotJson(doc);
      UserSearchItem searchItem = UserSearchItem(video, username);
      produitSearchItems.add(searchItem);
    });

    return ListView(
      children: produitSearchItems,
    );
  }

  void submit(String searchValue) async {
    Future<QuerySnapshot> produits = Firestore.instance
        .collection("ads")
        .where('productNameLowerCase', isGreaterThanOrEqualTo: searchValue.toLowerCase())
        .where("isApproved", isEqualTo: true)
        .where("isAvailable", isEqualTo: true)
        .limit(300)
        .getDocuments();

    setState(() {
      produitsDocs = produits;
    });
  }

  Widget build(BuildContext context) {
    super.build(context); // reloads state when opened again
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: ResponsiveLayout(
        iphone:  produitsDocs == null
            ? Scaffold(
            appBar: buildSearchField(),
            body: Center(child:  Text("Rechercher des produits sur Congo Achat", style: TextStyle(color: black),),))
            : Scaffold(
            appBar: buildSearchField(),
            body: FutureBuilder<QuerySnapshot>(
            future: produitsDocs,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

              return snapshot.data.documents.length != 0 ?  buildSearchResults(snapshot.data.documents) : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/empty.png"),
                    SizedBox(height: 10),
                    Text("Aucun produit pour cette recherche", style: TextStyle(color: black, fontSize: 18),)
                  ],
                ),
              );
            })
        ),
        ipad: Row(
          children: [
            Expanded(
              flex: 9,
              child:  produitsDocs == null
                  ? Scaffold(
                  appBar: buildSearchField(),
                  body: Center(child:  Text("Rechercher des produits sur Congo Achat", style: TextStyle(color: black),),))
                  : Scaffold(
                  appBar: buildSearchField(),
                  body: FutureBuilder<QuerySnapshot>(
                  future: produitsDocs,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                    return snapshot.data.documents.length != 0 ?  buildSearchResults(snapshot.data.documents) : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/empty.png"),
                          SizedBox(height: 10),
                          Text("Aucun produit pour cette recherche", style: TextStyle(color: black, fontSize: 18),)
                        ],
                      ),
                    );
                  })
              ),
            ),
          ],
        ),
        macbook: Row(
          children: [
            Expanded(
                flex: _size.width > 1340 ? 6 : 8,
                child: ECommCat() //ECommerceItems(),
            ),
            Expanded(
              flex: _size.width > 1340 ? 2 : 3,
              child:  produitsDocs == null
                  ? Scaffold(
                  appBar: buildSearchField(),
                  body: Center(child:  Text("Rechercher des produits sur Congo Achat", style: TextStyle(color: black),),))
                  : Scaffold(
                  appBar: buildSearchField(),
                  body: FutureBuilder<QuerySnapshot>(
                  future: produitsDocs,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                    return snapshot.data.documents.length != 0 ?  buildSearchResults(snapshot.data.documents) : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/empty.png"),
                          SizedBox(height: 10),
                          Text("Aucun produit pour cette recherche", style: TextStyle(color: black, fontSize: 18),)
                        ],
                      ),
                    );
                  })
              ),
            )
          ],
        ),
      ),
    );
  }

  // ensures state is kept when switching pages
  @override
  bool get wantKeepAlive => true;
}

class UserSearchItem extends StatelessWidget {
  final PostModel post;
  final String username;

  const UserSearchItem(this.post, this.username);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: ListTile(
          leading: Icon(Icons.search_rounded, size: 20,color: Colors.redAccent),
          title: Text(post.productName == null ? "Not found" :  post.productName, style: TextStyle(color: black)),
          subtitle: Text(post.category == null ? "Not found" : post.category  , style: TextStyle(color: black)),
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailScreen(
                itemData: post
              )));
        });
  }
}

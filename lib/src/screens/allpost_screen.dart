import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';


class AllPostScreen extends StatefulWidget {
  @override
  _AllPostScreenState createState() => _AllPostScreenState();
}

class _AllPostScreenState extends State<AllPostScreen> {

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:  AppBar(
          title: Text("Voir tout",
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
        body: ResponsiveLayout(
          iphone:  ListView(
              children: <Widget>[
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
                              crossAxisCount: _size.width > 1340 ?  4 :  _size.width <= 600 ? 1 : _size.width < 900 ? 2 : 3,
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
                 ]),
          ipad: Row(
            children: [
              Expanded(
                flex: 9,
                child: ListView(
        children: <Widget>[
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
                    crossAxisCount: _size.width > 1340 ?  4 :  _size.width <= 600 ? 1 : _size.width < 900 ? 2 : 3,
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
                ]),
              ),
              /*Expanded(
              flex: 9,
              child: PostWidget(), //ECommerceItemDescription(),
            ),*/
            ],
          ),
          macbook: Row(
            children: [
              Expanded(
                flex: _size.width > 1340 ? 8 : 10,
                child:  ListView(
                    children: <Widget>[
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
                                    crossAxisCount: _size.width > 1340 ?  4 :  _size.width <= 600 ? 1 : _size.width < 900 ? 2 : 3,
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
                    ]),
              ),
              Expanded(
                  flex: _size.width > 1340 ? 3 : 5,
                  child: ECommCat() //ECommerceItems(),
              )
            ],
          ),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/chats/all_message.dart';
import 'package:congoachat/src/components/filter_bottomsheet_screen.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/screens/allpost_screen.dart';
import 'package:congoachat/src/screens/ma_liste.dart';
import 'package:congoachat/src/screens/menu_screen.dart';
import 'package:congoachat/src/screens/search_screen.dart';
import 'package:congoachat/src/screens/sell_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/webs/widget_tree.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/widgets/gridCategory_widget.dart';
import 'package:congoachat/src/components/BorderIcon.dart';
import 'package:flutter_swiper/flutter_swiper.dart';



class ECommCat extends StatefulWidget{
  @override
  _ECommCatState createState() => _ECommCatState();
}

class _ECommCatState extends  State<ECommCat> {

  SwiperController _controller = SwiperController();

  @override
  void initState() {
    super.initState();
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
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 0.0;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var width10 = MediaQuery.of(context).size.shortestSide / 10;
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 10.0,
        backgroundColor: red,
        elevation: 0.0,
        title: new Text('Congo Achat',
            style: new TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.normal,
                fontFamily: 'Billabong',
                fontWeight: FontWeight.w100,
                fontSize: 50.0)),

        iconTheme: new IconThemeData(color: Colors.white),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => WidgetTree()));
              }),

          new IconButton(
              icon: new Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MalisteScreen()));
              }),
          new IconButton(
              icon: new Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SellScreen()));
              }),
          new IconButton(
              icon: new Icon(Icons.message),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AllMessageScreen()));
              }),
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MenuScreen()));
              }),

        ],
      ),
      backgroundColor: greyColor2,
      body: ListView(
        children: <Widget>[
          Container(
            color: red,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),

                //addVerticalSpace(20),
                Padding(
                    padding: sidePadding,
                    child: Center(child:Text(
                      "Achetez et Vendez Rapidement",
                      style: TextStyle(color: white, fontSize: 16.0, fontWeight: FontWeight.normal),
                    ),)
                ),
                SizedBox(height: 8.0,),
                Padding(
                    padding: sidePadding,
                    child:Center(child: Text(
                      "CONGO ACHAT",
                      style: TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),)
                ),
                Stack(
                  children: [
                    Container(
                      color: red,
                      child: Swiper(
                        itemCount: 5,
                        pagination: SwiperPagination(),
                        duration: 2,
                        controller: _controller,
                        itemBuilder: (BuildContext context, int index) =>  ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.asset('assets/images/alexa.png')
                        ),
                        autoplay:  true,
                        itemWidth: size.width,
                        itemHeight: 400.0,
                        layout: SwiperLayout.TINDER,
                      ),
                    ),
                    SizedBox(height: 50),
                    Padding(
                        padding: new EdgeInsets.only(left: 100, right: 100, top: 100),
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: TextFormField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: white),
                                    cursorColor: white,
                                    decoration: InputDecoration(labelText: 'Rechercher sur Congo Achat',
                                      fillColor: Colors.white,
                                      labelStyle : TextStyle(fontSize: 18,  color: white, fontWeight: FontWeight.normal),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                  //onFieldSubmitted: submit,
                                ),
                            ),
                            new IconButton(
                                icon: new Icon(Icons.search, size: 30, color: white),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SearchScreen()));
                                }),
                            new IconButton(
                                icon: new Icon(Icons.filter_alt, size: 30, color: white),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FilterBottomSheetScreen()));
                                }),
                          ],
                        )
                    ),

                  ],
                ),

              ],
            ),),
          SizedBox(height: 8.0,),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 90, right: 90),
            child:  Text(
              "QUE VOULEZ-VOUS ACHETER ?",
              textAlign: TextAlign.left,
              style: TextStyle(color: black, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8.0,),
          Padding(
            padding: EdgeInsets.only(left: 90, right: 90),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child:  new GridView.count(
                  crossAxisCount: size.width > 1340 ?  9 : size.width < 900 ? 3 :  6,
                  physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                  shrinkWrap: true, // You won't see infinite size error
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: ChoiceCard(choice: choices[index]),
                    );
                  }
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 90, right: 90),
            child: Container(
                child: FutureBuilder<List<PostModel>>(
                    future: getPost(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) return Center(child: CircularProgressIndicator());
                      return GridView.builder(
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
                      );
                    })),
          )
          //_categoryWidget(),

        ],
      ),
    );
  }

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/components/filter_bottomsheet_screen.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/screens/allpost_screen.dart';
import 'package:congoachat/src/screens/search_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/widgets/gridCategory_widget.dart';
import 'package:congoachat/src/components/BorderIcon.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  SwiperController _controller = SwiperController();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<List<PostModel>> getPost() async {
    List<PostModel> listPost = [];
    int current;
    final CollectionReference _dbs = Firestore.instance.collection("ads");

    QuerySnapshot query = await _dbs
        .where("isApproved", isEqualTo: true)
        .where("isAvailable", isEqualTo: true)
        .orderBy("adTime", descending: true)
        .limit(150)
        .getDocuments();

    query.documents.forEach((DocumentSnapshot doc) {
      DateTime date = DateTime.parse(doc.data["adDate"]);
      final date2 = DateTime.now();
      final difference = date2.difference(date);
      if (difference.inDays <= 1460) {
        listPost.add(PostModel.fromSnapshotJson(doc));
      }
    });
    return listPost;
  }

  @override
  void initState() {
    super.initState();
    pushNotification();
  }

  FirebaseMessaging _messaging = FirebaseMessaging();
  Future<void> pushNotification() async {
    _messaging.getToken().then((String token) {
      assert(token != null);
      print('new token: $token');
    });

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/logo_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    var onSelectNotification;
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    _messaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        showNotification(
            message['notification']['title'], message['notification']['body']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("Notification"),
          content: Text("$payload"),
        );
      },
    );
  }

  void showNotification(String title, String body) async {
    await _Notification(title, body);
  }

  Future<void> _Notification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.max,
        playSound: true,
        // sound: 'sound',
        showProgress: true,
        // priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: body);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 0.0;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var width10 = MediaQuery.of(context).size.shortestSide / 10;
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: [
              /*Container(
                  color: red,
                  child: Swiper(
                    itemCount: 5,
                    pagination: SwiperPagination(),
                    controller: _controller,
                    itemBuilder: (BuildContext context, int index) =>  ClipRRect(
                        borderRadius: BorderRadius.circular(0.0),
                        child: Image.asset('assets/images/alexa.png')
                    ),
                    autoplay:  true,
                    itemWidth: size.width,
                    itemHeight: 300.0,
                    layout: SwiperLayout.TINDER,
                  ),
                ),*/
              Container(
                color: red,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchScreen()));
                            },
                            child: BorderIcon(
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.search,
                                color: black,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      FilterBottomSheetScreen()));
                            },
                            child: BorderIcon(
                              height: 40,
                              width: 40,
                              child: Icon(
                                Icons.filter_alt,
                                color: black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //addVerticalSpace(20),
                    Padding(
                        padding: sidePadding,
                        child: Center(
                          child: Text(
                            "Achetez et Vendez Rapidement",
                            style: TextStyle(
                                color: white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                    SizedBox(
                      height: 8.0,
                    ),
                    Padding(
                        padding: sidePadding,
                        child: Center(
                          child: Text(
                            "CONGO ACHAT",
                            style: TextStyle(
                                color: white,
                                fontSize: 25.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              "QUE VOULEZ-VOUS ACHETER ?",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: black, fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          //_categoryWidget(),
          new GridView.count(
              crossAxisCount: size.width < 1340
                  ? 4
                  : size.width <= 600
                      ? 3
                      : size.width < 900
                          ? 3
                          : 4,
              physics:
                  NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true, // You won't see infinite size error
              children: List.generate(choices.length, (index) {
                return ChoiceCard(
                  choice: choices[index],
                );
              })),

          SizedBox(
            height: 12.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                new Padding(
                    padding: new EdgeInsets.only(left: 3.0),
                    child: new Row(
                      children: [
                        Text(
                          "Post recent",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    )),
                SizedBox(
                  width: 20.0,
                ),
                new Padding(
                    padding: new EdgeInsets.only(left: 0.0),
                    child: new Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllPostScreen()));
                          },
                          child: Text(
                            "Voir tout",
                            style: TextStyle(
                                color: red,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
                //BorderIcon(child: Text(itemData.montant,style: themeData.textTheme.headline5,),padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 25),)
              ],
            ),
          ),

          SizedBox(
            height: 12.0,
          ),
          Container(
              child: FutureBuilder<List<PostModel>>(
                  future: getPost(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null)
                      return Center(child: CircularProgressIndicator());
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //padding: EdgeInsets.symmetric(horizontal: 5.0),
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: size.width > 1340
                            ? 4
                            : size.width <= 600
                                ? 1
                                : size.width < 900
                                    ? 2
                                    : 3,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 5,
                        childAspectRatio: (150.0 / 220.0),
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        PostModel post = snapshot.data[index] as PostModel;
                        return PostWidget(post: post);
                      },
                    );
                  }))
        ],
      ),
    );
  }
}

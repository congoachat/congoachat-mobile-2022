import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/screens/my_ads_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/widgets/DetailPage.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PublicProfile extends StatefulWidget {

  final String userID;

  const PublicProfile({Key key,@required this.userID}) : super(key: key);

  @override
  _PublicProfileState createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {

  String  balance = "0", citeSelected = "Chargement...", province = "Chargement...", avatar = "https://firebasestorage.googleapis.com/v0/b/congo-achat.appspot.com/o/profiles%2Favatar%2Ficons8_contacts_52px.png?alt=media&token=c36b7df7-ebcc-4304-892d-c399f336b262", gender= "Chargement...", phoneNumber= "Chargement...", email = "Chargement...", username= "Chargement...", name = "Chargement...", role = "Chargement...";
  bool isApproved;

  Future<void> yourInfos(String userID) async{
    Firestore.instance.collection('users').document("$userID").get().then((DocumentSnapshot snapshot){
      setState(() {

        name = snapshot.data["name"] == null ? "Chargement..." : snapshot.data["name"];
        username = snapshot.data["username"] == null ? "Chargement..." : snapshot.data["username"];
        email = snapshot.data["email"] == null ? "Chargement..." : snapshot.data["email"];
        phoneNumber = snapshot.data["phoneNumber"] == null ? 'Chargement...' : snapshot.data["phoneNumber"];
        gender = snapshot.data["gender"] == null ? 'Chargement...' : snapshot.data["gender"];
        province = snapshot.data["province"] == null ? 'Chargement...' : snapshot.data["province"];
        citeSelected = snapshot.data["city"] == null ? "Chargement..." : snapshot.data["city"];
        role = snapshot.data["role"] == null ? "Chargement..." : snapshot.data["role"];
        avatar = snapshot.data["avatar"] == null ? "https://firebasestorage.googleapis.com/v0/b/congo-achat.appspot.com/o/profiles%2Favatar%2Ficons8_contacts_52px.png?alt=media&token=c36b7df7-ebcc-4304-892d-c399f336b262": snapshot.data["avatar"];

      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.yourInfos(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          title: Text("$name",
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
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
              child: Container(
                height: 240,
                // color: Colors.green,
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: NetworkImage("$avatar"),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      top: 120,
                      left: MediaQuery.of(context).size.width / 3.3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.transparent,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: new Offset(0.0, 0.0),
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                            NetworkImage("$avatar"),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: //MediaQuery.of(context).size.height / 3.6,
                      195,

                      left: MediaQuery.of(context).size.width / 3.3,
                      child: Text(
                        '$username',
                        style: TextStyle(
                          fontFamily: 'Ubuntu-Regular',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      top: //MediaQuery.of(context).size.height / 3.3,
                      215,
                      right: MediaQuery.of(context).size.width / 3,
                      child: Text(
                        '$name',
                        style: TextStyle(
                          fontFamily: 'Ubuntu-Regular',
                          fontSize: 10,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: ListTile(
                title: Text(
                  'Téléphone',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Ubuntu-Regular',
                      color: Colors.black54),
                ),
                subtitle: Text(
                  '$phoneNumber',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu-Regular',
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.phone,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: ListTile(
                visualDensity: VisualDensity(vertical: -4),
                title: Text(
                  'E-mail',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Ubuntu-Regular',
                      color: Colors.black54),
                ),
                subtitle: Text(
                  '$email',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Ubuntu-Regular',
                      fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.email,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10),
              child: ListTile(
                title: Text(
                  'Adresse',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Ubuntu-Regular',
                      color: Colors.black54),
                ),
                subtitle: Text(
                  '$citeSelected',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Ubuntu-Regular',
                  ),
                ),
                trailing: Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 10.0),
              child: ListTile(
                title: Text(
                  'Rôle',
                  style: TextStyle(
                      fontSize: 13,
                      fontFamily: 'Ubuntu-Regular',
                      color: Colors.black54),
                ),
                subtitle: Text(
                  '$role',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu-Regular',
                      color: Colors.black),
                ),
                trailing: Icon(Icons.male,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
            PostUser(userID: widget.userID, username: username)
          ],
        ));
  }
}

class PostUser extends  StatefulWidget{

  final String userID, username;

  const PostUser({Key key,@required this.userID, this.username}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}


class _PostWidgetState extends State<PostUser> {

  bool liked = false;
  bool myListCheck = false;
  DateTime toDay;
  SwiperController _controller = SwiperController();
  String usernamePost = '';

  @override
  void initState() {
    super.initState();
    this.getMyAds(widget.userID);
  }

  Future<List<PostModel>> getMyAds(String user) async {
    List<PostModel> myads = [];

    final CollectionReference _dbs = Firestore.instance.collection("ads");
    QuerySnapshot query =
    await _dbs
        .where("userId", isEqualTo: user)
        .where("isApproved", isEqualTo: true)
        .where("isAvailable", isEqualTo: true)
        .orderBy("adTime", descending: true)
        .getDocuments();
    query.documents.forEach((DocumentSnapshot doc) {
      DateTime date = DateTime.parse(doc.data["adDate"]);
      final date2 = DateTime.now();
      final difference = date2.difference(date);
      if(difference.inDays  <= 150){
        myads.add(PostModel.fromSnapshotJson(doc));
      }
    });
    return myads;
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var width10 = MediaQuery.of(context).size.shortestSide / 10;
    return Container(
      //  height: 290.0,
        child: FutureBuilder<List<PostModel>>(
            future: getMyAds(widget.userID),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) return Center(child: CircularProgressIndicator());
              return snapshot.data.isEmpty ?  ItemEmpty(context) : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics( ),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  PostModel post = snapshot.data[index] as PostModel;
                  return PostWidget(post: post);
                },
              );

            }));
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
              "Rien À voir ici",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Les produits de ${widget.username} seront afficher ici",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ));
  }

}

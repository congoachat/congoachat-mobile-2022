import 'dart:async';
import 'dart:math';

import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/chats/chat_screen.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/services/provider.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllMessageScreenG extends StatefulWidget {
  _AllMessageScreenState createState() => _AllMessageScreenState();
}

class _AllMessageScreenState extends State<AllMessageScreenG> {
  int target =0;

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> messageList;
  final CollectionReference _collectionReference =
  Firestore.instance.collection("chats");

  String code = "", citeSelected = "", province = "", avatar = "", gender= "", phoneNumber= "", email = "", username= "", name = "", role = "" ;
  String userId;
  bool isApproved;
  Future<void> getSession() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userID");
    name = preferences.getString("name");
    username = preferences.getString("username");
    email = preferences.getString("email");
    phoneNumber = preferences.getString("phoneNumber");
    gender = preferences.getString("gender");
    avatar = preferences.getString("avatar");
    province = preferences.getString("province");
    citeSelected = preferences.getString("city");
    role = preferences.getString("role");
    isApproved = preferences.getBool("isApproved");


    await preferences.commit();
    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    this.getSession();
    _subscription = _collectionReference.where('users', arrayContains: userId)
        .orderBy("lastMessageDate", descending: true)
        .snapshots().listen((datasnapshot) {
        setState(() {
            messageList = datasnapshot.documents;
          //print("Message data $messageList");
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return isApproved == true ? Scaffold(
        appBar: AppBar(
          title: Text("Message", style: TextStyle(color: Colors.white),),
          backgroundColor: red,
        ),
        body: messageList != null
            ? Container(

            child: messageList.isNotEmpty ? ListView.builder(
              itemCount: messageList.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/def_avatar.jpg")
                  ),
                  title: Text(messageList[index].data['receiverName'] == name ? "${messageList[index].data['senderName']}" : "${messageList[index].data['receiverName']}" ,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  subtitle: Text("${messageList[index].data['lastMessage']}",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  trailing:Text(timeAgoSinceDate(messageList[index].data['lastMessageDate']),
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  onTap: (() {
                    /*Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => ChatScreen(
                                name: messageList[index].data['receiverName'],
                                receiverUid:
                                messageList[index].data['receiverID'],
                                senderUid: messageList[index].data['senderID'],
                            ))
                    );*/
                  }),
                );
              }),

            ): ItemEmpty(context)
        )
            : Center(
          child: CircularProgressIndicator(),
        )) : PhoneAuth();


  }

  Widget ItemEmpty(BuildContext context){
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Icon(Icons.chat, size: 60, color: red,) //Image.asset("assets/images/empty.png", width: 90.0, height: 90.0) ,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "Vous n'avez aucun message",
              style: TextStyle(color: black, fontWeight: FontWeight.normal, fontSize: 20),
            ),

          ],
        ));
  }
}

class AllMessageScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<AllMessageScreen> {
  bool isSearching = false;
  String myName, myProfilePic, myUserName, myEmail;
  Stream usersStream, chatRoomsStream;

  TextEditingController searchUsernameEditingController =
  TextEditingController();

  bool isApproved;
  Future<void> getSession() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    isApproved = preferences.getBool("isApproved");

    await preferences.commit();
    setState(() {});
  }

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();
    setState(() {});
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  onSearchBtnClick() async {
    isSearching = true;
    setState(() {});
    usersStream = await DatabaseMethods()
        .getUserByUserName(searchUsernameEditingController.text);

    setState(() {});
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? snapshot.data.documents.isEmpty ? ItemEmpty(context) :  ListView.builder(
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds =snapshot.data.documents[index];
              return ChatRoomListTile(ds["imgUrl"], ds["lastMessage"], ds.documentID, ds['receiveBy'], ds['messageDate'].toString());
            })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget ItemEmpty(BuildContext context){
    return  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: Icon(Icons.chat, size: 60, color: red,) //Image.asset("assets/images/empty.png", width: 90.0, height: 90.0) ,
            ),
            SizedBox(
              height: 4.0,
            ),
            Text(
              "Vous n'avez aucun message",
              style: TextStyle(color: black, fontWeight: FontWeight.normal, fontSize: 20),
            ),

          ],
        ));
  }

  Widget searchListUserTile({String profileUrl, name, username, email}) {
    return GestureDetector(
      onTap: () {
        var chatRoomId = getChatRoomIdByUsernames(myUserName, username);
        Map<String, dynamic> chatRoomInfoMap = {
          "users": [myUserName, username]
        };
        DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(username, name)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                profileUrl,
                height: 40,
                width: 40,
              ),
            ),
            SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(email)])
          ],
        ),
      ),
    );
  }

  Widget searchUsersList() {
    return StreamBuilder(
      stream: usersStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.documents[index];
            return searchListUserTile(
                profileUrl: ds["avatar"],
                name: ds["name"],
                email: ds["email"],
                username: ds["username"]);
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  getChatRooms() async {
    chatRoomsStream = await DatabaseMethods().getChatRooms();
    setState(() {});
  }

  onScreenLoaded() async {
    await getMyInfoFromSharedPreference();
    getChatRooms();
  }

  @override
  void initState() {
    onScreenLoaded();
    getSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return isApproved == true ? Scaffold(
      body: ResponsiveLayout(
        iphone: Scaffold(
          appBar:AppBar(
            backgroundColor: red,
            title: Text("Message", style: TextStyle(color: white)),
          ),
          body: _container(),
        ),
        ipad: Scaffold(
          appBar:AppBar(
            backgroundColor: red,
            title: Text("Message", style: TextStyle(color: white)),
            actions: [

            ],
          ),
          body: _container(),
        ),
        macbook: Row(
          children: [
            Expanded(
                flex: size.width > 1340 ? 8 : 10,
                child: ECommCat() //ECommCat() //ECommerceItems(),
            ),
            Expanded(
                flex: size.width > 1340 ? 3 : 5,
                child: Scaffold(
                  appBar:AppBar(
                  backgroundColor: red,
                  title: Text("Message", style: TextStyle(color: white)),
                  actions: [

                  ],
                ),
                  body: _container(),
                )
            )
          ],
        ),
      )
    ) : PhoneAuth();
  }

  Widget _container(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              isSearching
                  ? GestureDetector(
                onTap: () {
                  isSearching = false;
                  searchUsernameEditingController.text = "";
                  setState(() {});
                },
                child: Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.arrow_back)),
              )
                  : Container(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 16),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(24)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                            controller: searchUsernameEditingController,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Rechercher"),
                          )),
                      GestureDetector(
                          onTap: () {
                            if (searchUsernameEditingController.text != "") {
                              onSearchBtnClick();
                            }
                          },
                          child: Icon(Icons.search))
                    ],
                  ),
                ),
              ),
            ],
          ),
          isSearching ? searchUsersList() : chatRoomsList()
        ],
      ),
    );
  }
}

class ChatRoomListTile extends StatefulWidget {
  final String profilePicUrl, lastMessage, chatRoomId, UsernameReveive, lastMessageDs;
  ChatRoomListTile(this.profilePicUrl, this.lastMessage, this.chatRoomId, this.UsernameReveive, this.lastMessageDs);

  @override
  _ChatRoomListTileState createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String  name = "", username = "";

  getThisUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      username = prefs.getString("username");
    });
    /*username =
        widget.chatRoomId.replaceAll(widget.myUsername, "").replaceAll("_", "");*/
    QuerySnapshot querySnapshot = await DatabaseMethods().getUserInfo(username);
    print(
        "something bla bla ${querySnapshot.documents[0].documentID} ${querySnapshot.documents[0]["name"]}  ${querySnapshot.documents[0]["avatar"]}");
    name = "${querySnapshot.documents[0]["name"]}";
    //profilePicUrl = "${querySnapshot.documents[0]["avatar"]}";
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    print(widget.UsernameReveive);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(widget.UsernameReveive, username)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading:  ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              widget.profilePicUrl,
              height: 40,
              width: 40,
            ),
          ),
          title:  Text(
            widget.UsernameReveive,
            style: TextStyle(fontSize: 16),
          ),
          subtitle: Text(widget.lastMessage),
          trailing: Text(timeAgoSinceDate(widget.lastMessageDs),style: new TextStyle(fontSize: 14.0),),
        )
      ),
    );
  }
}




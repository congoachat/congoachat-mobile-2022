import 'dart:math';

import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/services/provider.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';


class ChatScreen extends StatefulWidget {
  final String chatWithUsername, name;
  ChatScreen(this.chatWithUsername, this.name);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String chatRoomId, messageId = "";
  Stream messageStream;
  String myName, myProfilePic, myUserName, myEmail;
  TextEditingController messageTextEdittingController = TextEditingController();

  getMyInfoFromSharedPreference() async {
    myName = await SharedPreferenceHelper().getDisplayName();
    myProfilePic = await SharedPreferenceHelper().getUserProfileUrl();
    myUserName = await SharedPreferenceHelper().getUserName();
    myEmail = await SharedPreferenceHelper().getUserEmail();

    chatRoomId = getChatRoomIdByUsernames(widget.chatWithUsername, myUserName);
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) {
    if (messageTextEdittingController.text != "") {
      String message = messageTextEdittingController.text;

      var lastMessageTs = DateTime.now().toString();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": myUserName,
        "receiveBy":widget.chatWithUsername,
        "ts": lastMessageTs,
        "imgUrl": myProfilePic,
        "isIncoming": true,
        "messageType": "text",
        "messageDate": DateTime.now().toString(),
        "lastMessage": message,
        "lastMessageSendTs": lastMessageTs,
        "lastMessageSendBy": myUserName,
        "users": [myUserName, widget.chatWithUsername],
      };

      //messageId
      if (messageId == "") {
        messageId = getRandomString(12);
      }

      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        /*Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageSendTs": lastMessageTs,
          "lastMessageSendBy": myUserName,
          "messageDate": DateTime.now()
        };

        DatabaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);*/

        if (sendClicked) {
          messageTextEdittingController.text = "";
          messageId = "";
        }
      });
    }
  }

  final _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Widget chatMessageTile(String message, bool sendByMe, String datemessage) {
    return Stack(
      children: [
        Padding(
        padding: EdgeInsets.only(left: 150.0, right: 0.0, top: 0.0),
        child: Text(timeAgoSinceDate(datemessage), textAlign: TextAlign.center)),
        SizedBox(height: 25.0),
        Row(
          mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                      topRight: Radius.circular(24),
                      bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                    ),
                    color: sendByMe ? Colors.blue : Color(0xfff1f0f0),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    message,
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        )
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            padding: EdgeInsets.only(bottom: 70, top: 16),
            itemCount: snapshot.data.documents.length,
            reverse: true,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              return chatMessageTile(
                  ds["message"], myUserName == ds["sendBy"], ds["messageDate"]);
            })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessages(chatRoomId);
    setState(() {});
  }

  doThisOnLaunch() async {
    await getMyInfoFromSharedPreference();
    getAndSetMessages();
  }

  @override
  void initState() {
    doThisOnLaunch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: Text(widget.name),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                          controller: messageTextEdittingController,
                          onChanged: (value) {
                            addMessage(false);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Ecrivez un message",
                              hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.6))),
                        )),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*class ChatScreen extends StatefulWidget {
  String name;
  String receiverUid;
  String senderUid;
  ChatScreen({this.name, this.senderUid, this.receiverUid});

  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Message _message;
  var _formKey = GlobalKey<FormState>();
  var map = Map<String, dynamic>();
  CollectionReference _collectionReference;
  DocumentReference _receiverDocumentReference;
  DocumentReference _senderDocumentReference;
  DocumentReference _documentReference;
  DocumentSnapshot documentSnapshot;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _senderuid;
  var listItem;
  String receiverPhotoUrl, senderPhotoUrl, receiverName, senderName;
  StreamSubscription<DocumentSnapshot> subscription;
  File imageFile;
  StorageReference _storageReference;
  TextEditingController _messageController;
  String name = 'Chargement...', myname;
  String avatar;

  Future<void> receiverInfos(String userID) async{
    Firestore.instance.collection('users').document("$userID").get().then((DocumentSnapshot snapshot){
      setState(() {
        name = snapshot.data["name"] == null ? "Chargement..." : snapshot.data["name"];
        avatar = snapshot.data["avatar"] == null ? "https://firebasestorage.googleapis.com/v0/b/congo-achat.appspot.com/o/profiles%2Favatar%2Ficons8_contacts_52px.png?alt=media&token=c36b7df7-ebcc-4304-892d-c399f336b262": snapshot.data["avatar"];
      });
    });
  }

  Future<void> getSession() async {

    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    myname = preferences.getString("name");
    await preferences.commit();
    setState(() {
    });
  }


  @override
  void initState() {
    super.initState();
    this.receiverInfos(widget.receiverUid);
    this.getSession();

    _messageController = TextEditingController();
    getUID().then((user) {
      setState(() {
        _senderuid = widget.senderUid;
        print("sender uid : $_senderuid");
        getSenderPhotoUrl(_senderuid).then((snapshot) {
          setState(() {
            senderPhotoUrl = snapshot['avatar'] == null ? "" : snapshot['avatar'];
            senderName = snapshot['name'];
          });
        });
        getReceiverPhotoUrl(widget.receiverUid).then((snapshot) {
          setState(() {
            receiverPhotoUrl = snapshot['avatar'] == null ? "" : snapshot['avatar'];
            receiverName = snapshot['name'];
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  void addMessageToDb(String text) async {
    var chatID ;
    if(widget.senderUid == userId){
     chatID = widget.senderUid+widget.receiverUid;
    }else{
      chatID =widget.receiverUid+widget.senderUid;
    }
    var reference =   Firestore.instance
        .collection("chats")
        .document(chatID)
        .collection("messages");

    var ref =   Firestore.instance
        .collection("chats");
    reference.add({
         "isIncoming": true,
         "messageBody": text,
         "messageDate": DateTime.now().toString(),
         "messageId" : reference.document().documentID,
         "messageTime": DateTime.now().millisecondsSinceEpoch,
         "messageType": "Text",
         "receiverId": widget.receiverUid,
         "receiverName": receiverName,
         "senderId": widget.senderUid,
         "senderName": senderName,
         "sortingDate": DateTime.now(),
         "users": [widget.senderUid,widget.receiverUid]
    }).whenComplete(() {
      ref.document(chatID).setData({
        "chatID": chatID,
        "lastMessage": text,
        "lastMessageDate": DateTime.now().toString(),
        "lastMessageTime": DateTime.now().millisecondsSinceEpoch,
        "receiverID": widget.receiverUid,
        "senderID": widget.senderUid,
        "receiverName": receiverName,
        "recieverAvatar": receiverPhotoUrl,
        "senderName": senderName,
        "sortingDate": DateTime.now(),
        "users": [widget.senderUid,widget.receiverUid]
      });
      print("Update last message to db");
    });

    _messageController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.red[500],
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back,color: Colors.white,),
                  ),
                  SizedBox(width: 2,),
                  GestureDetector(
                    onTap:(){
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PublicProfile(
                            userID: widget.receiverUid,
                          )));
                    },
                    child:CircleAvatar(
                      backgroundImage: AssetImage("assets/images/def_avatar.jpg"),
                      maxRadius: 20,
                    ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(name,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600, color: Colors.white)),
                        SizedBox(height: 6,),
                        Text("Disponible",style: TextStyle(color: Colors.white70, fontSize: 13),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Form(
          key: _formKey,
          child: _senderuid == null
              ? Container(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: <Widget>[
                    //buildListLayout(),
                    ChatMessagesListWidget(),
                    Divider(
                      height: 20.0,
                      color: Colors.black,
                    ),
                    ChatInputWidget(),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
        ));
  }

  Widget ChatInputWidget() {
    return Container(
      height: 55.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextFormField(
              validator: (String input) {
                if (input.isEmpty) {
                  return "Ecrivez un message";
                }
              },
              controller: _messageController,
              decoration: InputDecoration(
                  hintText: "Ecrivez un message...",
                  labelText: "Message",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              onFieldSubmitted: (value) {
                _messageController.text = value;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              splashColor: Colors.white,
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  sendMessage();
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void sendMessage() async {
    print("Inside send message");
    var text = _messageController.text;
    print(text);
    print(
        "receiverUid: ${widget.receiverUid} , senderUid : ${_senderuid} , message: ${text}");
    print(
        "timestamp: ${DateTime.now().millisecond}, type: ${text != null ? 'text' : 'image'}");
    addMessageToDb(text);
  }

  Future<FirebaseUser> getUID() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<DocumentSnapshot> getSenderPhotoUrl(String uid) {
    var senderDocumentSnapshot =
        Firestore.instance.collection('users').document(uid).get();
    return senderDocumentSnapshot;
  }

  Future<DocumentSnapshot> getReceiverPhotoUrl(String uid) {
    var receiverDocumentSnapshot =
        Firestore.instance.collection('users').document(uid).get();
    return receiverDocumentSnapshot;
  }

  Widget ChatMessagesListWidget() {
    print("SENDERUID : $_senderuid");
    return Flexible(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('chats')
            .document(widget.senderUid+widget.receiverUid)
            .collection("messages")
            .orderBy('sortingDate', descending: false)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            listItem = snapshot.data.documents;
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  chatMessageItem(snapshot.data.documents[index]),
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }

  Widget chatMessageItem(DocumentSnapshot documentSnapshot) {
    return buildChatLayout(documentSnapshot);
  }

  Widget buildChatLayout(DocumentSnapshot snapshot) {
    return Column(
      mainAxisAlignment: snapshot['senderId'] == userId ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: snapshot['senderId'] == userId ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: <Widget>[

              SizedBox(
                width: 10.0,
              ),
             Container(
               child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  snapshot['senderId'] == userId
                      ? new Text(
                          senderName == null ? "" : senderName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        )
                      : new Text(
                          receiverName == null ? "" : receiverName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                       new Text(
                          snapshot['messageBody'],
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        )
                      /*: InkWell(
                          onTap: (() {
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) => FullScreenImage(photoUrl: snapshot['photoUrl'],)));
                          }),
                          child: Hero(
                            tag: snapshot['photoUrl'],
                            child: FadeInImage(
                              image: NetworkImage(snapshot['photoUrl']),
                              placeholder: AssetImage('assets/blankimage.png'),
                              width: 200.0,
                              height: 200.0,
                            ),
                          ),
                        )*/
                ],
              ),
               decoration: BoxDecoration(
                   color: snapshot['senderId'] == userId ? Colors.red[500] : Colors.black54,
                   border: Border.all(
                     color: snapshot['senderId'] == userId ? Colors.red[500] : Colors.black54,
                   ),
                   borderRadius: BorderRadius.all(Radius.circular(10))
               ),
             ),

            ],
          ),
        ),
      ],
    );
  }

}*/
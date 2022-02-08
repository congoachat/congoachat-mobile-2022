import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/utils/utils.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return Firestore.instance
        .collection("users")
        .document(userId)
        .setData(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getUserByUserName(String username) async {
    return Firestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getUserByUserId(String userID) async {
    return Firestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .snapshots();
  }

  Future addMessage(
      String chatRoomId, String messageId, Map messageInfoMap) async {

    return Firestore.instance
        .collection("chatrooms")
        .document(chatRoomId)
        .collection("chats")
        .document(messageId)
        .setData(messageInfoMap).whenComplete((){
      Firestore.instance
          .collection("chatrooms").document(chatRoomId).setData(messageInfoMap);
    });

  }

  updateLastMessageSend(String chatRoomId, Map lastMessageInfoMap) {
    return Firestore.instance
        .collection("chatrooms")
        .document(chatRoomId)
        .updateData(lastMessageInfoMap);
  }

  createChatRoom(String chatRoomId, Map chatRoomInfoMap) async {
    final snapShot = await Firestore.instance
        .collection("chatrooms")
        .document(chatRoomId)
        .get();

    if (snapShot.exists) {
      // chatroom already exists
      return true;
    } else {
      // chatroom does not exists
      return Firestore.instance
          .collection("chatrooms")
          .document(chatRoomId)
          .setData(chatRoomInfoMap);
    }
  }

  Future<Stream<QuerySnapshot>> getChatRoomMessages(chatRoomId) async {
    return Firestore.instance
        .collection("chatrooms")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();
  }

  Future<Stream<QuerySnapshot>> getChatRooms() async {
    String myUsername = await SharedPreferenceHelper().getUserName();
    return Firestore.instance
        .collection("chatrooms")
        .orderBy("lastMessageSendTs", descending: true)
        .where("users", arrayContains: myUsername)
        .snapshots();
  }

  Future<QuerySnapshot> getUserInfo(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .getDocuments();
  }

  Future<QuerySnapshot> getUserInfoById(String userID) async {
    return await Firestore.instance
        .collection("users")
        .where("userID", isEqualTo: userID)
        .getDocuments();
  }
}
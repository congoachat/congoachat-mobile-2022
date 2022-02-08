import 'dart:ui';

import 'package:congoachat/src/constants.dart';
import 'package:flutter/material.dart';

class MessagesModel {
  String contactName;
  String contactMsg;
  String contactImg;
  String msgDate;
  Color contactColor;

  MessagesModel(this.contactName, this.contactMsg, this.contactImg,
      this.msgDate, this.contactColor);
}

class MessageMdl extends StatelessWidget {
  final String user, text;
  final bool mine;
  final timestamp;
  MessageMdl({Key key, this.user, this.text, this.mine, this.timestamp})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment:
        mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            user,
            style: TextStyle(
              color: mine ? Colors.black : royalBlue,
              fontSize: 13,
              fontFamily: 'Montserrat',
            ),
          ),
          Material(
            color: mine ? royalBlue : Colors.white,
            borderRadius: BorderRadius.circular(15.0),
            elevation: 5.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: mine ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//A => #ED9E9D
//F => #F5C677
//L => #BBB9FE
//B => #91E0FB
//s => #AFE4E6
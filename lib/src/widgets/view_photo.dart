import 'dart:io';

import 'package:congoachat/src/components/color.dart';
import 'package:flutter/material.dart';

class ViewPhotoWidget extends StatefulWidget{

  final  File file;
  const ViewPhotoWidget({Key key,@required this.file}) : super(key: key);

  @override
  ViewPhotoWidgetState createState() => ViewPhotoWidgetState(file: file);
}

class ViewPhotoWidgetState extends State<ViewPhotoWidget>{

  final File file;
  ViewPhotoWidgetState({Key key,@required this.file});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
      return Scaffold(
        appBar:  AppBar(
          title: Text('Photo',
            style: TextStyle(color:black),
          ),
          leading : IconButton(
              icon: Icon(Icons.arrow_back,
                size: 28,
                color: black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: white,
        ),
        backgroundColor: black,
        body: ListView(
          children: [
            Image.file(file, width: size.width, height: size.height)
          ],
        ),
      );
  }
}

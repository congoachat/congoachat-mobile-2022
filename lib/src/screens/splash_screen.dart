import 'dart:async';

import 'package:flutter/material.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => TabScreen()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: buildUnAuthScreen()
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image:  AssetImage('assets/images/fullback.png'),
              fit: BoxFit.cover),
        ),
        alignment: Alignment.center,
        child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 110.0),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Center(child: Text(
                        "Bienvenue à ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),)
                    )
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child:Center(child: Text(
                    "CONGO ACHAT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),),
                ),
                SizedBox(height: 2.0,),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child:Center(child: Text(
                    "ACHETEZ ET VENDEZ RAPIDEMENT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),),
                ),
              ],
            ),

        ),
    );
  }

}
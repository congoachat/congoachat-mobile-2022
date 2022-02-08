import 'dart:io';

import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/menu_screen.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {

  bool videoAlaUne = false;
  bool sujetEmouvant = false;
  bool commentairesImportant = false;
  bool teleRealite = false;
  bool updates = false;
  bool checkedValue2 = false;

  Future<void> setSettingNotification(bool videoAlaUne, sujetEmouvant, commentairesImportant, teleRealite, updates) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("videoAlaUne", videoAlaUne);
    await preferences.setBool("sujetEmouvant", sujetEmouvant);
    await preferences.setBool("commentairesImportant", commentairesImportant);
    await preferences.setBool("teleRealite", teleRealite);
    await preferences.setBool("updates", updates);

    await preferences.commit();

  }

  Future<void> getSettingNotification() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    videoAlaUne = preferences.getBool("videoAlaUne");
    sujetEmouvant =  preferences.getBool("sujetEmouvant");
    commentairesImportant = preferences.getBool("commentairesImportant");
    teleRealite = preferences.getBool("teleRealite");
    updates = preferences.getBool("updates");

    await preferences.commit();
    setState(() {});
  }


  @override
  void initState() {
    super.initState();
    this.getSettingNotification();
  }


  Widget platformSwitch(bool val) {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: true,
        activeColor: yellow,
      );
    } else {
      return Switch(
        onChanged: (value) {
          setState(() {
            val = value;
          });
        },
        value: val,
        activeColor: yellow,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveLayout(
        iphone: Scaffold(
            appBar: AppBar(
              backgroundColor: red,
              iconTheme: IconThemeData(
                color: white,
              ),
              brightness: Brightness.dark,
              //backgroundColor: Colors.transparent,
              title: Text(
                'Menu',
                style: TextStyle(color: white),
              ),
              elevation: 2.0,
            ),
            body: _notification()
        ),
        ipad: Row(
          children: [
            Expanded(
                flex: 9,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: red,
                      iconTheme: IconThemeData(
                        color: white,
                      ),
                      brightness: Brightness.dark,
                      //backgroundColor: Colors.transparent,
                      title: Text(
                        'Menu',
                        style: TextStyle(color: white),
                      ),
                      elevation: 2.0,
                    ),
                    body: _notification()
                )
            ),
          ],
        ),
        macbook: Row(
          children: [
            Expanded(
                flex: _size.width > 1340 ? 8 : 10,
                child: MenuScreen() //ECommerceItems(),
            ),
            Expanded(
                flex: _size.width > 1340 ? 3 : 5,
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: red,
                      iconTheme: IconThemeData(
                        color: white,
                      ),
                      brightness: Brightness.dark,
                      //backgroundColor: Colors.transparent,
                      title: Text(
                        'Menu',
                        style: TextStyle(color: white),
                      ),
                      elevation: 2.0,
                    ),
                    body: _notification()
                ) //ECommerceItems(),
            ),

          ],
        ),
      ),
    );
  }

  Widget _notification(){
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.only(top:24.0,left: 24.0, right: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Notifications',
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              ),
            ),
            Flexible(
              child: ListView(
                children: <Widget>[

                  CheckboxListTile(
                    checkColor: white,
                    activeColor: Colors.redAccent,
                    title: Text('Message', style: TextStyle(
                      fontSize: 18.0,
                      color:  color,
                      fontWeight: FontWeight.w600,
                      //decoration: TextDecoration.underline
                    )),
                    //value: checkedValue2,
                    value: videoAlaUne !=  null ? videoAlaUne : false,
                    onChanged: (bool value) {
                      setState(() {
                        //timeDilation = value ? 10.0 : 1.0;
                        videoAlaUne = value;
                        setSettingNotification(videoAlaUne, sujetEmouvant, commentairesImportant, teleRealite, updates);
                      });
                    },
                    // activeColor: checkedValue2  ? activeClr : null,
                  ),
                  CheckboxListTile(
                    checkColor: white,
                    activeColor: Colors.redAccent,
                    title: Text('Nouvelle Publication',style: TextStyle(
                      fontSize: 18.0,
                      color:  color,
                      fontWeight: FontWeight.w600,
                      //decoration: TextDecoration.underline
                    )),
                    //value: checkedValue2,
                    value: commentairesImportant == null ? false : commentairesImportant,
                    onChanged: (bool value) {
                      setState(() {
                        // timeDilation = value ? 10.0 : 1.0;
                        commentairesImportant = value;
                        setSettingNotification(videoAlaUne, sujetEmouvant, commentairesImportant, teleRealite, updates);
                      });
                    },
                    // activeColor: checkedValue2  ? activeClr : null,
                  ),

                  CheckboxListTile(
                    checkColor: white,
                    activeColor: Colors.redAccent,
                    title: Text('Mise à jour',style: TextStyle(
                      fontSize: 18.0,
                      color:  color,
                      fontWeight: FontWeight.w600,
                      //decoration: TextDecoration.underline
                    )),
                    //value: checkedValue2,
                    value: updates == null ? false : updates, //timeDilation != 1.0,
                    onChanged: (bool value) {
                      setState(() {
                        //timeDilation = value ? 10.0 : 1.0;
                        updates = value;
                        setSettingNotification(videoAlaUne, sujetEmouvant, commentairesImportant, teleRealite, updates);
                      });
                    },
                    // activeColor: checkedValue2  ? activeClr : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
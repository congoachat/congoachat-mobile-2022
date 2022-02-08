import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/auth/sign_up.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/screens/my_ads_screen.dart';
import 'package:congoachat/src/screens/profile/myprofile.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/widgets/notification_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isSwitched = false;

  String code = "",
      userID = "",
      citeSelected = "",
      province = "",
      avatar = "",
      gender = "",
      phoneNumber = "",
      email = "",
      username = "",
      name = "",
      role = "";
  bool isApproved;
  String output = NumberFormat.decimalPattern().format(1234);

  getSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

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
    userID = await SharedPreferenceHelper().getUserId();
    await preferences.commit();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this.getSession();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Menu',
          style: TextStyle(color: white),
        ),
        backgroundColor: red,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            //margin: EdgeInsets.all(20),
            title: Text('Mon Compte'),
            tiles: [
              isApproved == true
                  ? SettingsTile(
                      title: Text('$name'),
                      description: Text('Accéder à votre profile'),
                      leading: Container(
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
                            backgroundImage: NetworkImage("$avatar"),
                          ),
                        ),
                      ),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyProfile()));
                      },
                    )
                  : SettingsTile(
                      title: Text('Connectez-vous'),
                      description:
                          Text('Créer un compte pour un accès illimité'),
                      leading: Image.asset("assets/images/avatar_default.png"),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PhoneAuth()));
                      }),
              SettingsTile(
                title: Text('Mes Articles'),
                description: Text('Suivez vos articles ici'),
                leading: Icon(Icons.photo),
                onPressed: (BuildContext context) {
                  isApproved == true
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyAdsScreen(refUser: userId)))
                      : Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => PhoneAuth()));
                },
              )
            ],
          ),
          SettingsSection(
            //titlePadding: EdgeInsets.all(20),
            title: Text('Options'),
            tiles: [
              SettingsTile(
                title: Text("Notifications"),
                leading: Icon(Icons.notifications),
                onPressed: (BuildContext context) {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          NotificationSettingsPage()));
                },
              ),
              SettingsTile(
                title: Text('Nos Contacts'),
                leading: Icon(Icons.contact_mail),
                onPressed: (BuildContext context) {
                  popUpContact(context);
                },
              ),
              SettingsTile(
                title: Text('Question Frequentes'),
                leading: Icon(Icons.question_answer),
                onPressed: (BuildContext context) {
                  launchURL("https://congo-achat.web.app/faq");
                },
              ),
              SettingsTile(
                title: Text('Termes et Conditions'),
                leading: Icon(Icons.data_usage),
                onPressed: (BuildContext context) {
                  launchURL("https://congo-achat.web.app/terms");
                },
              ),
              SettingsTile(
                title: Text("Partager l'application"),
                leading: Icon(Icons.share),
                onPressed: (BuildContext context) {
                  final RenderBox box = context.findRenderObject();
                  Share.share(
                          "Téléchargez l'application Congo Achat pour vos ventes et Achat en ligne Lien :",
                          subject: "Téléchargez l'application Congo Achat",
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size)
                      .toString();
                },
              ),
              username == null
                  ? SettingsTile(
                      title: Text("Créer un compte"),
                      leading: Icon(Icons.account_circle),
                      onPressed: (BuildContext context) {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (BuildContext context) => SignUp()));
                      },
                    )
                  : SettingsTile(
                      title: Text("Deconnexion"),
                      leading: Icon(Icons.lock),
                      onPressed: (BuildContext context) {
                        selectedItem(context,
                            "Vous êtes sur le point de vous déconnecter, Continuer ? Cette action va vous déconnecter");
                      },
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> setSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("userID", null);
    preferences.setString("name", null);
    preferences.setString("username", null);
    preferences.setString("email", null);
    preferences.setString("phoneNumber", null);
    preferences.setString("gender", null);
    preferences.setString("province", null);
    preferences.setString("city", null);
    preferences.setString("role", null);
    preferences.setString("isApproved", null);
    preferences.setString("avatar", null);

    await preferences.commit();
    setState(() {});
  }

  popUpContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Nos Contacts"),
          actions: <Widget>[
            SizedBox(height: 15.0),
            Text("Tel : +243 00 000 00 00",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: black, fontSize: 14.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 3.0),
            Text("E-Mail : lacolombe@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: black, fontSize: 14.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 3.0),
            FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  selectedItem(BuildContext context, String holder) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(holder),
          actions: <Widget>[
            FlatButton(
              child: new Text("Non"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Oui"),
              onPressed: () {
                this.setSession().whenComplete(() => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TabScreen())));
              },
            ),
          ],
        );
      },
    );
  }
}

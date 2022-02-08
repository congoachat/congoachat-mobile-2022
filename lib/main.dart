import 'dart:async';
import 'package:congoachat/src/auth/providers/countries.dart';
import 'package:congoachat/src/auth/providers/phone_auth.dart';
import 'package:congoachat/src/screens/splash_screen.dart';
import 'package:congoachat/src/services/bloc/bloc_shop.dart';
import 'package:congoachat/src/services/shop_services.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/webs/widget_tree.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

int initScreen;
String client, userId;

Future<String> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var uuid = Uuid().v1();

  Firestore.instance.settings().then((_) {
    print("Timestamps enabled in snapshots\n");
  }, onError: (_) {
    print("there was an error enabling timestams in snapshots");
  });

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // FirebaseFirestore.instance.settings;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  client = await prefs.getString("client");

  client == null || client == ""
      ? await prefs.setString("client", uuid)
      : client;
  initScreen = await prefs.getInt("initScreen");
  userId = await prefs.getString("userID");

  await prefs.setInt("initScreen", 1);

  print('client ${client}');
  print('initScreen ${initScreen}');
  print("userID ${userId}");
  //configureApp();
  runApp(CongoAchat());
}

class CongoAchat extends StatefulWidget {
  @override
  _CongoAchatState createState() => _CongoAchatState();
}

class _CongoAchatState extends State<CongoAchat> {
  var contentmessage = "Unknown";
  StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhoneAuthDataProvider(),
        ),
      ],
      child: BlocProvider(
          blocs: [
            Bloc((i) => ShopBloc(ShopService())),
          ],
          child: MaterialApp(
            title: "Congo Achat",
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            darkTheme: ThemeData.light(),
            home: kIsWeb ? WidgetTree() : SplashScreen(),
          )),
    );
  }
}

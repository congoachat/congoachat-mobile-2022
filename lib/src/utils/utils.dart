import 'package:congoachat/main.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

final int primaryColor = 0xFF121216;
final int secondaryColor = 0xFF1a1a24;
final int accentColor = 0xFFef5466;
const double rem = 14;

MaterialColor createColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


ToMyList(String ref_produit, bool mylist, BuildContext context){

  /*Firestore.instance.collection("users").getDocuments().then((querySnapshot){
    querySnapshot.documents.forEach((element){
      List value = element.data["favourites"];
      Firestore.instance.collection("items").document(value[0]).get().then((value){
        print(value.data);
      });
    });
  });*/

  var vueIdClient = client;
  if(mylist == false || mylist == null){

    try {
      Firestore.instance.document("ads/"+ref_produit)
          .updateData({'myList.'+vueIdClient: false}).whenComplete(() {
           //messageToast("Ce Produit sera retiré de votre liste", Colors.red);
           /*ScaffoldMessenger.of(context).showMaterialBanner(
               MaterialBanner(
                   content: const Text("L'article sera retiré de votre liste"),
                   leading: const Icon(Icons.info),
                   backgroundColor: Colors.yellow,
                   actions: [
                     TextButton(
                       child: const Text('Ok'),
                       onPressed: () => ScaffoldMessenger.of(context)
                           .hideCurrentMaterialBanner(),
                     ),]));*/
      });
    } on PlatformException catch (e) {
      print(e);
      messageToast("Une erreur s'est produite lors de l'ajout dans ma liste.", Colors.red);
      return;
    }

    /*Firestore.instance.document("ads/"+ref_produit).setData({
      'myList.'+vueIdClient: false
    }).whenComplete((){
      messageToast("Ce Produit sera retiré de votre liste", Colors.red);
    }).onError((error, stackTrace){
      messageToast("Une erreur s'est produite lors de l'ajout dans ma liste.", Colors.red);
    });*/

  }else{
  print('doc '+ref_produit);
    try {
      Firestore.instance.document("ads/"+ref_produit)
          .updateData({'myList.'+vueIdClient: true}).whenComplete(() {
        //messageToast("AjoutE", Colors.green);
        /*ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
                content: const Text("L'article ajouté dans votre liste"),
                leading: const Icon(Icons.info),
                backgroundColor: Colors.blue,
                actions: [
                  TextButton(
                    child: const Text('Ok'),
                    onPressed: () => ScaffoldMessenger.of(context)
                        .hideCurrentMaterialBanner(),
                  ),]));*/
      });
    } on PlatformException catch (e) {
      print(e);
      messageToast("Une erreur s'est produite lors de l'ajout dans ma liste.", Colors.red);
      return;
    }
  }

}

messageToast(String toast, Color clr) {
  return Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 8,
      backgroundColor: clr,
      textColor: Colors.white);
}

 Future<void> postToFireStore (
{BuildContext context, String amount, category, subCategory, categoryUpperCase,
  description, city, color, model, phoneNumber,  photos,
  String productName, productNameLowerCase, province, userId, condition, anneefab}) async {
var reference = Firestore.instance.collection('ads');
try {
  reference.add({
    "adDate": DateTime.now().toString(),
    "adTime":  DateTime.now().millisecondsSinceEpoch.toString(),
    "amount": amount,
    "amountPaidForAD": 0,
    "category": category,
    "city": city,
    "color": color,
    "condition": condition,
    'categoryUpperCase': categoryUpperCase,
    'description': description,
    'expireDate':  DateTime.now().add( new Duration(days: 30)).toString(),
    'isApproved': true,
    'isExchange': false,
    'isAvailable': true,
    'isFeatured': false,
    'isPaid': false,
    'lastBillDate': anneefab,
    'latitude': '',
    'longitude': '',
    'manufactureYear': anneefab,
    'model': model,
    'myList': {},
    'paymentID': 'N/A',
    'phoneNumber': phoneNumber,
    'photos': photos,
    'productName': productName,
    'productNameArray':[],
    'productNameLowerCase': productNameLowerCase,
    'province': province,
    'status': '',
    'subCategory': subCategory,
    "userId": userId,
  }).then((value) async{
    var doc_id2 = value.documentID;
    Firestore.instance.collection('ads').document(value.documentID).updateData({
      "aDiD": value.documentID,
    }).whenComplete(() {
      popUp(context);
    });

  });
} on PlatformException catch (e) {
  print(e);
  return  messageToast("Une erreur s'est produite lors de votre poste dans Congo Chat. Si le probleme persiste, veuillez nous contacter.", Colors.red);

}
}

popUp(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Félicitation pour votre post sur Congo Achat. A Bientôt pour d'autres post."),
        actions: <Widget>[
          Center(child:Image.asset('assets/images/done.jpg')),
          FlatButton(
            child: new Text("Voir"),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder:
                      (context) => TabScreen()
                  ));
            },
          ),
        ],
      );
    },
  );
}


launchCall({@required String phone}) async {

  //const url = 'tel:$phone';
  if (await canLaunch('tel:'+phone)) {
    await launch('tel:'+phone);
  } else {
    throw messageToast("Numero incorrect", Colors.red);
  }
}

void sharePost(BuildContext context, String url, String title){
  final RenderBox box = context.findRenderObject();
  Share.share("Ce produit $title est disponible sur ce lien $url ",
      subject: "Article disponible",
      sharePositionOrigin:
      box.localToGlobal(Offset.zero) &
      box.size).toString();
}

String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
DateTime date = DateTime.parse(dateString);
final date2 = DateTime.now();
final difference = date2.difference(date);

String since = '';
//since = difference.inHours > 24 ? "Hier" : 'Il y a ${difference.inDays} jour${difference.inDays < 1 ? "" : 's' }';
if ((difference.inDays / 365).floor() >= 2) {
  since = 'Il y a ${(difference.inDays / 365).floor()} ans';
} else if ((difference.inDays / 365).floor() >= 1) {
  since = (numericDates) ? '1 année' : 'Année';
} else if ((difference.inDays / 30).floor() >= 2) {
  since = '${(difference.inDays / 365).floor()} mois';
} else if ((difference.inDays / 30).floor() >= 1) {
  since = (numericDates) ? '1 mois' : 'Mois';
} else if ((difference.inDays / 7).floor() >= 2) {
  since = '${(difference.inDays / 7).floor()} Semaines';
} else if ((difference.inDays / 7).floor() >= 1) {
  since = (numericDates) ? '1 semaine' : 'Semaine';
} else if (difference.inDays >= 2) {
  since = '${difference.inDays} jours';
} else if (difference.inDays >= 1) {
  since = (numericDates) ? '1 jour' : 'Hier';
} else if (difference.inHours >= 2) {
  since =  '${difference.inHours} heures';
} else if (difference.inHours >= 1) {
  since = (numericDates) ? '1 heure' : 'Une heure';
} else if (difference.inMinutes >= 2) {
  since = '${difference.inMinutes} minutes';
} else if (difference.inMinutes >= 1) {
  since = (numericDates) ? '1 minute' : 'Une minute';
} else if (difference.inSeconds >= 3) {
  since = '${difference.inSeconds} secondes';
} else {
  since = "A l'instat";
}
return since;
}

 String calculateTimeDifferenceBetween(
{@required String startDate0, @required String endDate0}) {
     DateTime endDate = DateTime.parse(endDate0);
     DateTime startDate = DateTime.parse(startDate0);
     int seconds = endDate.difference(startDate).inSeconds;


    if (seconds < 60)
    return 'Expire dans $seconds secondes';
    else if (seconds >= 60 && seconds < 3600)
    return 'Expire dans ${startDate.difference(endDate).inMinutes.abs()} minutes';
    else if (seconds >= 3600 && seconds < 86400)
    return 'Expire dans ${startDate.difference(endDate).inHours} heures';
    else
    return 'Expire dans ${startDate.difference(endDate).inDays} jours';
}

String timeSinceDate(String dateString, {bool numericDates = true}) {
  DateTime notificationDate = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUtc(dateString).toLocal();
  final date2 = DateTime.now();
  final difference = date2.difference(notificationDate);

  if (difference.inDays > 8) {
    return dateString;
  } else if ((difference.inDays / 7).floor() >= 1) {
    return (numericDates) ? 'Il y a une semaine' : 'Last week';
  } else if (difference.inDays >= 2) {
    return 'Il y a ${difference.inDays} jours';
  } else if (difference.inDays >= 2) {
    return 'Il y a ${difference.inDays / 365} moins';
  } else if (difference.inDays >= 1) {
    return (numericDates) ? 'Il y 1 jour' : 'Hier';
  } else if (difference.inHours >= 2) {
    return 'Il y a ${difference.inHours} heures';
  } else if (difference.inHours >= 1) {
    return (numericDates) ? 'Il y a une heure' : '1 heure';
  } else if (difference.inMinutes >= 2) {
    return 'Il y a ${difference.inMinutes} minutes';
  } else if (difference.inMinutes >= 1) {
    return (numericDates) ? '1 minute ago' : 'Une minute';
  } else if (difference.inSeconds >= 3) {
    return 'Il y a ${difference.inSeconds} secondes';
  } else {
    return "A l'instant";
  }
}






class TimeAgo{
  static String timeSinceDate(String dateString, {bool numericDates = true}) {
    DateTime notificationDate = DateFormat("yyyy-MM-ddTHH:mm:ssZ").parseUtc(dateString).toLocal();
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 semaine' : 'Last week';
    } else if (difference.inDays >= 2) {
      return 'Il y a ${difference.inDays} jours';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'Il y 1 jour' : 'Hier';
    } else if (difference.inHours >= 2) {
      return 'Il y a ${difference.inHours} heures';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? 'Il y a une heure' : '1 h';
    } else if (difference.inMinutes >= 2) {
      return 'Il y a ${difference.inMinutes} minutes';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'Une minute';
    } else if (difference.inSeconds >= 3) {
      return 'Il y a ${difference.inSeconds} sec';
    } else {
      return "A l'instant";
    }
  }



}

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData(
      backgroundColor: LightColor.background,
      primaryColor: LightColor.background,
      cardTheme: CardTheme(color: LightColor.background),
      textTheme: TextTheme(bodyText1: TextStyle(color: LightColor.black)),
      iconTheme: IconThemeData(color: LightColor.iconColor),
      bottomAppBarColor: LightColor.background,
      dividerColor: LightColor.lightGrey,
      primaryTextTheme:
      TextTheme(bodyText1: TextStyle(color: LightColor.titleTextColor)));

  static TextStyle titleStyle =
  const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
  const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);

  static List<BoxShadow> shadow = <BoxShadow>[
    BoxShadow(color: Color(0xfff8f8f8), blurRadius: 10, spreadRadius: 15),
  ];

  static EdgeInsets padding =
  const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static EdgeInsets hPadding = const EdgeInsets.symmetric(
    horizontal: 10,
  );

  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

class LightColor {
  static const Color background = Color(0XFFFFFFFF);

  static const Color titleTextColor = const Color(0xff1d2635);
  static const Color subTitleTextColor = const Color(0xff797878);

  static const Color skyBlue = Color(0xff2890c8);
  static const Color lightBlue = Color(0xff5c3dff);

  static const Color orange = Color(0xffE65829);
  static const Color red = Color(0xffF72804);

  static const Color lightGrey = Color(0xffE1E2E4);
  static const Color grey = Color(0xffA1A3A6);
  static const Color darkgrey = Color(0xff747F8F);

  static const Color iconColor = Color(0xffa8a09b);
  static const Color yellowColor = Color(0xfffbba01);

  static const Color black = Color(0xff20262C);
  static const Color lightblack = Color(0xff5F5F60);
}


class SharedPreferenceHelper {
  static String userIdKey = "userID";
  static String userNameKey = "name";
  static String displayNameKey = "name";
  static String userEmailKey = "email";
  static String userProfilePicKey = "avatar";



  //save data
  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserEmail(String getUseremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUseremail);
  }

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<bool> saveDisplayName(String getDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getDisplayName);
  }

  Future<bool> saveUserProfileUrl(String getUserProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePicKey, getUserProfile);
  }

  Future<bool> saveMalist(int nbr) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('malistCount', nbr);
  }

  // get data
  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<String> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<String> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  Future<int> getMessageCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('messageCount');
  }

  Future<int> getMalistCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('malistCount');
  }
}


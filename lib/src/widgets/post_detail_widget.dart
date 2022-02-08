import 'dart:io';

import 'package:congoachat/src/components/BorderIcon.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/utils/widget_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {
  final dynamic itemData;
  DetailPage({Key key,@required this.itemData}) : super(key: key);

  @override
  _DetailPage createState() => _DetailPage();
}
class _DetailPage extends State<DetailPage> {

  bool isLoading = true ;


  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    final double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    //final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width*0.20;
    return SafeArea(
      child: Scaffold(
        backgroundColor: COLOR_WHITE,
        body: isLoading ? Center(child: CircularProgressIndicator() ,)  : Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [

                        //Image.network(itemData.imageUrl),
                        Positioned(
                          width: size.width,
                          top: padding,
                          child: Padding(
                            padding: sidePadding,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: BorderIcon(
                                    height: 50,
                                    width: 50,
                                    child: Icon(Icons.keyboard_backspace,color: red,),
                                  ),
                                ),

                                InkWell(
                                  onTap: (){
                                    final RenderBox box = context.findRenderObject();
                                    Share.share(""+widget.itemData.productName+" sur ce lien avec plus des détails ",
                                        subject: "Découvrez cet article sur CongoAchat",
                                        sharePositionOrigin:
                                        box.localToGlobal(Offset.zero) &
                                        box.size);
                                  },
                                  child:  BorderIcon(
                                    height: 50,
                                    width: 50,
                                    child: Icon(Icons.share,color: red,),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    //Divider(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          InformationTile(content: Icon(Icons.add, color: red,)),
                          InformationTile(content: Icon(Icons.call_to_action_rounded, color: red,)),

                          InformationTile(content: IconButton(icon: Icon(Icons.message), onPressed:(){launchWhatsApp(phone: widget.itemData.phoneNumber, message: "Bonjour" );} ,) ),
                          InformationTile(content: IconButton(icon: Icon(Icons.call), onPressed: (){ _calling(phone: widget.itemData.phoneNumber);},)),
                        ],
                      ),
                    ),

                    addVerticalSpace(1.0),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Description",style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),

                    addVerticalSpace(padding),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(child:  Wrap(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.itemData.productName,style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),),
                                    addVerticalSpace(5),
                                    Text(widget.itemData.category,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.normal,
                                      ),),
                                    Text("CDF "+widget.itemData.amount,style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.normal,
                                    ),),
                                  ],
                                ),
                              ]
                          ))
                          //BorderIcon(child: Text(itemData.montant,style: themeData.textTheme.headline5,),padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 25),)
                        ],
                      ),
                    ),
                    addVerticalSpace(padding),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(widget.itemData.condition
                        ,textAlign: TextAlign.justify,style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),),

                    ),

                    //addVerticalSpace(100),
                  ],
                ),
              ),

              /*  Positioned(
                bottom: 10,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OptionButton(text: "WhatsApp",icon: Icons.message,width: size.width*0.42, onPress: (){launchWhatsApp(phone: widget.itemData.number_offre, message:  widget.itemData.demande );}, Couleur: COLOR_DARK_BLUE),
                    addHorizontalSpace(10),
                    OptionButton(text: "Appel",icon: Icons.call,width: size.width*0.35, onPress: (){ _calling(phone: widget.itemData.appel);}, Couleur: COLOR_DARK_BLUE),
                  ],
                ),
              ),*/

            ],
          ),

        ),

      ),

    );

  }

  @override
  void closeLoading(){
    setState(() => isLoading = false);
  }

  @override
  void showLoading(){
    setState(() => isLoading = true);
  }

  like(String ref_user, ref_offre) async {
    final response = await http
        .post("https://www.homeserviceimmo.com/Api_app/spacecrafts/api.php", body: {
      "action": 1.toString(),
      "ref_user": ref_user,
      "ref_offre": ref_offre,
      "fcm_token": "test_fcm_token"
    });

    final data =  jsonDecode(response.body);

    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      print(message);
      messageToast(message);
    }

  }

  messageToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

}

class InformationTile extends StatelessWidget{

  final Widget content;

  const InformationTile({Key key,@required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double tileSize = size.width*0.20;
    return Container(
      margin: const EdgeInsets.only(left: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BorderIcon(
            width: tileSize,
            height: tileSize,
            child: content,),
          addVerticalSpace(15),
        ],
      ),
    );

  }

}
void _calling({@required String phone}){
  _launchURL(phone: phone);
}


_launchURL({@required String phone}) async {

  //const url = 'tel:$phone';
  if (await canLaunch('tel:'+phone)) {
    await launch('tel:'+phone);
  } else {
    throw 'Could not launch tel:$phone';
  }
}

void launchWhatsApp(
    {@required String phone,
      @required String message,
    }) async {
  String url() {
    if (Platform.isIOS) {
      return "whatsapp://wa.me/$phone/?text=${Uri.parse(message.toString())}";
    } else {
      return "whatsapp://send?phone=$phone&text=${Uri.parse(message.toString())}";
    }
  }

  if (await canLaunch(url())) {
    await launch(url());
  } else {
    throw 'Could not launch ${url()}';
  }
}
import 'dart:io';

import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/webs/widget_tree.dart';
import 'package:congoachat/src/widgets/post_by_province.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProvinceWidget extends StatefulWidget {
  String categorys = '';
  ProvinceWidget({Key key,@required this.categorys}) : super(key: key);
  @override
  _ProvinceWidgetState createState() => _ProvinceWidgetState();
}

class _ProvinceWidgetState extends State<ProvinceWidget> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool _isConnected = false;
  String province;
  List<String> cityList = [];
  String citeSelected;

  final scaffoldKey = GlobalKey<ScaffoldState>(
      debugLabel: "scaffold-get-phone");

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty && response[0].rawAddress.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });
      }
    } on SocketException catch (err) {
      setState(() {
        _isConnected = false;
      });
      print(err);
    }
  }

  getCity(String prov) async{
    switch(prov){
      case "TOUTES LES PROVINCES":
        cityList = <String>["TOUTES LES VILLES"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;
      case "KINSHASA":
        cityList = <String>["KINSHASA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "HAUT-KATANGA":
        cityList = <String>["LUBUMBASHI",
          "LIKASI",
          "KAMBOVE",
          "KASENGA",
          "KIPUSHI",
          "MITWABA",
          "PWETO",
          "SAKANIA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "LUALABA":
        cityList = <String>["KOLWEZI", "DILOLO", "KAPANGA", "LUBUDI", "MUTSHATSHA", "SANDOA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "TANGANYIKA":
        cityList = <String>["KALEMIE", "KABALO", "KONGOLO", "MANONO", "MOBA", "NYUNZU"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "TSHOPO":
        cityList = <String>["KISANGANI",
          "BAFWASENDE",
          "BANALIA",
          "BASOKO",
          "ISANGI",
          "OPALA",
          "UBUNDU",
          "YAHUMA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KWILU":
        cityList = <String>["BANDUNDU",
          "KIKWIT",
          "BAGATA",
          "BULUNGU",
          "GUNGU",
          "IDIOFA",
          "MASIMANIMBA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "NORD KIVU":
        cityList = <String>["GOMA",
          "BUTEMBO",
          "BENI",
          "LUBERO",
          "MASISI",
          "NYIRAGONGO",
          "RUTSHURU",
          "WALIKALE"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "SUD KIVU":
        cityList = <String>[ "BUKAVU",
          "UVIRA",
          "FIZI",
          "IDWI",
          "KABARE",
          "KALEHE",
          "MWENGA",
          "SHABUNDA",
          "WALUNGU"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "LOMAMI":
        cityList = <String>["MWENE DITU",
          "NGANDAJIKA",
          "LUBAO",
          "LUILU",
          "KABINDA",
          "KAMIJI"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "HAUT LOMAMI":
        cityList = <String>["KAMINA", "BUKAMA", "KABONGO", "KANYAMA", "MALEMBA NKULU"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KASAI":
        cityList = <String>["TSHIKAPA", "ILEBO", "DEKESE", "LUEBO", "MWEKA", "KAMONIA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KASAI CENTRAL":
        cityList = <String>["KANANGA", "DIBAYA", "LUIZA", "DEMBA", "DIMBELENGE", "KAZUMBA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KASAI ORIENTAL":
        cityList = <String>[ "MBUJI MAYI",
          "KABEYA KAMWANGA",
          "KATANDA",
          "LUPATAPATA",
          "MIABI",
          "TSHILENGE"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KONGO CENTRAL":
        cityList = <String>["BOMA",
          "MATADI",
          "TSHELA",
          "KASANGULU",
          "KIMVULA",
          "MOANDA",
          "LUKULA",
          "LUOZI",
          "MADIMBA",
          "MBAZA NGUNGU",
          "SEKE BANZA",
          "SONGOLOLO"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "MANIEMA":
        cityList = <String>["KINDU",
          "KABAMBARE",
          "KASONGO",
          "KIBOMBO",
          "KAILO",
          "LUBUTU",
          "PANGI",
          "PUNIA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "SANKURU":
        cityList = <String>["LODJA", "LUSAMBO", "LUBEFU", "KATAKO KOMBE", "KOLE", "LOMELA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "EQUATEUR":
        cityList = <String>["MBANDAKA",
          "BASANKUSU",
          "BIKORO",
          "BOLOMBA",
          "BOMONGO",
          "INGENDE",
          "LUKOLELA",
          "MAKANZA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "ITURI":
        cityList = <String>["BUNIA", "ARU", "DJUGU", "IRUMU", "MAHAGI", "MAMBASA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;
      case "MAI NDOMBE":
        cityList = <String>[ "BOLOBO",
          "INONGO",
          "KIRI",
          "KUTU",
          "KWAMOUTH",
          "MUSHIE",
          "OSHWE",
          "YUMBI"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "MONGALA":
        cityList = <String>["LISALA", "BUMBA", "BONGANDANGA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KWANGO":
        cityList = <String>["KENGE", "KAHEMBA", "KASONGO LUNDA", "FESHI", "POPOKABAKA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "HAUT UELE":
        cityList = <String>["ISIRO",
          "DUNGU",
          "FARADJE",
          "NIANGARA",
          "RUNGU",
          "WAMBA",
          "WATSA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "BAS UELE":
        cityList = <String>["AKETI", "ANGO", "BAMBESA", "BONDO", "BUTA", "POKO"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "NORD UBANGI":
        cityList = <String>["GBADOLITE", "BOSOBOLO", "BUSINGA", "MOBAYI MBONGO", "YAKOMA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "SUD UBANGI":
        cityList = <String>["ZONGO", "GEMENA", "BUDJALA", "KUNGU", "LIBENGE"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "TSHUAPA":
        cityList = <String>["BEFALE", "BOENDE", "BOKUNGU", "DJOLU", "IKELA", "MONKOTO"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      default:
        cityList = <String>[];
        break;

    }
  }

  @override
  void initState() {
    super.initState();
    //this.getCity(province);
    _checkInternetConnection();
  }


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:  AppBar(
          title: Text(widget.categorys,
            style: TextStyle(color:black),
          ),
          backgroundColor: white,
          leading : IconButton(
              icon: Icon(Icons.arrow_back,
                size: 28,
                color: black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: ResponsiveLayout(
          iphone:  FormUi(),
          ipad: Row(
            children: [
              Expanded(
                flex: 9,
                child:  FormUi()
              ),
            ],
          ),
          macbook: Row(
            children: [
              /*Expanded(
                  flex: _size.width > 1340 ? 8 : 10,
                  child: ECommCat() //ECommerceItems(),
              ),*/
              Expanded(
                flex: _size.width > 1340 ? 3 : 5,
                child: Scaffold(
                  body:FormUi(),
                  floatingActionButtonLocation:  FloatingActionButtonLocation.startTop,
                  floatingActionButton: FloatingActionButton(
                    // isExtended: true,
                    child: const Icon(Icons.home_filled),
                    backgroundColor: red,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                          MaterialPageRoute(
                              builder: (context) => WidgetTree()),
                              (Route<dynamic> route) => false,
                          );
                    },
                  ),
                )
              )
            ],
          ),
        ));
  }



  @override
  void dispose() {
    super.dispose();
  }


  Widget FormUi(){
    return  Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Center(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 170.0,),
                  const Icon(Icons.location_on, size: 80),
                  Text("Vous recherchez dans quelle province ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal)),
                  const SizedBox(height: 30.0,),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 320.0,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)),
                    // dropdown below..
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: province,
                      style: const TextStyle(color: Colors.white),
                      icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                      iconSize: 42,
                      underline: const SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          province = newValue;
                          getCity(province);
                        });
                      },
                      items: <String>["TOUTES LES PROVINCES","KINSHASA", "HAUT-KATANGA", "LUALABA", "TANGANYIKA", "TSHOPO", "KWILU","NORD KIVU", "SUD KIVU", "LOMAMI",
                        "HAUT LOMAMI","KASAI","KASAI CENTRAL","KASAI ORIENTAL","KONGO CENTRAL","MANIEMA","SANKURU","EQUATEUR",
                        "ITURI","MAI NDOMBE","MONGALA","KWANGO","HAUT UELE","BAS UELE","NORD UBANGI","SUD UBANGI","TSHUAPA"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(color: Colors.black),),
                        );
                      }).toList(),
                      hint:const Text(
                        "PROVINCES",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),),

                  ),
                  const SizedBox(height: 12.0,),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 320.0,
                    decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(10)),
                    // dropdown below..
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: citeSelected,
                      style: const TextStyle(color: Colors.white),
                      icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                      iconSize: 42,
                      underline: const SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          citeSelected = newValue;
                        });
                      },
                      items: cityList.map((accountType) {
                        return DropdownMenuItem(
                          value: accountType,
                          child: Text(
                            accountType,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      hint:const Text(
                        "VILLES",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),),

                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : RaisedButton(
                      color:red,
                      onPressed: () {
                        if(province == "" || province == null && citeSelected == null || citeSelected == ""){
                          _showSnackBar("Veuillez choisir une Province et une ville.");
                        }else{
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PostByProvince(
                                categorys: widget.categorys, province: province,city: citeSelected,
                              )));
                        }
                      },
                      child: const Text(
                        "CONTINUER",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),

                    ),
                  )
                ]))));
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

}

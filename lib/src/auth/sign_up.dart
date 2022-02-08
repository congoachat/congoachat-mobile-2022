import 'dart:io';
import 'dart:math';

import 'package:congoachat/src/auth/firebase/auth/phone_auth/select_country.dart';
import 'package:congoachat/src/auth/firebase/auth/phone_auth/verify.dart';
import 'package:congoachat/src/auth/providers/countries.dart';
import 'package:congoachat/src/auth/providers/phone_auth.dart';
import 'package:congoachat/src/auth/utils/widgets.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  static final Random random = Random();
  double _height, _width, _fixedPadding;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final ref = Firestore.instance.collection('users');
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController dateNaissanceontroller = TextEditingController();
  String role, gender ;
  String province;
  List<String> cityList = [];
  String citeSelected;
  var randid = random.nextInt(10000);
  DateTime selectedDate = DateTime.now();

  bool _isConnected = false;
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateNaissanceontroller.text = picked.toString().split(" ").first;
      });
  }

  String _selectedDate = '';


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
    this._checkInternetConnection();
    this.getCity(province);
    //usernameController.text = nameController.text+"_"+randid.toString().replaceAll(" ", "");
    //dateNaissanceontroller.text = _selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    final _size  = MediaQuery.of(context).size;
    _fixedPadding = _height * 0.025;

    return Scaffold(
        key: scaffoldKey,
        backgroundColor: white,
        body: SafeArea(child: ResponsiveLayout(
          iphone: Scaffold(
            appBar:  AppBar(
              title: Text("S'inscrire",
                style: TextStyle(color:white),
              ),
              backgroundColor: red,
              leading : IconButton(
                  icon: Icon(Icons.arrow_back,
                    size: 28,
                    color: white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            body: Container(
                child: FormUi()
            ),),
          ipad: Row(
            children: [
              Expanded(
                flex: 9,
                child:Scaffold(
                  appBar:  AppBar(
                    title: Text("S'inscrire",
                      style: TextStyle(color:white),
                    ),
                    backgroundColor: red,
                    leading : IconButton(
                        icon: Icon(Icons.arrow_back,
                          size: 28,
                          color: white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  body: Container(
                      child: FormUi()
                  ),)
              ),
            ],
          ),
          macbook: Row(
            children: [
              Expanded(
                  flex: _size.width > 1340 ? 8 : 10,
                  child: ECommCat() //ECommerceItems(),
              ),
              Expanded(
                flex: _size.width > 1340 ? 3 : 5,
                child: Scaffold(
                  appBar:  AppBar(
                    title: Text("S'inscrire",
                      style: TextStyle(color:white),
                    ),
                    backgroundColor: red,
                    leading : IconButton(
                        icon: Icon(Icons.arrow_back,
                          size: 28,
                          color: white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  body: Container(
                    child: FormUi()
                ),)
              ),
            ],
          ),
        )  ));
  }

  Widget _Names(){
    return  Padding(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: "Entrez votre nom",
          ),
          // The validator receives the text that the user has entered.
          validator: (value) {
            if (value.isEmpty) {
              return 'Le nom est requis';
            }
            return null;
          },
          onChanged:(v){
            setState(() {
              usernameController.text = v.toLowerCase()+"_"+randid.toString().toLowerCase();
            });
          }
      ),
    );
  }

  Widget _userName(){
    return   Padding(
      padding: EdgeInsets.all(5.0),
      child: TextFormField(
        controller: usernameController,
        decoration: InputDecoration(
          labelText: "Nom d'utilisateur",
        ),
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value.isEmpty) {
            return "Le nom d'utilisateur rest requis ";
          }
          return null;
        },

      ),
    );
  }

  Widget FormUi(){
    final countriesProvider = Provider.of<CountryProvider>(context);
    final loader = Provider
        .of<PhoneAuthDataProvider>(context)
        .loading;
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Text("Inscrivez-vous",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700)),
                  Row(
                      children: [
                        Expanded(flex: 1, child: _Names()),
                        Expanded(flex: 1, child: _userName()),
                      ],
                  ),
                  Container(
                    color: white,
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 410.0,
                    // dropdown below..
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: gender,
                      style: TextStyle(color: Colors.white),
                      icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                      //icon: Icon(Icons.arrow_drop_down, color: Colors.black54,),
                      //iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          gender = newValue;
                        });
                      },
                      items: <String>["HOMME","FEMME"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black),),
                        );
                      }).toList(),
                      hint:Text(
                        "Sexe",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),),

                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text('Date de Naissance'),
                  ),
                  DatePickerWidget(
                    looping: false, // default is not looping
                    firstDate: DateTime(1950, 01, 01),
                    lastDate: DateTime(2012, 1, 1),
                    initialDate: DateTime(1997, 09, 06),
                    dateFormat: "dd-MMM-yyyy",
                    locale: DatePicker.localeFromString('en'),
                    onChange: (DateTime newDate, _) => _selectedDate = dateNaissanceontroller.text,
                    pickerTheme: DateTimePickerTheme(
                      itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                      dividerColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Entrez l'adresse Email",
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return "L'adresse e-mail est requise";
                        } else if (!value.contains('@')) {
                          return 'Email non valide';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 12.0),
                  //Text("${selectedDate.toLocal()}".split(' ')[0]),
                  /*Padding(
                    padding: EdgeInsets.all(12.0),
                    child:  SfDateRangePicker(
                      onSelectionChanged: _onSelectionChanged,
                      selectionMode: DateRangePickerSelectionMode.range,
                      initialSelectedRange: PickerDateRange(
                          DateTime.now().subtract(const Duration(days: 4)),
                          DateTime.now().add(const Duration(days: 3))),
                    )
                  ),*/
                  //  PhoneNumber TextFormFields
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child:  Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => SelectCountry()),
                            );
                          },
                          child: Text(countriesProvider.selectedCountry.dialCode ?? "+243", style: TextStyle(fontSize: 16.0)),
                        )
                        ,
                        SizedBox(width: 8.0),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Téléphone",
                            ),
                            controller: Provider
                                .of<PhoneAuthDataProvider>(context, listen: false)
                                .phoneNumberController,
                            autofocus: false,
                            keyboardType: TextInputType.phone,
                            key: Key('EnterPhone-TextFormField'),

                            validator: (value) {
                              if (value.isEmpty) {
                                return "Le numéro de téléphone est obligatoire";
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Container(
                    color: white,
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 410.0,
                    // dropdown below..
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: province,
                      style: TextStyle(color: Colors.white),
                      icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                      //icon: Padding(child: Icon(Icons.arrow_drop_down, color: Colors.black54,)),
                      //iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          province = newValue;
                          this.getCity(province);
                        });
                      },
                      items: <String>["TOUTES LES PROVINCES","KINSHASA", "HAUT-KATANGA", "LUALABA", "TANGANYIKA", "TSHOPO", "KWILU","NORD KIVU", "SUD KIVU", "LOMAMI",
                        "HAUT LOMAMI","KASAI","KASAI CENTRAL","KASAI ORIENTAL","KONGO CENTRAL","MANIEMA","SANKURU","EQUATEUR",
                        "ITURI","MAI NDOMBE","MONGALA","KWANGO","HAUT UELE","BAS UELE","NORD UBANGI","SUD UBANGI","TSHUAPA"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black),),
                        );
                      }).toList(),
                      hint:Text(
                        "Province",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),),

                  ),
                  SizedBox(height: 5.0,),
                  Container(
                    color: white,
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 410.0,
                    // dropdown below..
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: citeSelected,
                      style: TextStyle(color: Colors.white),
                      icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                      //icon: Icon(Icons.arrow_drop_down, color: Colors.black54,),
                      //iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          citeSelected = newValue;
                        });
                      },
                      items: cityList.map((accountType) {
                        return DropdownMenuItem(
                          value: accountType,
                          child: Text(
                            "$accountType",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      hint:Text(
                        "Ville",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),),

                  ),
                  SizedBox(height: 8.0,),
                  Container(
                    color: white,
                    padding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    width: 410.0,
                    // dropdown below..
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: role,
                      style: TextStyle(color: Colors.white),
                      icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                      //icon: Icon(Icons.arrow_drop_down, color: Colors.black54,),
                      //iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                        setState(() {
                          role = newValue;
                        });
                      },
                      items: <String>['Particulier','Entreprise'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: TextStyle(color: Colors.black),),
                        );
                      }).toList(),
                      hint:Text(
                        "Rôle",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),),

                  ),

                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(

                      color: red,
                      onPressed: () {
                        if(province == null || province == "Province"
                        && citeSelected == null || citeSelected == 'Ville' && role == null || role == "Rôle"
                        ){
                          _showSnackBar("Merci d'entrer toutes les informations.");
                        }else{
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            startPhoneAuth();
                          }
                        }

                      },

                      child: Text(
                        "CONTINUER",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),

                    ),
                  )
                ])));
  }


  Widget checkInternet(){
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child:Container(
                margin: EdgeInsets.symmetric(horizontal: 2.0),
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                    color:  Colors.grey[300],
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Image.asset("assets/images/no_internet.jpg"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Connexion internet non disponible.",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Vérifiez l'état de votre connexion.",
              style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 50),
            Container(
                height: 30.0,
                width: 125.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.redAccent,
                  color: Colors.red,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () { _checkInternetConnection();},
                    child: Center(
                      child: Text(
                        'Réessayer',
                        style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }


  Widget _rowField(){
    return Container(
      child: Row(
        children: [
          Text(
            "Vérifiez l'état de votre connexion.",
            style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            "Vérifiez l'état de votre connexion.",
            style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Text(
            "Vérifiez l'état de votre connexion.",
            style: TextStyle(color: black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    usernameController.dispose();
  }

  Future<String> savePref() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setString("name", nameController.text);
      preferences.setString("username", usernameController.text);
      preferences.setInt("balance", 0);
      preferences.setString("email", emailController.text);
      preferences.setString("phoneNumber", Provider
          .of<PhoneAuthDataProvider>(context, listen: false)
          .phoneNumberController.text);
      preferences.setString("avatar", null);
      preferences.setString("gender", gender);
      preferences.setString("dateNaissance", dateNaissanceontroller.text);
      preferences.setString("province", province);
      preferences.setString("city", citeSelected);
      preferences.setString("role", role);
      preferences.commit();
    });
  }



  startPhoneAuth() async {
    final phoneAuthDataProvider =
    Provider.of<PhoneAuthDataProvider>(context, listen: false);
    phoneAuthDataProvider.loading = true;
    var countryProvider = Provider.of<CountryProvider>(context, listen: false);
    bool validPhone = await phoneAuthDataProvider.instantiate(
        dialCode: countryProvider.selectedCountry.dialCode,
        onCodeSent: () {
          setState(() {
            savePref();
          });
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (BuildContext context) => PhoneAuthVerify()));
        },
        onFailed: () {
          setState(() {
            isLoading = false;
          });
          _showSnackBar(phoneAuthDataProvider.message);
        },
        onError: () {
          setState(() {
            isLoading = false;
          });
          _showSnackBar(phoneAuthDataProvider.message);
        });
    if (!validPhone) {
      setState(() {
        isLoading = false;
      });
      phoneAuthDataProvider.loading = false;
      _showSnackBar("Le numéro du téléphone est invalide");
      return;
    }
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

}

class SignUp1 extends StatefulWidget {
  SignUp1({Key key,}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUp1> {
  /// Tracks the active widget shown in the stack
  int _formIndex = 0;

  // Step 2 - Switch Between TextFields
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  // Step 3 - Fetch User Input
  var _email = '';
  var _password = '';

  // Step 4 - Validate User Input
  var _emailValid = false;
  var _emailError = '';
  var _passwordValid = false;
  var _passwordError = '';

  // Step 2 - Switch Between TextFields
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  /// Switches InputField by setting [_formIndex] to [newIndex]
  void _switchInputField(int newIndex) {
    setState(() {
      _formIndex = newIndex;
    });
    newIndex == 0
        ? FocusScope.of(context).requestFocus(_emailFocusNode)
        : FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  // Step 4 - Validate User Input
  /// Checks if email input fits common email pattern
  void _validateEmail() {
    if (RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email)) {
      setState(() {
        _emailValid = true;
        _emailError = '';
      });
    } else {
      setState(() {
        _emailValid = false;
        _emailError = 'Please enter a valid email address';
      });
    }
  }

  /// Checks if password input has at least 5 characters
  void _validatePassword() {
    if (_password.length >= 5) {
      setState(() {
        _passwordValid = true;
        _passwordError = '';
      });
    } else {
      setState(() {
        _passwordValid = false;
        _passwordError = 'Your password should contain at least 5 characters';
      });
    }
  }

  // Step 5 - Save The Form
  void _saveForm() {
    // implement your logic here
    /*showDialog(
      context: context,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(8),
        children: <Widget>[
          Text('You succesfully saved your form.'),
          RaisedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cool, thanks.'),
          ),
        ],
      ),
    );*/
  }

  // Step 1 - Set Up The UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("tesg"),
      ),
      body: Center(
        child: Card(
          elevation: 4,
          child: Container(
            height: 160,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IndexedStack(
                  index: _formIndex,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'eMail'),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,

                      // Step 3 - Fetch User Input
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      // Step 4 - Validate User Input
                      onSubmitted: (value) {
                        _validateEmail();
                        // Step 2 - Switch Between TextFields
                        if (_emailValid) {
                          _switchInputField(_formIndex + 1);
                        }
                      },
                      // Step 2 - Switch Between TextFields
                      focusNode: _emailFocusNode,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Password'),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      textInputAction: TextInputAction.done,

                      // Step 3 - Fetch User Input
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },

                      // Step 4 - Validate User Input
                      onSubmitted: (value) {
                        _validatePassword();
                        if (_passwordValid) {
                          _saveForm();
                        } else {
                          // Focus the TextField again after unsuccessful submit
                          FocusScope.of(context)
                              .requestFocus(_passwordFocusNode);
                        }
                      },

                      // Step 2 - Switch Between TextFields
                      focusNode: _passwordFocusNode,
                    ),
                  ],
                ),
                Container(
                  child: _formIndex == 0
                      ? Text(_emailError)
                      : Text(_passwordError),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _formIndex == 0
                        ? Container()
                        : FlatButton(
                      onPressed: () {
                        _switchInputField(_formIndex - 1);
                      },
                      child: Text('Back'),
                    ),

                    // Step 5 - Save The Form
                    _formIndex == 1
                        ? FlatButton(
                      onPressed: () {
                        _validatePassword();
                        if (_passwordValid) {
                          _saveForm();
                        }
                      },
                      child: Text('Submit'),
                    )
                        : FlatButton(
                      onPressed: () {
                        _validateEmail();
                        if (_emailValid) {
                          // Step 2 - Switch Between TextFields
                          _switchInputField(_formIndex + 1);
                        }
                      },
                      child: Text('Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}

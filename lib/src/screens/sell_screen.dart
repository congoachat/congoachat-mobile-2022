import 'dart:async';

import 'package:congoachat/main.dart';
import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/components/BorderIcon.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/type_category_model.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/view_photo.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

String ref_user;

class SellScreen extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<SellScreen> {
  bool uploading = false;
  double val = 0;
  int target = 0;

  String category;
  TextEditingController nameController = new TextEditingController();
  TextEditingController marqueController = new TextEditingController();
  TextEditingController amountController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController colorController = new TextEditingController();

  List<File> _image = [];
  final picker = ImagePicker();
  String province;
  List<String> cityList = [];
  List<String> catList = [];
  List<TypeCategoryModel> catList1 = new List<TypeCategoryModel>();
  TypeCategoryModel sousCategory;
  String citeSelected;
  final _formKey = GlobalKey<FormState>();

  String code = "",
      avatar = "",
      gender = "",
      phoneNumber = "",
      email = "",
      username = "",
      name = "",
      role = "",
      condition,
      anneedefab,
      subCat;
  bool isApproved;

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-get-phone");

  Future<void> getSession() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    name = preferences.getString("name");
    username = preferences.getString("username");
    email = preferences.getString("email");
    phoneNumber = preferences.getString("phoneNumber");
    gender = preferences.getString("gender");
    role = preferences.getString("role");
    isApproved = preferences.getBool("isApproved");
    avatar = preferences.getString("avatar");

    await preferences.commit();
    setState(() {});
  }

  getCategorie(cat) async {
    switch (cat) {
      case "AUTOMOBILE":
        catList1 = getAutomobiles();
        break;

      case "PROPRIETE":
        catList1 = getPropriete();
        break;

      case "ELECTRONIQUES":
        catList1 = getElectronic();
        break;

      case "FEMMES":
        catList1 = getWoman();
        break;

      case "HOMMES":
        catList1 = getMan();
        break;

      case "SPORTS":
        catList1 = getSports();
        break;

      case "JEUX":
        catList1 = getGames();
        break;

      case "LIVRES":
        catList1 = getBooks();
        break;

      case "DEMANDE D'EMPLOI":
        catList1 = getJobApplication();
        break;

      case "EMPLOI":
        catList1 = getJobOffer();
        break;

      case "ANIMAUX":
        catList1 = getAnimals();
        break;

      case "NOURRITURES":
        catList1 = getFoods();
        break;

      case "COMMUNAUTE":
        catList1 = getCommunity();
        break;

      case "BEBE":
        catList1 = getBaby();
        break;

      case "MAGASINS":
        catList1 = getShop();
        break;

      default:
        catList1 = getAutomobiles();
    }
  }

  getCity(String prov) async {
    switch (prov) {
      case "KINSHASA":
        cityList = <String>["KINSHASA"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "TOUTES LES PROVINCES":
        cityList = <String>["TOUTES LES VILLES"];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "HAUT-KATANGA":
        cityList = <String>[
          "LUBUMBASHI",
          "LIKASI",
          "KAMBOVE",
          "KASENGA",
          "KIPUSHI",
          "MITWABA",
          "PWETO",
          "SAKANIA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "LUALABA":
        cityList = <String>[
          "KOLWEZI",
          "DILOLO",
          "KAPANGA",
          "LUBUDI",
          "MUTSHATSHA",
          "SANDOA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "TANGANYIKA":
        cityList = <String>[
          "KALEMIE",
          "KABALO",
          "KONGOLO",
          "MANONO",
          "MOBA",
          "NYUNZU"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "TSHOPO":
        cityList = <String>[
          "KISANGANI",
          "BAFWASENDE",
          "BANALIA",
          "BASOKO",
          "ISANGI",
          "OPALA",
          "UBUNDU",
          "YAHUMA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KWILU":
        cityList = <String>[
          "BANDUNDU",
          "KIKWIT",
          "BAGATA",
          "BULUNGU",
          "GUNGU",
          "IDIOFA",
          "MASIMANIMBA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "NORD KIVU":
        cityList = <String>[
          "GOMA",
          "BUTEMBO",
          "BENI",
          "LUBERO",
          "MASISI",
          "NYIRAGONGO",
          "RUTSHURU",
          "WALIKALE"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "SUD KIVU":
        cityList = <String>[
          "BUKAVU",
          "UVIRA",
          "FIZI",
          "IDWI",
          "KABARE",
          "KALEHE",
          "MWENGA",
          "SHABUNDA",
          "WALUNGU"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "LOMAMI":
        cityList = <String>[
          "MWENE DITU",
          "NGANDAJIKA",
          "LUBAO",
          "LUILU",
          "KABINDA",
          "KAMIJI"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "HAUT LOMAMI":
        cityList = <String>[
          "KAMINA",
          "BUKAMA",
          "KABONGO",
          "KANYAMA",
          "MALEMBA NKULU"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KASAI":
        cityList = <String>[
          "TSHIKAPA",
          "ILEBO",
          "DEKESE",
          "LUEBO",
          "MWEKA",
          "KAMONIA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KASAI CENTRAL":
        cityList = <String>[
          "KANANGA",
          "DIBAYA",
          "LUIZA",
          "DEMBA",
          "DIMBELENGE",
          "KAZUMBA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KASAI ORIENTAL":
        cityList = <String>[
          "MBUJI MAYI",
          "KABEYA KAMWANGA",
          "KATANDA",
          "LUPATAPATA",
          "MIABI",
          "TSHILENGE"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "KONGO CENTRAL":
        cityList = <String>[
          "BOMA",
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
          "SONGOLOLO"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "MANIEMA":
        cityList = <String>[
          "KINDU",
          "KABAMBARE",
          "KASONGO",
          "KIBOMBO",
          "KAILO",
          "LUBUTU",
          "PANGI",
          "PUNIA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "SANKURU":
        cityList = <String>[
          "LODJA",
          "LUSAMBO",
          "LUBEFU",
          "KATAKO KOMBE",
          "KOLE",
          "LOMELA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "EQUATEUR":
        cityList = <String>[
          "MBANDAKA",
          "BASANKUSU",
          "BIKORO",
          "BOLOMBA",
          "BOMONGO",
          "INGENDE",
          "LUKOLELA",
          "MAKANZA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "ITURI":
        cityList = <String>[
          "BUNIA",
          "ARU",
          "DJUGU",
          "IRUMU",
          "MAHAGI",
          "MAMBASA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;
      case "MAI NDOMBE":
        cityList = <String>[
          "BOLOBO",
          "INONGO",
          "KIRI",
          "KUTU",
          "KWAMOUTH",
          "MUSHIE",
          "OSHWE",
          "YUMBI"
        ];
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
        cityList = <String>[
          "KENGE",
          "KAHEMBA",
          "KASONGO LUNDA",
          "FESHI",
          "POPOKABAKA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "HAUT UELE":
        cityList = <String>[
          "ISIRO",
          "DUNGU",
          "FARADJE",
          "NIANGARA",
          "RUNGU",
          "WAMBA",
          "WATSA"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "BAS UELE":
        cityList = <String>[
          "AKETI",
          "ANGO",
          "BAMBESA",
          "BONDO",
          "BUTA",
          "POKO"
        ];
        setState(() {
          citeSelected = cityList[0];
        });
        break;

      case "NORD UBANGI":
        cityList = <String>[
          "GBADOLITE",
          "BOSOBOLO",
          "BUSINGA",
          "MOBAYI MBONGO",
          "YAKOMA"
        ];
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
        cityList = <String>[
          "BEFALE",
          "BOENDE",
          "BOKUNGU",
          "DJOLU",
          "IKELA",
          "MONKOTO"
        ];
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
    this.getCity(province);
    this.getSession();

    // this.getCategorie();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return isApproved == true
        ? Scaffold(
            backgroundColor: white,
            body: ResponsiveLayout(
              iphone: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Vendre',
                    style: TextStyle(color: white),
                  ),
                  backgroundColor: red,
                ),
                body: Container(child: FormUi()),
              ),
              ipad: Row(
                children: [
                  Expanded(
                      flex: 9,
                      child: Scaffold(
                        appBar: AppBar(
                          title: Text(
                            'Vendre',
                            style: TextStyle(color: white),
                          ),
                          backgroundColor: red,
                        ),
                        body: Container(child: FormUi()),
                      )),
                ],
              ),
              macbook: Row(
                children: [
                  Expanded(
                      flex: _size.width > 1340 ? 8 : 10,
                      child: Scaffold(
                        appBar: AppBar(
                          title: Text(
                            'Vendre',
                            style: TextStyle(color: white),
                          ),
                          backgroundColor: red,
                        ),
                        body: Container(child: FormUi()),
                      )),
                  /*Expanded(
                  flex: _size.width > 1340 ? 8 : 10,
                  child: ECommCat() //ECommerceItems(),
              ),Expanded(
                flex: _size.width > 1340 ? 2 : 4,
                child: ECommerceDrawer(titleIsActiv: "Vendre"),
              ),*/
                ],
              ),
            ))
        : PhoneAuth();
  }

  Widget FormUi() {
    final Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: ListView(
          children: [
            SingleChildScrollView(
                child: Column(children: <Widget>[
              SizedBox(height: 12.0),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 410.0,
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  value: category,
                  style: TextStyle(color: Colors.white),
                  icon: Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  onChanged: (String newValue) {
                    setState(() {
                      category = newValue;
                      getCategorie(newValue);
                    });
                  },
                  items: <String>[
                    "AUTOMOBILE",
                    "PROPRIETE",
                    "ELECTRONIQUES",
                    "FEMMES",
                    "HOMMES",
                    "SPORTS",
                    "JEUX",
                    "LIVRES",
                    "DEMANDE D'EMPLOI",
                    "EMPLOI",
                    "ANIMAUX",
                    "NOURRITURES",
                    "COMMUNAUTE",
                    "BEBE",
                    "MAGASINS"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Catégorie",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                  padding: EdgeInsets.all(12.0),
                  width: 410.0,
                  child: DropdownButton<TypeCategoryModel>(
                    dropdownColor: Colors.white,
                    hint: Text("Sous Categorie"),
                    icon: Visibility(
                        visible: false, child: Icon(Icons.arrow_downward)),
                    value: catList1.isEmpty ? null : catList1[0],
                    onChanged: (TypeCategoryModel cat) {
                      setState(() {
                        sousCategory = cat;
                        subCat = cat.title;
                        this.getCategorie(cat.title);
                      });
                    },
                    items: catList1.map((TypeCategoryModel user) {
                      return DropdownMenuItem<TypeCategoryModel>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            //Icon(Icons.category),
                            //SizedBox(width: 10,),
                            Text(
                              user.title,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  )),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Le nom du produit",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Le nom est requis';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: marqueController,
                  decoration: InputDecoration(
                    labelText: "Marque",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'La marque est requise';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Prix de vente",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Le prix de vente est requis';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  controller: colorController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Couleur",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 410.0,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10)),
                // dropdown below..
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  value: condition,
                  style: TextStyle(color: Colors.white),
                  icon: Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  onChanged: (String newValue) {
                    setState(() {
                      condition = newValue;
                    });
                  },
                  items: <String>["NOUVELLE", "OCCASION"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Condition",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 410.0,
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10)),
                // dropdown below..
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  value: anneedefab,
                  style: TextStyle(color: Colors.white),
                  icon: Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  onChanged: (String newValue) {
                    setState(() {
                      anneedefab = newValue;
                    });
                  },
                  items: <String>[for (var i = 1940; i <= 2021; i++) '$i']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Année de Fabrication",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: TextFormField(
                  minLines:
                      6, // any number you need (It works as the rows for the textarea)
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: "Description",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'La description est requise';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: 410.0,
                // dropdown below..
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  value: province,
                  style: TextStyle(color: Colors.white),
                  icon: Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  onChanged: (String newValue) {
                    setState(() {
                      province = newValue;
                      this.getCity(province);
                    });
                  },
                  items: <String>[
                    "TOUTES LES PROVINCES",
                    "KINSHASA",
                    "HAUT-KATANGA",
                    "LUALABA",
                    "TANGANYIKA",
                    "TSHOPO",
                    "KWILU",
                    "NORD KIVU",
                    "SUD KIVU",
                    "LOMAMI",
                    "HAUT LOMAMI",
                    "KASAI",
                    "KASAI CENTRAL",
                    "KASAI ORIENTAL",
                    "KONGO CENTRAL",
                    "MANIEMA",
                    "SANKURU",
                    "EQUATEUR",
                    "ITURI",
                    "MAI NDOMBE",
                    "MONGALA",
                    "KWANGO",
                    "HAUT UELE",
                    "BAS UELE",
                    "NORD UBANGI",
                    "SUD UBANGI",
                    "TSHUAPA"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Province",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                width: 410.0,
                // dropdown below..
                child: DropdownButton<String>(
                  dropdownColor: Colors.white,
                  value: citeSelected,
                  icon: Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  style: TextStyle(color: Colors.white),
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
                  hint: Text(
                    "Ville",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Container(
                //padding: EdgeInsets.only(top: 5.0, right: 90),
                width: size.width,
                child: GridView.builder(
                    itemCount: _image.length + 1,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Center(
                              child: BorderIcon(
                                height: 70,
                                width: 90,
                                child: IconButton(
                                    color: red,
                                    icon: Icon(Icons.add_a_photo, size: 40),
                                    onPressed: () =>
                                        !uploading ? chooseImage() : null),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        ViewPhotoWidget(
                                            file: _image[index - 1])));
                              },
                              child: Container(
                                margin: EdgeInsets.all(2),
                                child: Container(
                                  margin: EdgeInsets.only(top: 1.0, left: 80),
                                  child: IconButton(
                                    icon:
                                        Icon(Icons.close, size: 40, color: red),
                                    onPressed: () {
                                      setState(() {
                                        _image.removeAt(index - 1);
                                      });
                                      //  print(_image.elementAt(index));
                                    },
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(_image[index - 1]),
                                        fit: BoxFit.cover)),
                              ),
                            );
                    }),
              ),
              Platform.isIOS
                  ? Padding(
                      padding: EdgeInsets.all(20.0),
                      child: uploading != true
                          ? CupertinoButton(
                              child: Text(
                                "Continuer",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              color: red,
                              disabledColor: greyColor,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  if (province == null ||
                                      province == '' && citeSelected == null ||
                                      citeSelected == '' && category == null ||
                                      category == "" && sousCategory == null ||
                                      sousCategory == "") {
                                    _showSnackBar(
                                        'Choisisez toutes les options');
                                  } else {
                                    if (_image.isEmpty || _image == null) {
                                      return messageToast(
                                          "Choisisez au-moins une photo",
                                          Colors.red);
                                    } else if (citeSelected == "" ||
                                        citeSelected == null ||
                                        province == "" ||
                                        province == null) {
                                      return messageToast(
                                          "Séléctionnez la province et la cité",
                                          Colors.red);
                                    } else {
                                      popUpWarning(context,
                                          "Voulez-vous partager votre annonce ?");
                                    }
                                  }
                                }
                              },
                            )
                          : CircularProgressIndicator())
                  : Padding(
                      padding: EdgeInsets.all(20.0),
                      child: uploading != true
                          ? RaisedButton(
                              color: red,
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  if (province == null ||
                                      province == '' && citeSelected == null ||
                                      citeSelected == '' && category == null ||
                                      category == "" && sousCategory == null ||
                                      sousCategory == "") {
                                    _showSnackBar(
                                        'Choisisez toutes les options');
                                  } else {
                                    if (_image.isEmpty || _image == null) {
                                      return messageToast(
                                          "Choisisez au-moins une photo",
                                          Colors.red);
                                    } else if (citeSelected == "" ||
                                        citeSelected == null ||
                                        province == "" ||
                                        province == null) {
                                      return messageToast(
                                          "Séléctionnez la province et la cité",
                                          Colors.red);
                                    } else {
                                      popUpWarning(context,
                                          "Voulez-vous partager votre annonce ?");
                                    }
                                  }
                                }
                              },
                              child: Text(
                                "Continuer",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                            )
                          : CircularProgressIndicator()),
              SizedBox(height: 50.0)
            ])),
          ],
        ));
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    if (pickedFile.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file.path));
      });
    } else {
      print(response.file);
    }
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Future<String> uploadImages() async {
    int i = 1;

    setState(() {
      uploading = true;
    });
    var uuid = Uuid().v1();
    final DateTime now = DateTime.now();
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String year = now.year.toString();
    final String today = ('$year-$month-$date');

    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child("ads")
        .child(today)
        .child("post_$uuid.jpeg");

    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });
      StorageUploadTask uploadTask =
          ref.putFile(img, StorageMetadata(contentType: 'image/jpeg'));
      await uploadTask.onComplete.whenComplete(() async {
        await ref.getDownloadURL().then((fileURL) {
          // _image.add(fileURL);
          setState(() {
            i++;
          });
        });
      });
    }

    if (i == 1) {
      messageToast("Action effectuee avec succes", Colors.green);
    } else {
      messageToast("Une erreur s'est produite", Colors.red);
    }
  }

  Future uploadMultipleImages() async {
    setState(() {
      uploading = true;
    });
    List<String> _imageUrls = List();
    int succesStatut = 1;
    final DateTime now = DateTime.now();
    final String month = now.month.toString();
    final String date = now.day.toString();
    final String year = now.year.toString();
    final String today = ('$year-$month-$date');

    try {
      for (int i = 0; i < _image.length; i++) {
        final StorageReference storageReference = FirebaseStorage.instance
            .ref()
            .child("ads")
            .child(today)
            .child("post_$i.jpeg");
        final StorageUploadTask uploadTask =
            storageReference.putFile(_image[i]);

        final StreamSubscription<StorageTaskEvent> streamSubscription =
            uploadTask.events.listen((event) {
          print('EVENT ${event.type}');
        });
        await uploadTask.onComplete;
        streamSubscription.cancel();

        String imageUrl = await storageReference.getDownloadURL();
        _imageUrls.add(imageUrl);
        succesStatut++;
      }

      await postToFireStore(
          context: context,
          amount: amountController.text,
          category: category,
          subCategory: subCat,
          categoryUpperCase: category.toUpperCase(),
          description: descriptionController.text,
          city: citeSelected,
          color: colorController.text,
          model: marqueController.text,
          phoneNumber: phoneNumber,
          photos: _imageUrls,
          productName: nameController.text,
          productNameLowerCase: nameController.text.toLowerCase(),
          province: province,
          userId: userId,
          condition: condition,
          anneefab: anneedefab);
    } catch (e) {
      print(e);
      setState(() {
        uploading = false;
      });
      messageToast(
          "Une erreur s'est produite lors de vente du produit.", Colors.red);
    }
  }

  popUpWarning(BuildContext context, String holder) {
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
                setState(() {
                  isApproved = false;
                });
              },
            ),
            FlatButton(
              child: new Text("Oui"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  uploading = true;
                });
                uploadMultipleImages();
              },
            ),
          ],
        );
      },
    );
  }
}

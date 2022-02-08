import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/components/custom_range_thumb_shape.dart';
import 'package:congoachat/src/components/custom_range_value_indicator_shape.dart';
import 'package:congoachat/src/components/widget_filter.dart';
import 'package:congoachat/src/constants.dart';
import 'package:congoachat/src/models/type_category_model.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:flutter/material.dart';


class FilterBottomSheetScreen extends StatefulWidget {
  @override
  _FilterBottomSheetScreenState createState() =>
      _FilterBottomSheetScreenState();
}

class _FilterBottomSheetScreenState extends State<FilterBottomSheetScreen> {
  double selectedValue;
  bool isLoading = false;
  RangeValues values = RangeValues(17.0, 100.0);
  TextEditingController entreController = TextEditingController();
  TextEditingController etController = TextEditingController();
  String province ;
  List<String> cityList = [];

  String citeSelected, category;
  List<TypeCategoryModel> catList1 = new List<TypeCategoryModel>();

  final _formKey = GlobalKey<FormState>();
  TypeCategoryModel sousCategory ;

  final scaffoldKey = GlobalKey<ScaffoldState>(
      debugLabel: "scaffold-get-phone");


  getCategorie(cat) async{
    switch(cat){
      case "AUTOMOBILE":
        catList1 =  getAutomobiles();

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

      case "SPORTS" :
        catList1 = getSports();
        break;

      case "JEUX":
        catList1 = getGames();
        break;

      case "LIVRES":
        catList1 = getBooks();
        break;

      case "DEMANDE D'EMPLOI" :
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




  getCity(String prov) async{
    switch(prov){
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
    this.getCity(province);
  }


  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Scaffold(body: ResponsiveLayout(
      iphone: _Filter(),
      ipad: Row(
        children: [
          Expanded(
            flex: 9,
            child:_Filter(),
          ),
        ],
      ),
      macbook: Row(
        children: [
          Expanded(
            flex: _size.width > 1340 ? 1 : 2,
            child: _Filter(),
          ),
          Expanded(
              flex: _size.width > 1340 ? 3 : 5,
              child: ECommCat() //ECommerceItems(),
          ),
        ],
      ),
    ));
  }

  Widget _Filter(){
    return Container(
        color: white,
        child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(child: Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Row(
                      children: <Widget>[
                        IconButton(onPressed:()=> Navigator.pop(context),  icon: Icon(Icons.arrow_back_ios, color: Colors.red)),

                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'QUE RECHERCHEZ-VOUS ?',
                            style: kTextLabelTheme,
                          ),
                        )

                      ],
                    ),
                    SizedBox(height: 12.0),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: 360.0,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      // dropdown below..
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: category,
                        //style: TextStyle(color: Colors.white),
                        icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                        //iconSize: 42,
                        //underline: SizedBox(),

                        onChanged: (String newValue) {
                          setState(() {
                            category = newValue;
                            getCategorie(newValue);
                          });
                        },
                        items: <String>["AUTOMOBILE", "PROPRIETE", "ELECTRONIQUES", "FEMMES", "HOMMES", "SPORTS","JEUX", "LIVRES", "DEMANDE D'EMPLOI",
                          "EMPLOI","ANIMAUX","NOURRITURES","COMMUNAUTE","BEBE","MAGASINS"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(color: Colors.black),),
                          );
                        }).toList(),
                        hint:Text(
                          "Catégorie",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),),

                    ),
                    SizedBox(height: 10.0),
                    Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        width: 360.0,
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<TypeCategoryModel>(
                          icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                          hint:  Text("Sous Categorie"),
                          value: catList1.isEmpty ? null: catList1[0],
                          onChanged: (TypeCategoryModel cat) {
                            setState(() {
                              sousCategory = cat;
                              this.getCategorie(cat.title);
                            });
                          },
                          items: catList1.map((TypeCategoryModel user) {
                            return  DropdownMenuItem<TypeCategoryModel>(
                              value: user,
                              child: Row(
                                children: <Widget>[
                                  //Icon(Icons.category),
                                  //SizedBox(width: 10,),
                                  Text(
                                    user.title,
                                    style:  TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        )
                    ),
                    /*Text("Province",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700)),*/
                    SizedBox(height: 5.0,),
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: 320.0,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      // dropdown below..
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: province,
                        style: TextStyle(color: Colors.white),
                        icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                        iconSize: 42,
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
                          "PROVINCES",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),),

                    ),
                    SizedBox(height: 12.0,),
                    /*Text("VILLES",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: black,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700)),*/
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      width: 320.0,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10)),
                      // dropdown below..
                      child: DropdownButton<String>(
                        dropdownColor: Colors.white,
                        value: citeSelected,
                        style: TextStyle(color: Colors.white),
                        icon: Visibility (visible:false, child: Icon(Icons.arrow_downward)),
                        iconSize: 42,
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
                          "VILLES",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),),

                    ),
                    Container(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Montant',
                            style: kTextLabelTheme,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: entreController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Minimum",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Entrez le montant minimum';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: etController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Maximum",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Montant maximum est requis';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 30.0,),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: isLoading
                          ? CircularProgressIndicator()
                          : RaisedButton(
                        color:red,
                        onPressed: () {

                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            if(province == "" || province == null && citeSelected == null || citeSelected == ""){
                              _showSnackBar("Veuillez choisir une Province et une ville.");
                            }else{
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FilterWidget(
                                    categorys: category, province: province,city: citeSelected, amount: entreController.text, amount2: etController.text,
                                  )));
                            }
                          }
                        },
                        child: Text(
                          "Filtrer",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),

                      ),
                    )

                  ],
                ),
              ),
              ),
            )));
  }

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}

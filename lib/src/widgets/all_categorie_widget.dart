import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/type_category_model.dart';
import 'package:congoachat/src/services/bloc/bloc_shop.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:congoachat/src/widgets/province_widget.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;


class CategoryWidget extends  StatefulWidget{
  String categorys = '';
  CategoryWidget({Key key,@required this.categorys}) : super(key: key);
  @override
 _CategoryWidgetState createState() => _CategoryWidgetState();
}


class _CategoryWidgetState extends State<CategoryWidget> {
  ShopBloc _shopBloc = BlocProvider.getBloc<ShopBloc>();
  bool liked = false;
  DateTime toDay;

  List<TypeCategoryModel> category = new List<TypeCategoryModel>();

  getCategorie() async{
    switch(widget.categorys){
      case "AUTOMOBILE":
        category = getAutomobiles();
        break;

      case "PROPRIETE":
        category = getPropriete();
        break;

      case "ELECTRONIQUES":
        category = getElectronic();
        break;

      case "FEMMES":
        category = getWoman();
        break;

      case "HOMMES":
        category = getMan();
        break;

      case "SPORTS" :
        category = getSports();
        break;

      case "JEUX":
        category = getGames();
        break;

      case "LIVRES":
        category = getBooks();
        break;

      case "OFFRE D'EMPLOI" :
        category = getJobApplication();
        break;

      case "DEMANDE D'EMPLOI":
        category = getJobOffer();
        break;

      case "ANIMAUX":
        category = getAnimals();
        break;

      case "NOURRITURES":
        category = getFoods();
        break;

      case "COMMUNAUTE":
        category = getCommunity();
        break;

      case "BEBE":
        category = getBaby();
        break;

      case "MAGASINS":
        category = getShop();
        break;

      default:
        category = getAutomobiles();
    }
  }

  @override
  void initState() {
    super.initState();
    print("Cat :"+widget.categorys);
    this.getCategorie();
  }


  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 25;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var width10 = MediaQuery.of(context).size.shortestSide / 10;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text(widget.categorys,
          style: TextStyle(color:  black),
        ),
        // backgroundColor: Color(0xFFFFFFFF),
        leading : IconButton(
            icon: Icon(Icons.arrow_back,
              size: 28,
              color:  black,
            ),
            onPressed: () {
              Navigator.pop(context);
            })
        ),
        body: ResponsiveLayout(
          iphone: SubCategoryList(),
          ipad: Row(
            children: [
              Expanded(
                flex: 9,
                child: SubCategoryList()
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
                  child: Padding(
                    padding: EdgeInsets.only(left: 300, right: 300),
                    child:  SubCategoryList()
                  )
                  //ECommerceItems(),
              ),

            ],
          ),
        ),
    );
  }


 Widget SubCategoryList(){
   return Container(
     //  height: 290.0,
       color: Colors.white,
       child: ListView.builder(
         shrinkWrap: true,
         itemCount: category.length,
         itemBuilder: (BuildContext context, int index) {
           TypeCategoryModel cat = category[index];
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               ListTile(
                 title: Text(cat.title),
                 onTap:(){
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => ProvinceWidget(
                         categorys: cat.title,
                       )));
                 },),
               Divider()
             ],
           );
         },
       )
   );
 }



}

import 'package:congoachat/src/components/BorderIcon.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/components/filter_bottomsheet_screen.dart';
import 'package:congoachat/src/screens/search_screen.dart';
import 'package:congoachat/src/widgets/gridCategory_widget.dart';
import 'package:flutter/material.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_item_description.dart';
import 'package:congoachat/src/webs/models/product_item.dart';

import '../k_padding.dart';
import '../responsive.dart';
import 'items/categories.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'items/e_commerce_item.dart';

class ECommerceItems extends StatefulWidget {
  const ECommerceItems({
    Key key,
  }) : super(key: key);

  @override
  _ECommerceItemsState createState() => _ECommerceItemsState();
}

class _ECommerceItemsState extends State<ECommerceItems> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    double padding = 0.0;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 250),
        child: ECommerceDrawer(),
      ),
      body: Container(
        padding: EdgeInsets.only(top: kIsWeb ? kPadding : 0),
        color: Theme.of(context).accentColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                      },
                      child:  BorderIcon(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.search,
                          color: black,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FilterBottomSheetScreen()));
                      },
                      child: BorderIcon(
                        height: 40,
                        width: 40,
                        child: Icon(
                          Icons.filter_alt,
                          color: black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //addVerticalSpace(20),
              Padding(
                  padding: sidePadding,
                  child: Center(child:Text(
                    "Achetez et Vendez Rapidement",
                    style: TextStyle(color: white, fontSize: 16.0, fontWeight: FontWeight.normal),
                  ),)
              ),
              SizedBox(height: 8.0,),
              Padding(
                  padding: sidePadding,
                  child:Center(child: Text(
                    "CONGO ACHAT",
                    style: TextStyle(color: white, fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),)
              ),
              SizedBox(height: 8.0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Text(
                  "QUE VOULEZ-VOUS ACHETER ?",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              //Categories(),
              Expanded(
                  child:  ListView(
                    children: [
                      GridView.count(
                          crossAxisCount: 3,
                          physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                          shrinkWrap: true, // You won't see infinite size error
                          children: List.generate(choices.length, (index) {
                            return Center(
                              child: ChoiceCard(choice: choices[index]),
                            );
                          }
                          )
                      )
                    ],
                  )
              ),
              /*Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    itemCount: products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: kPadding,
                      crossAxisSpacing: kPadding,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) => ECommerceItem(
                      /*  selected: ResponsiveLayout.isIphone(context)
                          ? false
                          : index == 0, */
                      item: products[index],
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ECommerceItemDescription(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}

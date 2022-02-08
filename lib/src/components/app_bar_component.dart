import 'package:congoachat/src/components/color.dart';
import 'package:flutter/material.dart';

class CongoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData themeData = Theme.of(context);
    double padding = 5.0;
    final sidePadding = EdgeInsets.symmetric(horizontal: padding);
    var width10 = MediaQuery.of(context).size.shortestSide / 10;
    return  Scaffold(
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Padding(
              padding: sidePadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){

                    },
                    child: Icon(Icons.search,color: Colors.red, size: 35,),
                  ),

                  InkWell(
                    onTap: (){},
                    child:Icon(
                        Icons.filter_alt,
                        color: Colors.red,
                        size: 35
                    ),
                  )
                ],
              ),
            ),
            //addVerticalSpace(20),
            Padding(
                padding: sidePadding,
                child: Center(child:Text(
                  "Acheter et Vendre Rapidement",
                  style: themeData.textTheme.bodyText2,
                ),)
            ),
            SizedBox(height: 10,),
            Padding(
                padding: sidePadding,
                child:Center(child: Text(
                  "CONGO ACHAT",
                  style: themeData.textTheme.headline6,
                ),)
            ),
            Padding(
                padding: sidePadding,
                child: Divider(
                  height: 25,
                  color: COLOR_GREY,
                )),
            // addVerticalSpace(10),

          ],
        ),);
  }
}
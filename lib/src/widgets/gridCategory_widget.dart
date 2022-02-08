import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/widgets/all_categorie_widget.dart';
import 'package:flutter/material.dart';

class GridCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
            body: Stack(
                fit: StackFit.expand,
                children: [
                  GridView.count(
                      crossAxisCount: 4,
                      children: List.generate(choices.length, (index) {
                      return Center(
                        child: ChoiceCard(choice: choices[index]),
                      );
                }))]),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final String icon;
}

const List<Choice> choices = const [
  const Choice(title: 'AUTOMOBILE', icon: "assets/images/surface1.png"),
  const Choice(title: 'PROPRIETE', icon: "assets/images/surface2.png"),
  const Choice(title: 'ELECTRONIQUES', icon: "assets/images/surface3.png"),
  const Choice(title: 'FEMMES', icon: "assets/images/females.png"),
  const Choice(title: 'HOMMES', icon: "assets/images/surface4.png"),
  const Choice(title: 'BEBE', icon: "assets/images/surface7.png"),
  const Choice(title: 'ANIMAUX', icon: "assets/images/cocker-spaniel.png"),
  const Choice(title: 'NOURRITURES', icon: "assets/images/diet.png"),
  const Choice(title: 'SPORTS', icon: "assets/images/surface5.png"),
  const Choice(title: 'LIVRES', icon: "assets/images/surface8.png"),
  const Choice(title: "DEMANDE D'EMPLOI", icon: "assets/images/job-search.png"),
  const Choice(title: "OFFRE D'EMPLOI", icon: "assets/images/businessman.png"),
  const Choice(title: 'JEUX', icon: "assets/images/surface6.png"),
  const Choice(title: 'MAGASINS', icon: "assets/images/shop.png"),
  const Choice(title: 'COMMUNAUTE', icon: "assets/images/community.png"),

];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child:Center(child: GestureDetector(child: Container(
        padding: AppTheme.hPadding,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
           // color: Colors.transparent,
            border: Border.all(
              color:  white,
              width: 1,
            ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 12.0),
              Image.asset(choice.icon, width: 40.0, height: 40.0),
              SizedBox(height: 5.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: Text(choice.title, style: TextStyle(color: Colors.black, fontSize: 10.0, )),
              )

          ],
        ),
        ),
        onTap:(){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryWidget(
                categorys: choice.title,
              )));
        },
      ))
    );
  }
}
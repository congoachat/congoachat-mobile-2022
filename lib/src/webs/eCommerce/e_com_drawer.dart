import 'package:congoachat/src/auth/phone_auth.dart';
import 'package:congoachat/src/auth/sign_up.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/ma_liste.dart';
import 'package:congoachat/src/screens/sell_screen.dart';
import 'package:congoachat/src/webs/widget_tree.dart';
import 'package:flutter/material.dart';

import '../k_padding.dart';
import '../responsive.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

import 'drawer/drawer_items.dart';

class ECommerceDrawer extends StatelessWidget {
  final String titleIsActiv ;
  const ECommerceDrawer({
    Key key,
    @required this.titleIsActiv
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kPadding : 0),
      color: red,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                        "images/logo-officiel.jpeg",
                        width: 150,
                      ),
                    radius: 20,
                  ),
                  Spacer(),
                  //if (!ResponsiveLayout.isMacbook(context)) CloseButton(),
                ],
              ),
             /* SizedBox(height: kPadding),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: 300,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: kPadding,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white.withOpacity(0.8))),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: kPadding),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: 300,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: kPadding,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.8))),
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {

                  },
                ),
              ),*/
              SizedBox(height: kPadding * 2),
              DrawerItems(
                onPressed: () {},
                title: "Mon Compte",
                icon: Icons.person_outline_outlined,
                selected: titleIsActiv == "Mon Compte" ? true : false,
              ),
              DrawerItems(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MalisteScreen()));
                },
                title: "Ma Liste",
                icon: Icons.list,
                selected: titleIsActiv == "Ma Liste" ? true : false,
              ),
              DrawerItems(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WidgetTree()));
                },
                title: "Shop",
                icon: Icons.shopping_bag_outlined,
                selected: titleIsActiv == "Shop" ? true : false,
              ),
              DrawerItems(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SellScreen()));
                },
                title: "Vendre",
                icon: Icons.add_a_photo,
                selected: titleIsActiv == "Vendre" ? true : false,
              ),
              DrawerItems(
                onPressed: () {},
                title: "Balance",
                icon: Icons.account_balance,
                selected: titleIsActiv == "Balance" ? true : false,
              ),
              DrawerItems(
                onPressed: () {},
                title: "Gift Cards",
                icon: Icons.card_giftcard,
                selected: titleIsActiv == "Mon Compte" ? true : false,
              ),
              DrawerItems(
                onPressed: () {},
                title: "Communication",
                icon: Icons.drafts_outlined,
              ),
              DrawerItems(
                onPressed: () {},
                title: "Messages",
                icon: Icons.message_outlined,
                number: 2,
                selected: titleIsActiv == "Messages" ? true : false,
              ),
              DrawerItems(
                onPressed: () {},
                title: "Mes Articles",
                icon: Icons.list_alt,
                selected: titleIsActiv == "Mes Articles" ? true : false,
              ),
              DrawerItems(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PhoneAuth()));
                },
                title: "Se Connecter",
                icon: Icons.login,
                selected: titleIsActiv == "Login" ? true : false,
              ),
              DrawerItems(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => InscriptionDrawer()));
                },
                title: "S'inscrire",
                icon: Icons.account_box_outlined,
                selected: titleIsActiv == "Insciption" ? true : false,
              ),

              SizedBox(height: kPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}

class InscriptionDrawer extends StatefulWidget {

  InscriptionDrawer();
  @override
  _InscriptionDrawerState createState() => _InscriptionDrawerState();
}


class _InscriptionDrawerState extends State<InscriptionDrawer> {

  @override
  Widget build(BuildContext context) {
    return SignUp();
  }
}

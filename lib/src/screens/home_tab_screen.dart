import 'dart:async';
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/main.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:congoachat/src/chats/all_message.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/models/post_model.dart';
import 'package:congoachat/src/screens/ma_liste.dart';
import 'package:congoachat/src/screens/menu_screen.dart';
import 'package:congoachat/src/screens/sell_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:congoachat/src/screens/shop_screen.dart';

int maList = 0, messageCount = 0;

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0, countMalist = 0;

  StreamController<int> _countController = StreamController<int>();
  int favoris = 0;

  Future<int> getFavoris() async {
    final CollectionReference _dbs = Firestore.instance.collection("ads");
    QuerySnapshot query =
        await _dbs.where('myList.' + client, isEqualTo: true).getDocuments();
    if (mounted) {
      setState(() {
        query.documents.forEach((DocumentSnapshot doc) {
          favoris = doc.data.length;
        });
      });
    }

    return favoris;
  }

  getMessageCount() async {
    maList = await SharedPreferenceHelper().getMessageCount();

    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMessageCount();
    getFavoris();
    print(favoris);
  }

  final Map<String, IconData> _icons = const {
    'Accueil': Icons.home,
    'Ma Liste': Icons.shopping_cart_outlined,
    'Vendre': Icons.add_outlined,
    'Message': Icons.message,
    'Menu': Icons.menu,
  };

  List<StatefulWidget> widgetsOptions = [
    ShopScreen(),
    MalisteScreen(),
    SellScreen(),
    AllMessageScreen(),
    MenuScreen()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return /*Platform.isIOS ?  CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.redAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Ma Liste',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.add),
            label: 'Vendre',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            title: Text("Menu"),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ShopScreen(),
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MalisteScreen(),
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SellScreen(),
              );
            });
            break;
          case 3:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: AllMessageScreen(),
              );
            });
            break;
          case 4:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MenuScreen(),
              );
            });
            break;
        }
        return returnValue;
      },
    ) : */
        Scaffold(
      //backgroundColor: red,
      body: Center(child: widgetsOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.black,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 25),
            title: const Text("Accueil"),
          ),
          BottomNavigationBarItem(
            icon: StreamBuilder(
              initialData: maList,
              stream: _countController.stream,
              builder: (_, snapshot) => Badge(
                  badgeColor: red,
                  badgeContent: Text(
                    favoris.toString() == null ? 0 : countMalist.toString(),
                    style: TextStyle(color: white),
                  ),
                  child: Icon(Icons.shopping_cart_outlined)),
            ),
            title: const Text("Ma liste"),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.add_outlined, size: 25),
            title: const Text("Vendre"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: const Text("Message"),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu, size: 25),
            title: const Text("Menu"),
          ),
        ],
        /*_icons
            .map((title, icon) => MapEntry(
            title,
            BottomNavigationBarItem(
              icon: Icon(icon, size: 30.0),
              title: Text(title),
            )))
            .values
            .toList(),*/
        currentIndex: _selectedIndex,
        selectedItemColor: red,
        selectedFontSize: 11.0,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 11.0,
        onTap: (index) => setState(() => _selectedIndex = index),
      ) /*ConvexAppBar(
        backgroundColor: red,
        style: TabStyle.fixedCircle,
        items: [
          TabItem(title: "Accueil", icon: Icons.home),
          messageCount == 0 ?  TabItem(title: "Ma Liste", icon: Badge(
              badgeColor: white,
              badgeContent: Text('$messageCount',
                style: TextStyle(color: black),
              ),
              child: Icon(Icons.shopping_cart_outlined, color: white))) : TabItem(title: "Ma Liste", icon: Icons.shopping_cart_outlined),
          TabItem(title: "Vendre", icon: Icons.add),

          TabItem(title: "Message", icon: Badge(
              badgeColor: white,
              badgeContent: Text('0',
                style: TextStyle(color: black),
              ),
              child: Icon(CupertinoIcons.conversation_bubble, color: white))),
          TabItem(title: "Menu", icon: Icons.menu)
        ],
        initialActiveIndex: _selectedIndex,
        onTap: _onItemTap,
      )*/
      ,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

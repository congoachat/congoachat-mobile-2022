import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/screens/shop_screen.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'eCommerce/e_com_drawer.dart';
import 'eCommerce/e_com_item_description.dart';
import 'eCommerce/e_com_items.dart';

class WidgetTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      //AppBar,
      body: ResponsiveLayout(
        iphone: TabScreen(),
        ipad: Row(
          children: [
            Expanded(
              flex: 9,
              child: ECommCat(),
            ),
            /*Expanded(
              flex: 9,
              child: PostWidget(), //ECommerceItemDescription(),
            ),*/
          ],
        ),
        macbook: Row(
          children: [
            Expanded(
                flex: _size.width > 1340 ? 3 : 5,
                child: ECommCat() //ECommCat() //ECommerceItems(),
                ),
            /*Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: PostWidget()
               ,
            ),Expanded(
              flex: _size.width > 1340 ? 2 : 4,
              child: ECommerceDrawer(titleIsActiv: "Shop"),
            ),*/
          ],
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _popupMenu() {
      return PopupMenuButton<int>(
        padding: EdgeInsets.all(0.0),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Container(
              width: 130,
              height: 50.0,
              child: Row(
                children: [
                  Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 05.0, top: 0.5),
                    child: Text("My Profile"),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: 2,
            child: Container(
              width: 130,
              height: 50.0,
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 05.0, top: 0.0),
                    child: Text("Favorite"),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: 3,
            child: Container(
              width: 130,
              height: 50.0,
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 05.0, top: 0.0),
                    child: Text("Cart"),
                  ),
                ],
              ),
            ),
          ),
          PopupMenuItem(
            value: 4,
            child: Container(
              width: 130,
              height: 50.0,
              child: Row(
                children: [
                  Icon(
                    Icons.login,
                    color: Colors.black,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 05.0, top: 0.0),
                    child: Text("Login"),
                  ),
                ],
              ),
            ),
          ),
        ],
        child: Padding(
          padding: EdgeInsets.only(top: 01.0),
          child: Icon(
            Icons.more_vert_outlined,
            color: Colors.black,
            size: 28.0,
          ),
        ),
      );
    }

    var currentWidth = MediaQuery.of(context).size.width;
    var extraLargeScreenGrid = currentWidth > 1536;
    var largeScreenGrid = currentWidth > 1366;
    var smallScreenGrid = currentWidth > 1201;
    var extraSmallScreenGrid = currentWidth > 1025;
    var tabScreenGrid = currentWidth > 769;
    var mobileScreenGrid = currentWidth > 481;

    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(right: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                extraSmallScreenGrid
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () {},
                          child: Icon(Icons.menu),
                        ),
                      ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: 45.0,
                        color: Colors.indigo[600],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 05.0, top: 08.0),
                        child: Text(
                          'Shopsnine',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.indigo[600],
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                extraLargeScreenGrid
                    ? Container(
                        height: 40.0,
                        margin: EdgeInsets.only(left: 180.0),
                        width: largeScreenGrid
                            ? 500.0
                            : smallScreenGrid
                                ? 500.0
                                : 400.0,
                        child: TextField(
                          cursorColor: Colors.indigo[600],
                          decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.0, bottom: 02.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.indigo[600],
                                  size: 22.0,
                                ),
                              ),
                              filled: true,
                              fillColor: Color(0xFFEEEEEE),
                              contentPadding:
                                  EdgeInsets.only(left: 25.0, top: 30.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontSize: 15.0),
                              hintText: 'Search here...'),
                          style:
                              TextStyle(fontSize: 16.0, color: Colors.black87),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          extraSmallScreenGrid
              ? Row(
                  children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          TextButton(
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(0.0),
                              ),
                              padding: EdgeInsets.all(18.0),
                            ),
                            onPressed: () {},
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  top: 05.0,
                                  right: 20.0,
                                  bottom: 05.0),
                              child: Text(
                                'Top Offers',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8.0,
                            top: 0.0,
                            child: Container(
                              height: 16.0,
                              width: 40.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  elevation: 0.0,
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(50.0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  'New',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(0.0),
                          ),
                          padding: EdgeInsets.all(18.0),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 20.0),
                              child: Text(
                                'Exclusive',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: TextButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(0.0),
                          ),
                          padding: EdgeInsets.all(18.0),
                        ),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0),
                              child: Text(
                                'Sale',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo[600],
                          elevation: 0.0,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(0.0),
                          ),
                          padding: EdgeInsets.all(18.0),
                        ),
                        onPressed: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 30.0, top: 0.0, right: 30.0, bottom: 0.0),
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          Row(
            children: [
              extraLargeScreenGrid
                  ? Container()
                  : Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Tooltip(
                        message: 'Search',
                        child: Container(
                          padding: EdgeInsets.all(05.0),
                          child: Icon(
                            Icons.search,
                            size: 25.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
              tabScreenGrid
                  ? Container(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Tooltip(
                        message: 'Cart',
                        child: Container(
                          padding: EdgeInsets.all(05.0),
                          child: Stack(
                            children: <Widget>[
                              Icon(
                                Icons.shopping_cart,
                                size: 26.0,
                                color: Colors.black87,
                              ),
                              Positioned(
                                right: 4.0,
                                top: 1.0,
                                child: Stack(
                                  children: <Widget>[
                                    Icon(
                                      Icons.brightness_1,
                                      size: 08.0,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Tooltip(
                  message: 'Notification',
                  child: Container(
                    padding: EdgeInsets.all(05.0),
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.notifications,
                          size: 26.0,
                          color: Colors.black87,
                        ),
                        Positioned(
                          right: 4.0,
                          top: 2.0,
                          child: Stack(
                            children: <Widget>[
                              Icon(
                                Icons.brightness_1,
                                size: 08.0,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _popupMenu(),
            ],
          ),
        ],
      ),
    );
  }
}

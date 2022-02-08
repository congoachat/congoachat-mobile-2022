import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'firebase/auth/phone_auth/get_phone.dart';



class PhoneAuth extends StatefulWidget {

  PhoneAuth();
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}


class _PhoneAuthState extends State<PhoneAuth> {

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(body: ResponsiveLayout(
      iphone: PhoneAuthGetPhone(),
      ipad: Row(
        children: [
          Expanded(
            flex: 9,
            child:PhoneAuthGetPhone()
          ),
        ],
      ),
      macbook: Row(
        children: [
          Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: PhoneAuthGetPhone()
          ),
          /*Expanded(
              flex: _size.width > 1340 ? 8 : 10,
              child: ECommCat() //ECommerceItems(),
          )*/
        ],
      ),
    ));
  }
}

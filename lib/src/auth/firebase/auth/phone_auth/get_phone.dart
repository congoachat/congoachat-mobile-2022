import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/auth/firebase/auth/phone_auth/select_country.dart';
import 'package:congoachat/src/auth/firebase/auth/phone_auth/verify.dart';
import 'package:congoachat/src/auth/firebase/auth/phone_auth/verifyLogin.dart';
import 'package:congoachat/src/auth/providers/countries.dart';
import 'package:congoachat/src/auth/providers/phone_auth.dart';
import 'package:congoachat/src/auth/sign_up.dart';
import 'package:congoachat/src/auth/utils/constants.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/widgets.dart';


class PhoneAuthGetPhone extends StatefulWidget {

  final Color cardBackgroundColor = white;
  final String logo = Assets.firebase;
  final String appName = "Connectez-vous";

  @override
  _PhoneAuthGetPhoneState createState() => _PhoneAuthGetPhoneState();
}

class _PhoneAuthGetPhoneState extends State<PhoneAuthGetPhone> {

  double _height, _width, _fixedPadding;
  TextEditingController passwordController = new TextEditingController();
  String username, password;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final scaffoldKey = GlobalKey<ScaffoldState>(
      debugLabel: "scaffold-get-phone");

  /*Future<void> checkPassword({String username, password}) async{


    Firestore.instance.collection('users').document(post.userId).get().then((DocumentSnapshot snapshot){
      setState(() {
        username = snapshot.data["username"];
        password = snapshot.data["password"];
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {

    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;
    final countriesProvider = Provider.of<CountryProvider>(context);
    final loader = Provider
        .of<PhoneAuthDataProvider>(context)
        .loading;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          backgroundColor: red,
          title: Text("Connexion",
            style: TextStyle(color:  white),
          ),
          // backgroundColor: Color(0xFFFFFFFF),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Center(
              child: SingleChildScrollView(
                child: _getBody(countriesProvider),
              ),
            ),
            loader ? CircularProgressIndicator() : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _getBody(CountryProvider countriesProvider) =>
      Container(
        color: widget.cardBackgroundColor,
        child: SizedBox(
          height: _height * 8 / 10,
          width: _width * 8 / 10,
          child: countriesProvider.countries.length > 0
              ? _getColumnBody(countriesProvider)
              : Center(child: CircularProgressIndicator()),
        ),
      );

  Widget _getColumnBody(CountryProvider countriesProvider) =>
      Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 40.0,),
         /* Padding(
            padding: EdgeInsets.all(_fixedPadding),
            child: PhoneAuthWidgets.getLogo(
                logoPath: widget.logo, height: _height * 0.2),
          ),*/
          Text(widget.appName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700)),

          Padding(
            padding: EdgeInsets.only(top: _fixedPadding, left: _fixedPadding),
            child: SubTitle(text: 'Séléctionnez votre pays'),
          ),

         /* Padding(
              padding:
              EdgeInsets.only(left: _fixedPadding, right: _fixedPadding),
              child: ShowSelectedCountry(
                country: countriesProvider.selectedCountry,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SelectCountry()),
                  );
                },
              )
          ),
          //  Subtitle for Enter your phone
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: _fixedPadding),
            child: SubTitle(text: 'Téléphone'),
          ),*/
          //  PhoneNumber TextFormFields
          Padding(
            padding: EdgeInsets.only(
                left: _fixedPadding,
                right: _fixedPadding,
                bottom: _fixedPadding),
            child: Card(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SelectCountry()),
                      );
                    },
                    child: Text(countriesProvider.selectedCountry.dialCode ?? "+243", style: TextStyle(fontSize: 16.0)),
                  )
                  ,
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      controller: Provider
                          .of<PhoneAuthDataProvider>(context, listen: false)
                          .phoneNumberController,
                      autofocus: false,
                      keyboardType: TextInputType.phone,
                      key: Key('EnterPhone-TextFormField'),

                      validator: (value) {
                        if (value.isEmpty) {
                          return "Le numéro de téléphone est obligatoire";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ) /*PhoneNumberField(
              controller:
              Provider
                  .of<PhoneAuthDataProvider>(context, listen: false)
                  .phoneNumberController,
              prefix: countriesProvider.selectedCountry.dialCode ?? "+243",
            ),*/
          ),

         /* Padding(
            padding: EdgeInsets.only(
                left: _fixedPadding,
                right: _fixedPadding,
                bottom: _fixedPadding),
            child: TextFormField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Mot de passe",
              ),
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value.isEmpty) {
                  return 'Entrez un mot de passe';
                } else if (value.length < 6) {
                  return 'Le mot de passe doit avoir au moins 6 characters!';
                }
                return null;
              },
            )
          ),*/

          /*
           *  Some informative text
           */
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: _fixedPadding),
              Icon(Icons.info, color: Colors.black, size: 20.0),
              SizedBox(width: 10.0),
              Expanded(
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Nous enverrons ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                  TextSpan(
                      text: 'Un code à usage unique',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: ' à ce numéro de portable',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w400)),
                ])),
              ),
              SizedBox(width: _fixedPadding),
            ],
          ),


          SizedBox(height: _fixedPadding * 1.5),
          RaisedButton(
            elevation: 16.0,
            onPressed: startPhoneAuth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Se connecter',
                style: TextStyle(
                    color: widget.cardBackgroundColor, fontSize: 18.0),
              ),
            ),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
          SizedBox(height: _fixedPadding * 1.5),
          RaisedButton(
            elevation: 16.0,
            onPressed: startSignup,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "S'inscrire",
                style: TextStyle(
                    color: widget.cardBackgroundColor, fontSize: 18.0),
              ),
            ),
            color: Colors.red,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
          ),
        ],
      );



  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  startSignup() async{
    Navigator.of(context).push(CupertinoPageRoute(
        builder: (BuildContext context) => SignUp()));
  }

  startPhoneAuth() async {
    final phoneAuthDataProvider =
    Provider.of<PhoneAuthDataProvider>(context, listen: false);
    phoneAuthDataProvider.loading = true;

    var countryProvider = Provider.of<CountryProvider>(context, listen: false);
    bool validPhone = await  phoneAuthDataProvider.instantiate(
        dialCode: countryProvider.selectedCountry.dialCode,
        onCodeSent: () {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (BuildContext context) => PhoneAuthVerifyLogin()));
        },
        onFailed: () {
          _showSnackBar(phoneAuthDataProvider.message);
        },
        onError: () {
          _showSnackBar(phoneAuthDataProvider.message);
        });
    if (!validPhone) {
      phoneAuthDataProvider.loading = false;
      _showSnackBar("Le numéro du téléphone est invalide");
      return;
    }
  }





}

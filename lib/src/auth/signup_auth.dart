import 'package:congoachat/src/auth/sign_up.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:congoachat/src/webs/eCommerce/e_com_drawer.dart';
import 'package:congoachat/src/webs/eCommerce/e_comm_cat.dart';
import 'package:congoachat/src/webs/responsive_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  double _height, _width, _fixedPadding;

  @override
  void initState() {
    super.initState();
  }

  getAndSaveUserToSession(String  user) async{

     await  Firestore.instance.collection('users').document("$user").get().then((DocumentSnapshot snapshot) async {

         print("document_build: $snapshot");
         SharedPreferences preferences = await SharedPreferences.getInstance();
         preferences.setString("userID", snapshot.data["userId"]);
         preferences.setString("name", snapshot.data['name']);
         preferences.setString("username", snapshot.data['username']);
         preferences.setString("email", snapshot.data['email']);
         preferences.setString("phoneNumber", snapshot.data['phoneNumber']);
         //preferences.setString("balance", snapshot.data['balance']);
         preferences.setString("gender",  snapshot.data["gender"]);
         preferences.setString("province", snapshot.data["province"]);
         preferences.setString("city", snapshot.data["city"]);
         preferences.setString("role", snapshot.data["role"]);
         preferences.setBool("isApproved",  snapshot.data["isApproved"]);
         preferences.setString("avatar", snapshot.data['avatar']);
         await preferences.commit();

      }).whenComplete((){
       Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context) => TabScreen()
       ));
     });

  }


  Future<bool> loginUser(String phone, BuildContext context) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    setState(() {
      _isLoading = true;
    });

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async{
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);
          FirebaseUser user = result.user;

          if(user != null){
            getAndSaveUserToSession(user.uid);
          }else{
            print("Error");
            setState(() {
              _isLoading = false;
            });
            messageToast("Un produit est survenu lors de votre connexion", Colors.red);
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception){
          print(exception);
          setState(() {
            _isLoading = false;
          });
          messageToast("$exception", Colors.red);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Entrez le code"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey[200])
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                borderSide: BorderSide(color: Colors.grey[300])
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: "Code de validation"

                        ),
                        controller: _codeController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Le numero du télephone est requis';
                          } else if (value.length != 6 ) {
                            return 'Le code est incomplet';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Valider"),
                      textColor: Colors.white,
                      color: red,
                      onPressed: () async{
                        final code = _codeController.text.trim();
                        AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: code);

                        AuthResult result = await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if(user != null){
                          getAndSaveUserToSession(user.uid);
                        }else{
                          print("Error");
                          setState(() {
                            _isLoading = false;
                          });
                          messageToast("Imposible de valider votre Code", Colors.red);
                        }
                      },
                    )
                  ],
                );
              }
          );
        },
        codeAutoRetrievalTimeout: null
    );
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _fixedPadding = _height * 0.025;
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Se connecter", style: TextStyle(color: Colors.white),),
          backgroundColor: red,
        ),
        body: ResponsiveLayout(
          iphone: Container(
              child: FormUi()
          ),
          ipad: Row(
            children: [
              Expanded(
                flex: 9,
                child:Container(
                    child: FormUi()
                ),
              ),
            ],
          ),
          macbook: Row(
            children: [
              Expanded(
                  flex: _size.width > 1340 ? 3 : 5,
                  child: ECommCat() //ECommerceItems(),
              ),
              Expanded(
                flex: _size.width > 1340 ? 8 : 10,
                child: Container(
                    child: FormUi()
                ),
              ),Expanded(
                flex: _size.width > 1340 ? 2 : 4,
                child: ECommerceDrawer(titleIsActiv: "Login"),
              ),
            ],
          ),
        )
    );
  }

  Widget FormUi(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text("Connectez-vous", style: TextStyle(color: Colors.lightBlue, fontSize: 18, fontWeight: FontWeight.w500),),

              SizedBox(height: 16,),

              TextFormField(
                maxLength: 9,
                maxLines: 9,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[200])
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(color: Colors.grey[300])
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    hintText: "Téléphone"

                ),
                controller: _phoneController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Le numero du télephone est requis';
                  } else if (!value.contains('+')) {
                    return 'Le numero doit avoir +243 comme prefixe';
                  }
                  return null;
                },
              ),
              SizedBox(height: 5,),
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

              SizedBox(height: 16,),


              _isLoading == false ? Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("Connexion"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    loginUser(phone, context);

                  },
                  color: red,
                ),
              ): Center(child: CircularProgressIndicator()),
              SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("S'inscrire"),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(16),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SignUp()
                    ));

                  },
                  color: red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
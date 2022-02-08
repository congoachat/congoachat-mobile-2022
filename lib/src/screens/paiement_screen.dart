import 'package:congoachat/main.dart';
import 'package:congoachat/src/components/color.dart';
import 'package:congoachat/src/screens/home_tab_screen.dart';
import 'package:congoachat/src/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaiementScreen extends StatefulWidget{

   final String aDid;
   const PaiementScreen({Key key,@required this.aDid}): super(key: key);

  @override
  _PaiementScreenState createState() => _PaiementScreenState();
}

class _PaiementScreenState extends State<PaiementScreen> {
  bool isSwitched = false, isLoading = false;

  String  airtelMoney = '0', mPaisaID = '0', orangeMoney = '0', accountNumber = "MY_BALANCE";
  TextEditingController transactionNumberController = TextEditingController();
  var ref = Firestore.instance.collection('users');

  int balance = 0, adPrinceinUSD = 0, taux = 0;
  int adPrinceinCDF = 0;
  String balanceView = "0";

  final _formKey = GlobalKey<FormState>();
  String methodePaiement = "MA BALANCE", messageFInal = "", messageWaring = "";



  Future<void> getSttings() async{
    await Future.delayed(Duration(milliseconds: 500));

    Firestore.instance.collection('app-settings').document("settings").get().then((DocumentSnapshot snapshot){
      setState(() {
        adPrinceinUSD= snapshot.data["adPriceinUSD"].toInt();
        airtelMoney = snapshot.data["airtelMoney"];
        mPaisaID = snapshot.data["mPaisaID"];
        orangeMoney = snapshot.data["orangeMoney"];
        taux = snapshot.data["tauxEchange"].toInt();
      });
    });
  }

  Future<void> yourBalance(String userID) async{

    ref.document("$userID").get().then((DocumentSnapshot snapshot){
      setState(() {
        balanceView = snapshot.data['balance'] == null ? "0" : NumberFormat.decimalPattern().format(snapshot.data['balance'].toInt());
        balance = snapshot.data['balance'] == null ? 0 : snapshot.data['balance'];
        adPrinceinCDF = 5000;
        messageWaring = "Nous allons prélever $adPrinceinUSD USD dans votre compte soit $adPrinceinCDF FC pour cet poste";
      });
    });
  }

  Future<void> updateBalance(String userID) async{
    ref.document('$userID').updateData({'balance': balance-adPrinceinCDF}).whenComplete(() {
          print("success");
          setState(() {
            balance = balance-adPrinceinCDF.toInt();
          });
    });
  }


  Future<void> ApprovedPost(String message, bool updateBalance) async{
    Firestore.instance.collection('ads').document(widget.aDid).updateData({
      'isExchange': false,
      'isFeatured': false,
      'isPaid': updateBalance,
      'paymentID': accountNumber,
    }).then((value) async{
      if(updateBalance == false){
        setState(() {
          isLoading = false;
        });
        return popUp(context, message, "");
      }else{
        setState(() {
          isLoading = false;
        });
        return popUp(context, message, userId);
      }
    });
  }

  popUp(BuildContext context, String message, userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
           Center(child:Image.asset('assets/images/done.jpg')),
            FlatButton(
              child: new Text("Terminer"),
              onPressed: () {
                if(userId == ""){

                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) => TabScreen()
                      ));
                }else{
                  this.updateBalance(userId).whenComplete(() =>
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder:
                              (context) => TabScreen()
                          )));
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      this.yourBalance(userId);
      this.getSttings();
      accountNumber = "MY_BALANCE";
      adPrinceinCDF = (adPrinceinUSD*taux);
    });
  }

  @override
  void dispose() {
    super.dispose();
    transactionNumberController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
        appBar:  AppBar(
          title: Text('Paiement',
            style: TextStyle(color:white),
          ),
          backgroundColor: red,
        ),
      body:Center(child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(children: <Widget>[
                SizedBox(height: 20.0,),
                Text("Paiement",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.normal)),
                SizedBox(height: 10.0,),
                SizedBox(height: 12.0),
                Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: 360.0,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(10)),
                  // dropdown below..
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    value: methodePaiement,
                    style: TextStyle(color: Colors.white),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black54,),
                    iconSize: 42,
                    underline: SizedBox(),
                    onChanged: (String newValue) {
                      setState(() {
                        methodePaiement = newValue;
                        if(newValue == "M-PESA"){
                          setState(() {
                            accountNumber = mPaisaID;
                            messageWaring = "Utiliser ce numéro $mPaisaID pour recharger votre compte via M-PESA.";
                          });
                        }else if(newValue == "ORANGE-MONEY"){
                          setState(() {
                            accountNumber = orangeMoney;
                            messageWaring = "Utiliser ce numéro $orangeMoney pour recharger votre compte via ORANGE-MONEY.";
                          });
                        }else if(newValue == "AIRTEL-MONEY"){
                          setState(() {
                            accountNumber = airtelMoney;
                            messageWaring = "Utiliser ce numéro $airtelMoney pour recharger votre compte via AIRTEL-MONEY.";
                          });
                        }else{
                          setState(() {
                            accountNumber = "MY_BALANCE";
                            adPrinceinCDF = (adPrinceinUSD*taux);
                          });
                          messageWaring = "Nous allons prélever $adPrinceinUSD USD dans votre compte soit $adPrinceinCDF CDF";
                        }
                      });
                    },
                    items: <String>["MA BALANCE","M-PESA","ORANGE-MONEY","AIRTEL-MONEY"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.black),),
                      );
                    }).toList(),
                    hint:Text(
                      "Moyen de Paiement",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ),),
                ),
                SizedBox(height: 15.0),
                methodePaiement == null || methodePaiement == "MA BALANCE"  ?
                Text("Votre Balance est de $balanceView CDF",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)) :
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: transactionNumberController,
                    decoration: InputDecoration(
                      labelText: "Numéro de transaction",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Le numero de transaction est obligatoire";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 3.0),
                Text("Prix : 3 USD ou 5 000 CDF",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 5.0),
                Text("Mode de Paiement : Balance, M-PESA, Orange-Money et Airtel Money",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 15.0),
                 Padding(
                  padding: EdgeInsets.all(20.0),
                  child: isLoading
                      ? CircularProgressIndicator()
                      : RaisedButton(

                    color: red,
                    onPressed: () {
                      if(methodePaiement != "MA BALANCE"){
                        if (_formKey.currentState.validate()) {
                          messageFInal = "Votre boost en attente de validation.";
                          popUpWarning(context, "Voulez-vous confirmer votre boost sur Congo Achat ?", false);
                        }
                      }else{
                        if(balance < adPrinceinCDF){
                          messageToast("Votre balance est insuffisante pour éffectuer cette opération.", Colors.red);
                        }else{
                          messageFInal = "Félicitation votre produit vient d'être sponsorisé par Congo Achat ";
                          popUpWarning(context, "Voulez-vous confirmer votre boost sur Congo Achat ?", true);
                        }
                      }

                    },

                    child: Text(
                      "CONFIRMER",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),

                  ),
                )
              ]))),
      ));
  }

  popUpWarning(BuildContext context, String holder, bool typeVente) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(holder),
          actions: <Widget>[
            FlatButton(
              child: new Text("Non"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: new Text("Oui"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  isLoading = true;
                });
                ApprovedPost(messageFInal, typeVente);
              },
            ),
          ],
        );
      },
    );
  }
}
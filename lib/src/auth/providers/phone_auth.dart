import 'package:congoachat/src/auth/firebase/auth/auth.dart';
import 'package:congoachat/src/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, VoidCallback;
import 'package:flutter/widgets.dart' show TextEditingController;
import 'package:shared_preferences/shared_preferences.dart';

enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut
}

class PhoneAuthDataProvider with ChangeNotifier {
  VoidCallback onStarted,
      onCodeSent,
      onCodeResent,
      onVerified,
      onFailed,
      onError,
      onAutoRetrievalTimeout;

  bool _loading = false;

  final TextEditingController _phoneNumberController = TextEditingController();

  PhoneAuthState _status;
  var _authCredential;
  String _actualCode;
  String _phone, _message;

  setMethods(
      {VoidCallback onStarted,
      VoidCallback onCodeSent,
      VoidCallback onCodeResent,
      VoidCallback onVerified,
      VoidCallback onFailed,
      VoidCallback onError,
      VoidCallback onAutoRetrievalTimeout}) {
    this.onStarted = onStarted;
    this.onCodeSent = onCodeSent;
    this.onCodeResent = onCodeResent;
    this.onVerified = onVerified;
    this.onFailed = onFailed;
    this.onError = onError;
    this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;
  }

  Future<bool> instantiate(
      {String dialCode,
      VoidCallback onStarted,
      VoidCallback onCodeSent,
      VoidCallback onCodeResent,
      VoidCallback onVerified,
      VoidCallback onFailed,
      VoidCallback onError,
      VoidCallback onAutoRetrievalTimeout}) async {
    this.onStarted = onStarted;
    this.onCodeSent = onCodeSent;
    this.onCodeResent = onCodeResent;
    this.onVerified = onVerified;
    this.onFailed = onFailed;
    this.onError = onError;
    this.onAutoRetrievalTimeout = onAutoRetrievalTimeout;

    if (phoneNumberController.text.length < 9) {
      return false;
    }
    phone = dialCode + phoneNumberController.text;
    print(phone);
    _startAuth();
    return true;
  }

  _startAuth() {
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      actualCode = verificationId;
      _addStatusMessage("\nEnter the code sent to " + phone);
      _addStatus(PhoneAuthState.CodeSent);
      if (onCodeSent != null) onCodeSent();
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      actualCode = verificationId;
      _addStatusMessage("\nAuto retrieval time out");
      _addStatus(PhoneAuthState.AutoRetrievalTimeOut);
      if (onAutoRetrievalTimeout != null) onAutoRetrievalTimeout();
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      _addStatusMessage('${authException.message}');
      _addStatus(PhoneAuthState.Failed);
      if (onFailed != null) onFailed();
      if (authException.message.contains('not authorized'))
        _addStatusMessage('App not authroized');
      else if (authException.message.contains('Network'))
        _addStatusMessage(
            "La connexion internet n'est pas stable ");
      else
        _addStatusMessage('Une erreur vient de se produire. Merci de réessayer ' +
            authException.message);
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      _addStatusMessage('Auto retrieving verification code');

      FireBase.auth.signInWithCredential(auth).then((AuthResult value) {
        if (value.user != null) {
          _addStatusMessage('Authentication successful');
          _addStatus(PhoneAuthState.Verified);
          if (onVerified != null) onVerified();
        } else {
          if (onFailed != null) onFailed();
          _addStatus(PhoneAuthState.Failed);
          _addStatusMessage('Le code que vous avez saisi est invalide');
        }
      }).catchError((error) {
        if (onError != null) onError();
        _addStatus(PhoneAuthState.Error);
        _addStatusMessage('Something has gone wrong, please try later $error');
      });
    };

    _addStatusMessage('Phone auth started');
    FireBase.auth
        .verifyPhoneNumber(
            phoneNumber: phone.toString(),
            timeout: Duration(seconds: 1000),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      if (onCodeSent != null) onCodeSent();
      _addStatus(PhoneAuthState.CodeSent);
      _addStatusMessage('Code sent');
    }).catchError((error) {
      if (onError != null) onError();
      _addStatus(PhoneAuthState.Error);
      _addStatusMessage(error.toString());
    });
  }

  Future<List<UserModel>> getUser(String user) async {
    final CollectionReference _dbs = Firestore.instance.collection("users");
    QuerySnapshot query =
    await _dbs
        .where("userID", isEqualTo: user)
        .limit(1)
        .getDocuments();

    List<UserModel> users = query.documents
        .map((doc) => UserModel.fromSnapshotJson(doc))
        .toList();

    return users;
  }

  void verifyOTPAndLogin({String smsCode}) async {
    _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    FireBase.auth
        .signInWithCredential(_authCredential)
        .then((AuthResult result) async {

          await  Firestore.instance.collection('users').document(result.user.uid).get().then((DocumentSnapshot snapshot) async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
            preferences.setString("userID", snapshot.data["userID"]);
            preferences.setString("name", snapshot.data['name']);
            preferences.setString("username", snapshot.data['username']);
            preferences.setString("email", snapshot.data['email']);
            preferences.setString("phoneNumber", snapshot.data['phoneNumber']);
            // preferences.setString("balance", snapshot.data['balance']);
            preferences.setString("gender",  snapshot.data["gender"]);
            preferences.setString("province", snapshot.data["province"]);
            preferences.setString("city", snapshot.data["city"]);
            preferences.setString("role", snapshot.data["role"]);
            preferences.setBool("isApproved",  snapshot.data["isApproved"]);
            preferences.setString("avatar", snapshot.data['avatar']);
          await preferences.commit();

         }).whenComplete((){

          _addStatusMessage('Authentication éfféctuée avec succès');
          _addStatus(PhoneAuthState.Verified);
          if (onVerified != null) onVerified();

        });

       /* SharedPreferences preferences = await SharedPreferences.getInstance();
          await  preferences.setString("userID", userID);
          await  preferences.setString("name", name);
          await  preferences.setString("username", username);
          await  preferences.setString("email", email);
          await  preferences.setString("phoneNumber", phoneNumber);
          await  preferences.setString("balance", balance);
          await  preferences.setString("gender", gender);
          await  preferences.setString("province", province);
          await  preferences.setString("city", city);
          await  preferences.setString("role", role);
          await  preferences.setBool("isApproved", isApproved);
          await  preferences.setString("avatar", avatar);
        await preferences.commit();*/

    }).catchError((error) {
      if (onError != null) onError();
      _addStatus(PhoneAuthState.Error);
      _addStatusMessage(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
  }

  void verifyOTPAndRegister({String smsCode, citeSelected, mail, name, province, gender, role, username, selectedDate}) async {
    _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);
    final ref = Firestore.instance.collection('users');

    FireBase.auth
        .signInWithCredential(_authCredential)
        .then((AuthResult result) async {
      if (onVerified != null) onVerified();
          ref.document(result.user.uid).setData({
            "adIDs": [],
            "avatar": "",
            "balance": 0,
            "city": citeSelected,
            "countryCode": "+243",
            "email": mail,
            "isApproved": true,
            "myList": [],
            "name": name,
            "phoneNumber": phone,
            "province": province,
            "gender": gender,
            "role": role,
            "userID": result.user.uid,
            "username":username,
            "dateNaissance": selectedDate,
          }).then((res) async{

            SharedPreferences preferences = await SharedPreferences.getInstance();
            await  preferences.setString("userID", result.user.uid);
            preferences.setBool("isApproved", true);
            preferences.setString("avatar", null);
            preferences.commit();
            this.getUser(result.user.uid);
            _addStatusMessage('Authentication éfféctuée avec succès');
            _addStatus(PhoneAuthState.Verified);

          });
      }).catchError((error) {
      if (onError != null) onError();

          _addStatus(PhoneAuthState.Error);
          _addStatusMessage(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
  }

  _addStatus(PhoneAuthState state) {
    status = state;
  }

  void _addStatusMessage(String s) {
    message = s;
  }

  get authCredential => _authCredential;

  set authCredential(value) {
    _authCredential = value;
    notifyListeners();
  }

  get actualCode => _actualCode;

  set actualCode(String value) {
    _actualCode = value;
    notifyListeners();
  }

  get phone => _phone;

  set phone(String value) {
    _phone = value;
    notifyListeners();
  }

  get message => _message;

  set message(String value) {
    _message = value;
    notifyListeners();
  }

  PhoneAuthState get status => _status;

  set status(PhoneAuthState value) {
    _status = value;
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  TextEditingController get phoneNumberController => _phoneNumberController;

}

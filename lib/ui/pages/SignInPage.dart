import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';
import 'MainPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isCodeSend = false;
  TextEditingController controllerPhoneNumber = TextEditingController();
  TextEditingController controllerCode = TextEditingController();
  String _verificationId;
  bool isPhoneNumberFull = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSend = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      auth.signInWithCredential(phoneAuthCredential).then((AuthResult value) {
        if (value.user != null) {
          user = value.user;
          // Handle loogged in state
          print(value.user.phoneNumber);
          if (value.user.displayName != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          }
        } else {
          showToast("error_validation_otp");
        }
      }).catchError((error) {
        showToast(error.toString());
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      showToast(authException.message, color: Colors.red);
      setState(() {
        isCodeSend = false;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    await auth.verifyPhoneNumber(
        phoneNumber: "+${controllerPhoneNumber.text}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void showToast(message, {Color color = Colors.black}) {
    print(message);
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: controllerCode.text);

    auth.signInWithCredential(_authCredential).then((AuthResult value) {
      if (value.user != null) {
        user = value.user;
        // Handle loogged in state
        print(value.user.phoneNumber);
        if (value.user.displayName != null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MainPage()));
        }
      } else {
        showToast("error_validation_otp", color: Colors.red);
      }
    }).catchError((error) {
      showToast("something_went_wrong");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Регистрация",
          style: Theme.of(context).textTheme.headline3,
        ),
        backgroundColor: Theme.of(context).appBarTheme.color,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isCodeSend
              ? Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextFormField(
                        controller: controllerCode,
                        decoration: InputDecoration(
                            labelText: "Код из СМС", hintText: "код из смс"),
                      ),
                      FlatButton(
                        color: Theme.of(context).accentColor,
                        onPressed: () {
                          _onFormSubmitted();
                        },
                        child: Text(
                          "Проверить код",
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                )
              : Container(
                  height: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextFormField(
                        onChanged: (value) {
                          if (value == "8") controllerPhoneNumber.text = "7";
                          setState(() {
                            isPhoneNumberFull = value.length > 10;
                          });
                        },
                        controller: controllerPhoneNumber,
                        decoration: InputDecoration(
                            labelText: "Номер телефона", hintText: ""),
                      ),
                      Opacity(
                          opacity: isPhoneNumberFull ? 1.0 : 0.4,
                          child: FlatButton(
                            color: Theme.of(context).accentColor,
                            onPressed: () {
                              if (isPhoneNumberFull) {
                                setState(() {
                                  _onVerifyCode();
                                });
                              }
                            },
                            child: Text(
                              "Получить смс с кодом",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ))
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

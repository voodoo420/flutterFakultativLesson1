import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool isCodeSend = false;
  TextEditingController controller = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Регистрация",
          style: TextStyle(color: Colors.black38),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isCodeSend?
          Container(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  controller: controller,
                  decoration:
                  InputDecoration(labelText: "Код из СМС", hintText: "код из смс"),
                ),
                FlatButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                     return MainPage();
                   }));
                  },
                  child: Text("Проверить код",
                    style: TextStyle(color: Colors.black38),),
                )
              ],
            ),
          )
              :  Container(
            height: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextFormField(
                  controller: controller,
                  decoration:
                      InputDecoration(labelText: "Номер телефона", hintText: "+7"),
                ),
                FlatButton(
                  color: Colors.greenAccent,
                  onPressed: () {
                    setState(() {
                      isCodeSend = true;
                      controller.text = "";
                    });
                  },
                  child: Text("Получить смс с кодом",
                      style: TextStyle(color: Colors.black38),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

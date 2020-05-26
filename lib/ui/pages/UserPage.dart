import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:image_picker/image_picker.dart';

import 'MainPage.dart';
import 'SignInPage.dart';

File userImage;

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  bool _showPassword = false;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      userImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Данные пользователя",
          style: Theme.of(context).textTheme.headline3,
        ),
        backgroundColor: Theme.of(context).appBarTheme.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: userName,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                hintText: "имя пользователя",
                labelText: "имя пользователя",
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                  labelText: "e-mail",
                  hintText: "e-mail"),
            ),
            SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.subtitle1,
              controller: password1,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                labelText: "пароль",
                hintText: ("не менее 6 символов"),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _toggleVisibility();
                  },
                  child: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              style: Theme.of(context).textTheme.subtitle1,
              controller: password2,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                ),
                labelText: "повторите пароль",
                suffixIcon: GestureDetector(
                  onTap: () {
                    _toggleVisibility();
                  },
                  child: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    getImage();
                    print("click");
                  },
                  child: Text(
                    "Добавить аватар",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FlatButton(
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    if (!email.text.contains("@")) {
                      showToast("не корректно указан email");
                    } else if (password1.text.length < 6) {
                      showToast("пароль должен быть более 6 символов");
                    } else if (password1.text != password2.text) {
                      showToast("пароли не совпадают");
                    } else {
                      _addUser();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    }
                  },
                  child: Text(
                    "Сохранить данные",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Center(
                child: userImage == null
                    ? Text('Аватар не выбран')
                    : Image.file(userImage,
                        width: 250, height: 250, fit: BoxFit.cover))
          ],
        ),
      ),
    );
  }

  void _addUser() {
    String id = user.uid;
    Map<String, dynamic> newUser = {
      "user": userName.text,
      "email": email.text,
      "password": password1.text,
      "phoneNumber": user.phoneNumber.toString(),
      "id": id
    };
    firestore.collection("users").document(id).setData(newUser);
  }

  void _toggleVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}

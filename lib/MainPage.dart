import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ChatPage.dart';
import 'package:flutterapp/ProfilePage.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


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
          "Наш Чат",
          style: TextStyle(color: Colors.black38),
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: ListView(

          padding: EdgeInsets.all(9),
          children: <Widget>[
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return ChatPage();
              }));
            },
            child: Container(
              margin: EdgeInsets.all(9.0),
              padding: EdgeInsets.all(9.0),
              decoration: BoxDecoration(color: Colors.white10,
                  border: Border.all( color: Colors.greenAccent )),
              child: Column (children: <Widget>[
                Text ('Название чата'),
                Text ("Последнее сообщение")
              ],)
              , ),
          ),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return ProfilePage();
              }));
            },
            splashColor: Colors.red,
            child: Container(
              margin: EdgeInsets.all(9.0),
              padding: EdgeInsets.all(9.0),
              decoration: BoxDecoration(color: Colors.white10,
                  border: Border.all( color: Colors.greenAccent )),
              child: Column (children: <Widget>[
                Text ('Название чата'),
                Text ("Последнее сообщение")
              ],)
              , ),
          ),
          Container(
            margin: EdgeInsets.all(9.0),
            padding: EdgeInsets.all(9.0),
            decoration: BoxDecoration(color: Colors.white10,
                border: Border.all( color: Colors.greenAccent )),
            child: Column (children: <Widget>[
              Text ('Название чата'),
              Text ("Последнее сообщение")
            ],)
            , ),

          Container(
            margin: EdgeInsets.all(9.0),
            padding: EdgeInsets.all(9.0),
            decoration: BoxDecoration(color: Colors.white10,
                border: Border.all( color: Colors.greenAccent )),
            child: Column (children: <Widget>[
              Text ('Название чата'),
              Text ("Последнее сообщение")
            ],)
            , ),
          Container(
            margin: EdgeInsets.all(9.0),
            padding: EdgeInsets.all(9.0),
            decoration: BoxDecoration(color: Colors.white10,
                border: Border.all( color: Colors.greenAccent )),
            child: Column (children: <Widget>[
              Text ('Название чата'),
              Text ("Последнее сообщение")
            ],)
            , )
          ],),
      ),
    );
  }
}

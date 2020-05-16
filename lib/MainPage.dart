import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';

List<Map<String, dynamic>> dataChats = [];

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    firestore.collection("chats").limit(100).snapshots().listen((event) {
      List<Map<String, dynamic>> data = [];

      event.documents.forEach((documentSnapshot) {
        data.add(documentSnapshot.data);
      });

      setState(() {
        dataChats = data;
      });
    });
    super.initState();
  }

  createNewChat(Map<String, dynamic> newChat){
    firestore.collection("chats").add(newChat);
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
        child: dataChats.isEmpty
            ? Text("loading")
            : ListView.builder(
          itemCount: dataChats.length,
          itemBuilder: (BuildContext context, int index) {
            return buildInkWell(context, message: dataChats[index]["message"].toString(),
                title: dataChats[index]["title"].toString() , isPrivate: dataChats[index]["private"]
            );
                },
              ),
      ),
    );
  }

  Widget buildInkWell(BuildContext context,
      {String message = "Последнее сообщение",
      String title = "",
      bool isPrivate = false}) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(9.0),
        padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: Colors.greenAccent)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[Text(title), Text(message)],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: isPrivate ? Icon(Icons.lock) : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/ui/widgets/drawer.dart';

import 'ChatPage.dart';

List<Map<String, dynamic>> dataChats = [];

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    getUser();
    firestore.collection("chats").orderBy("date").snapshots().listen((event) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          "Чаты",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Center(
        child: dataChats.isEmpty
            ? Text("loading")
            : ListView.builder(
                itemCount: dataChats.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildInkWell(context,
                      message: dataChats[index]["message"].toString(),
                      title: dataChats[index]["title"].toString(),
                      isPrivate: dataChats[index]["private"],
                      id: dataChats[index]["id"]);
                },
              ),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("chat name"),
                    content: TextFormField(
                      controller: _textFieldController,
                    ),
                    actions: [
                      FlatButton(
                        child: Text("cancel"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("create"),
                        onPressed: () {
                          if (_textFieldController.text != "") {
                            createChat(_textFieldController.text);
                            _textFieldController.clear();
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  );
                });
          }),
    );
  }

  void createChat(String title) {
    Map<String, dynamic> emptyChat = {
      "message": "",
      "title": "",
      "private": false,
      "date": ""
    };
    firestore.collection("chats").add(emptyChat).then((data) {
      String id = data.documentID;
      emptyChat = {
        "message": "empty",
        "title": title,
        "private": false,
        "id": id,
        "date": DateTime.now().millisecondsSinceEpoch
      };
      data.setData(emptyChat);
    });
  }

  Widget buildInkWell(BuildContext context,
      {String message = "Последнее сообщение",
      String title = "",
      bool isPrivate = false,
      String id = ""}) {
    return InkWell(
      onTap: () {
        _openChat(context, id, title);
      },
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).backgroundColor,
                title: Text("$title chat"),
                content: Text("delete?"),
                actions: [
                  FlatButton(
                    child: Text("delete"),
                    onPressed: () {
                      firestore.collection("chats").document(id).delete();
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text("no"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
      child: Container(
        margin: EdgeInsets.all(9.0),
        padding: EdgeInsets.all(9.0),
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border.all(color: Theme.of(context).accentColor)),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: Theme.of(context).textTheme.subtitle1),
                  Text(message, style: Theme.of(context).textTheme.bodyText1)
                ],
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

  void _openChat(BuildContext context, String id, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(id: id, title: title),
      ),
    );
  }

  void getUser() {
    auth.currentUser().then((value) => user = value);
  }
}

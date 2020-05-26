import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/ui/widgets/drawer.dart';

import 'ChatPage.dart';

class MainPage extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text(
          "Чаты",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: firestore
//              .collection("users")
//              .document(user.uid)
              .collection("chats")
              .orderBy("date", descending: true)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return buildInkWell(context,
                          title: snapshot.data.documents
                              .elementAt(index)["title"]
                              .toString(),
                          message: snapshot.data.documents
                              .elementAt(index)["message"]
                              .toString(),
                          isPrivate: snapshot.data.documents
                              .elementAt(index)["private"],
                          id: snapshot.data.documents
                              .elementAt(index)["id"]
                              .toString());
                    })
                : Text("loading");
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
                    backgroundColor: Theme.of(context).backgroundColor,
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
                      deleteChat(id);
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

  void createChat(String title) {
    String id;
    Map<String, dynamic> emptyChat = {
      "message": "",
      "title": "",
      "private": false,
      "date": ""
    };
    firestore.collection("chats").add(emptyChat).then((data) {
      id = data.documentID;
      emptyChat = {
        "message": "empty",
        "title": title,
        "private": false,
        "id": id,
        "date": DateTime.now().millisecondsSinceEpoch
      };
      data.setData(emptyChat);
      firestore
          .collection("users")
          .document(user.uid)
          .collection("chats")
          .document(id)
          .setData(emptyChat);
    });
  }

  void deleteChat(String id) {
    firestore.collection("chats").document(id).delete();
    firestore
        .collection("users")
        .document(user.uid)
        .collection("chats")
        .document(id)
        .delete();
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
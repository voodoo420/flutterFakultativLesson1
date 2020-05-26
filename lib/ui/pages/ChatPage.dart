import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';
import 'package:flutterapp/ui/pages/SignInPage.dart';

class ChatPage extends StatefulWidget {
  final String id;
  final String title;

  ChatPage({Key key, @required this.id, @required this.title})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState(id, title);
}

class _ChatPageState extends State<ChatPage> {
  final String id;
  final String title;

  _ChatPageState(this.id, this.title);

  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  List<Map<String, dynamic>> messages;
  String name;

  @override
  void initState() {
    firestore
        .collection("users")
        .document(user.uid)
        .snapshots()
        .listen((value) => name = value.data["user"]);

    firestore
        .collection("chats")
        .document(id)
        .collection("messages")
        .orderBy("date")
        .snapshots()
        .listen((event) {
      List<Map<String, dynamic>> data = [];
      event.documents.forEach((documentSnapshot) {
        data.add(documentSnapshot.data);
        print(documentSnapshot.data["message"]);
      });

      setState(() {
        messages = data;
        if (data.isNotEmpty) {
          Map<String, dynamic> lastMessageForUpdate = {
            "date": DateTime.now().millisecondsSinceEpoch,
            "message": "${data.last["name"]}: ${data.last["message"]}",
          };
          firestore
              .collection("chats")
              .document(id)
              .updateData(lastMessageForUpdate);
          firestore
              .collection("users")
              .document(user.uid)
              .collection("chats")
              .document(id)
              .updateData(lastMessageForUpdate);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add_call,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Theme.of(context).backgroundColor,
                        title: Text("добавить участника"),
                        content: TextFormField(
                          controller: _numberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixText: "+", labelText: "номер телефона"),
                        ),
                        actions: [
                          FlatButton(
                            child: Text("отмена"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("добавить"),
                            onPressed: () {
                              if (_numberController.text != "") {
                                print("+${_numberController.text}");
                                firestore
                                    .collection("users")
                                    .where("phoneNumber",
                                        isEqualTo: "+${_numberController.text}")
                                    .snapshots()
                                    .listen((event) {
                                  if (event.documents.length != 0) {
                                    String uid = event.documents[0]["id"];
                                    print(uid);
                                    Map<String, dynamic> chat = {
                                      "date":
                                          DateTime.now().millisecondsSinceEpoch,
                                      "private": false,
                                      "title": title,
                                      "message": "",
                                    };

                                    firestore
                                        .collection("users")
                                        .document(uid)
                                        .collection("chats")
                                        .document(id)
                                        .setData(chat);

                                    _numberController.clear();
                                    Navigator.pop(context);
                                  } else
                                    showToast(
                                        "+${_numberController.text} не найден в базе");
                                });
                              }
                            },
                          )
                        ],
                      );
                    });
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: Center(child: _buildSuggestions())),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: Theme.of(context).textTheme.subtitle1,
                controller: _textFieldController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).accentColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueGrey),
                  ),
                  hintText: 'введите сообщение',
                  suffixIcon: GestureDetector(
                    onTap: () => addMessage(),
                    child: Icon(
                      Icons.send,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  addMessage() {
    if (_textFieldController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "message": _textFieldController.text,
        "name": name,
        "date": DateTime.now().millisecondsSinceEpoch
      };
      print(id);
      firestore
          .collection("chats")
          .document(id)
          .collection("messages")
          .add(message);
      _textFieldController.clear();
    }
  }

  Widget _buildRow(String message) {
    return ListTile(
      title: Text(
        message,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildSuggestions() {
    if (messages.isEmpty) {
      return Text("chat is empty",
          style: Theme.of(context).textTheme.bodyText2);
    }
    return ListView.builder(
        padding: const EdgeInsets.all(4.0),
        itemCount: messages.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          var date = DateTime.fromMicrosecondsSinceEpoch(
              messages[index]["date"] * 1000);
          return _buildRow(
              "${messages[index]["name"]} ($date)\n${messages[index]["message"]}");
        });
  }
}

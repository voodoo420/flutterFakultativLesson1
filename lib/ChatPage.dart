import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/main.dart';

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

  final _biggerFont = const TextStyle(fontSize: 18.0);
  TextEditingController _textFieldController = TextEditingController();
  List<Map<String, dynamic>> messages;

  @override
  void initState() {
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
      });

      setState(() {
        messages = data;
        if (data.isNotEmpty) {
          Map<String, dynamic> lastMessageForUpdate = {
            "message": "${data.last["name"]}: ${data.last["message"]}",
          };
          firestore
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
            style: TextStyle(color: Colors.black38),
          ),
          backgroundColor: Colors.greenAccent,
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: Center(child: _buildSuggestions())),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  controller: _textFieldController,
                  decoration: InputDecoration(
                      suffix: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () => addMessage()),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey),
                      ),
                      hintText: 'Enter message')),
            ),
          ],
        ));
  }

  addMessage() {
    if (_textFieldController.text.isNotEmpty) {
      Map<String, dynamic> message = {
        "message": _textFieldController.text,
        "name": "You",
        "date": DateTime.now().millisecondsSinceEpoch
      };
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
        style: _biggerFont,
      ),
    );
  }

  Widget _buildSuggestions() {
    if (messages.isEmpty) {
      return Text("chat is empty", style: _biggerFont);
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

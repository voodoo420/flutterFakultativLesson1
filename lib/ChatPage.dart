import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _suggestions = <String>["Alexsey\nhello", "Alexsey\n1234",
    "Jane\nRangeError (index): Invalid value: Not in range 0..3, inclusive: 4",
    "Bob\nwhat's going on?", "Alexsey\nhello", "Bob\n hi",
    "Jane\nRangeError (index): Invalid value: Not in range 0..3, inclusive: 4",
    "Alexsey\nhello", "Alexsey\n1234", "Bob\nhello", "Alexsey\nhello"];

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
        child:_buildSuggestions()
      )
    );

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
    return ListView.builder(
        padding: const EdgeInsets.all(4.0),
        itemCount: _suggestions.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          final index = i ~/ 2;
          return _buildRow(_suggestions[index]);
        });
  }
}

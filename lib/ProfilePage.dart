import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            "Профиль",
            style: TextStyle(color: Colors.black38),
          ),
          backgroundColor: Colors.greenAccent,
        ),
        body: Container(
          padding: EdgeInsets.all(9.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  'https://www.freepngimg.com/thumb/face/8-will-smith-face-png-image.png',
                  fit: BoxFit.fill,
                  width: 100.0,
                  height: 100.0,
                ),
                Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text("Василий Уткин\n",
                            style: TextStyle(fontStyle: FontStyle.normal)),
                        Text("О себе:"),
                        Text(
                            "Журналист, блогер, гений, миллиардер, плейбой, филантроп."
                                " Учился в балашихинской школе № 2. Был комсомольцем, "
                                "вожатым в пионерском лагере. Закончил четыре курса "
                                "филологического факультета Московского педагогического "
                                "государственного университета им. В. И. Ленина. После "
                                "окончания пятого курса решил взять академический отпуск, "
                                "чтобы не идти в армию, но так и не вернулся к учёбе, как "
                                "не пошёл и в армию, поскольку журналистская карьера пошла в гору. "
                                "Диплома о высшем образовании не получил.",
                            style: TextStyle(fontStyle: FontStyle.italic))
                      ],
                    ))
              ]),
        ));
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/themes/custom_theme.dart';
import 'package:flutterapp/themes/themes.dart';
import 'package:flutterapp/ui/pages/UserPage.dart';

class MainDrawer extends StatelessWidget {
  void _changeTheme(BuildContext context, {MyThemeKeys key}) {
    if (CustomTheme.instanceOf(context).mythemeKey == MyThemeKeys.LIGHT)
      CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.DARK);
    else
      CustomTheme.instanceOf(context).changeTheme(MyThemeKeys.LIGHT);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          ListTile(
            title: Text("Поменять тему"),
            onTap: () {
              _changeTheme(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Профиль"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return UserPage();
              }));
            },
          )
        ],
      ),
    );
  }
}

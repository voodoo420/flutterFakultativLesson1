import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/themes/custom_theme.dart';
import 'package:flutterapp/themes/themes.dart';

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
      child: Column (children: <Widget>[
        ListTile (title: Text( "Поменять тему"),
          onTap: () {
            _changeTheme(context);
          },
        )
      ],),
    );
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/ui/pages/MainPage.dart';
import 'package:flutterapp/ui/pages/SignInPage.dart';
import 'package:flutterapp/themes/custom_theme.dart';
import 'package:flutterapp/themes/themes.dart';
import 'package:flutterapp/ui/pages/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance().then((value) {
    prefs = value;
    if (prefs != null && prefs.get("isDarkTeme") != null) {
      isDarkTheme = prefs.get("isDarkTeme");
    }
  });
  isDarkTheme = isDarkTheme == null ? false : isDarkTheme;

  runApp(
    CustomTheme(
      initialThemeKey: isDarkTheme ? MyThemeKeys.DARK : MyThemeKeys.LIGHT,
      child: MyApp(),
    ),
  );
}

Firestore firestore = Firestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser user;
SharedPreferences prefs;
bool isDarkTheme = false;
bool isAuthorized = false;

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    'Main': (BuildContext context) => MainPage(),
    'SingIn': (BuildContext context) => SignInPage()
  };

  @override
  Widget build(BuildContext context) {
    if (prefs.get("isAuthorized") == true) {
      return splash(context, 'Main');
    } else
      return splash(context, 'SingIn');
  }

  MaterialApp splash(BuildContext context, String route) {
    return MaterialApp(
        title: 'Наш чат',
        theme: CustomTheme.of(context),
        home: SplashScreen(nextRoute: route),
        routes: routes);
  }
}
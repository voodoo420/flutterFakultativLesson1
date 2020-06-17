import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/auth/auth_bloc.dart';
import 'package:flutterapp/ui/pages/MainPage.dart';
import 'package:flutterapp/ui/pages/SignInPage.dart';
import 'package:flutterapp/themes/custom_theme.dart';
import 'package:flutterapp/themes/themes.dart';
import 'package:flutterapp/ui/pages/SingInPageNew.dart';
import 'package:flutterapp/ui/pages/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/auth/bloc.dart';

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
      child: BlocProvider(
        create: (context) => AuthBloc()
        ..add(AuthStarted()),
        child: MyApp(),
      )
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state){
        if (state is NumberCheckAuthState || state is SmsCheckAuthState){
          return SingInPageNew();
        }
        if (state is SuccessAuthState){
          return MainPage();
        }
        return Center(child: Text("ошибка"));
      }
    ));
  }

//  final routes = <String, WidgetBuilder>{
//    'Main': (BuildContext context) => MainPage(),
//    'SingIn': (BuildContext context) => SignInPage()
//  };
//
//  @override
//  Widget build(BuildContext context) {
//    if (prefs.get("isAuthorized") == true) {
//      return splash(context, 'Main');
//    } else
//      return splash(context, 'SingIn');
//  }
//
//  MaterialApp splash(BuildContext context, String route) {
//    return MaterialApp(
//        title: 'Наш чат',
//        theme: CustomTheme.of(context),
//        home: SplashScreen(nextRoute: route),
//        routes: routes);
//  }
}
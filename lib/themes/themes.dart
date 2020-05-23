import 'package:flutter/material.dart';

import 'colors.dart';

enum MyThemeKeys {LIGHT, DARK}

class MyThemes {

  static final ThemeData lightThemeFcNnFonts = ThemeData(

    primaryColor: mainbackgroundlight,
    primaryColorDark: mainbackgroundlight,
    backgroundColor: mainbackgroundlight,
    accentColor: activbottombariconlight,
    scaffoldBackgroundColor: mainbackgroundlight,
    dialogBackgroundColor: Colors.greenAccent,
    brightness: Brightness.light,
    cardColor: boxlight,
    appBarTheme: AppBarTheme(
      color: mainbackgroundlight,
    ),
    textTheme: TextTheme(
      caption: TextStyle(color: redSelected, fontFamily: "exo",fontSize: 16 ),
      bodyText1: TextStyle(color: greytextbodylight),
      bodyText2: TextStyle(color: greytextbodylight,
        fontSize: 13,
        fontFamily: "exo",
      ),

      headline5: TextStyle(
        fontSize: 20,
        fontFamily: "exo",
        color: appbartexstlight,
          fontWeight: FontWeight.w700
      ),

      headline6: TextStyle(
          color: appbartexstlight,
          fontSize: 24,
          fontFamily: "exo",
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700
      ),

      subtitle2: TextStyle(color: appbartexstlight, fontSize: 20),

      headline4: TextStyle(
          color: noactivsdrawericonlight,
          fontSize: 24,
          fontFamily: "exo",
          letterSpacing: 1.1),

      // боковое меню  Веделенное текст и цвет иконок
      headline3: TextStyle(
          color: activbottombariconlight,
          fontSize: 24,
          fontFamily: "exo",
          letterSpacing: 1.1),

    ),
    primaryIconTheme: IconThemeData(color: appbartexstlight),
    tabBarTheme: TabBarTheme(
        unselectedLabelStyle: TextStyle(color: noactivbottombariconlight),
        labelStyle: TextStyle(color: activbottombariconlight),
        labelColor: activbottombariconlight,
        unselectedLabelColor: noactivbottombariconlight),
  );
  static final ThemeData darkThemeFcNnFonts = ThemeData(
    primaryColor: mainbackgrounddark,
    primaryColorDark: mainbackgrounddark,
    backgroundColor: mainbackgrounddark,
    accentColor: blueactivdark,
    scaffoldBackgroundColor: mainbackgrounddark,
    dialogBackgroundColor: Colors.black54,
    brightness: Brightness.dark,
    cardColor: boxdark,
    appBarTheme: AppBarTheme(
      color: mainbackgrounddark,
    ),
    textTheme: TextTheme(
      caption: TextStyle(color: redSelected, fontFamily: "exo",fontSize: 16 ),
      bodyText1: TextStyle(color: greytextbodydark),
      bodyText2: TextStyle(color: greytextbodydark,
        fontSize: 13,
        fontFamily: "exo",
      ),

      headline5: TextStyle(
        fontFamily: "exo",
        fontSize: 20,
        color: appbartexstdark,
          fontWeight: FontWeight.w700
      ),

      headline6: TextStyle(
          color: appbartexstdark,
          fontSize: 24,
          fontFamily: "exo",
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700
      ),

      subtitle2: TextStyle(color: appbartexstdark, fontSize: 18),

      headline4: TextStyle(
          color: noactivsdrawericondark,
          fontSize: 24,
          fontFamily: "exo",
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700
      ),

      // боковое меню  Веделенное текст и цвет иконок
      headline3: TextStyle(
          color: activbottombariconlight,
          fontSize: 24,
          fontFamily: "exo",
          letterSpacing: 1.1,
          fontWeight: FontWeight.w700
      ),
    ),


    primaryIconTheme: IconThemeData(color: appbartexstdark),
    tabBarTheme: TabBarTheme(
        unselectedLabelStyle: TextStyle(color: noactivbottombaricondark),
        labelStyle: TextStyle(color: activbottombariconlight),
        labelColor: activbottombariconlight,
        unselectedLabelColor: noactivbottombaricondark),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightThemeFcNnFonts;
      case MyThemeKeys.DARK:
        return darkThemeFcNnFonts;
      default:
        return lightThemeFcNnFonts;
    }
  }
}

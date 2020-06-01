import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final String nextRoute;

  SplashScreen({this.nextRoute});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation<Color> colorAnimation;
  AnimationController colorController;
  var duration = Duration(seconds: 3);
  var duration2 = Duration(milliseconds: 2500);

  @override
  void initState() {
    super.initState();

    colorController = AnimationController(vsync: this, duration: duration2);
    colorAnimation = ColorTween(begin: Colors.lightBlueAccent, end: Colors.blue)
        .chain(CurveTween(curve: Curves.easeInBack))
        .animate(colorController)
          ..addListener(() {
            setState(() {});
          });
    colorController.forward();

    Timer(duration, () {
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FadeInDownBig(
              duration: Duration(milliseconds: 500),
              child: Text('Ч',
                  style: TextStyle(fontSize: 32, color: colorAnimation.value))),
          SizedBox(width: 10),
          ElasticIn(
              child: Text('A',
                  style: TextStyle(fontSize: 32, color: Colors.blue))),
          SizedBox(width: 10),
          BounceInDown(
            child: Text('T',
                style: TextStyle(fontSize: 32, color: colorAnimation.value)),
          ),
          SizedBox(width: 10),
          BounceInRight(
              child: Flash(
            duration: duration,
            infinite: true,
            child:
                Text('_', style: TextStyle(fontSize: 32, color: Colors.blue)),
          )),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    colorController.dispose();
    super.dispose();
  }
}

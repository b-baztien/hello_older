import 'package:flutter/material.dart';
import 'package:hello_older/page/landing.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  static String tag = 'splash-page';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 5,
        navigateAfterSeconds: LandingPage(),
        imageBackground: AssetImage('assets/images/background.png'),
        loaderColor: UiData.themeColor);
  }
}

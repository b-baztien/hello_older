import 'package:flutter/material.dart';
import 'package:hello_older/page/splash.dart';
import 'package:hello_older/util/preference-setting.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => initializeDateFormatting('th_TH').then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PreferenceSettings();

    return MaterialApp(
      title: 'Hello Older',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: UiData.fontFamily,
        primarySwatch: UiData.themeMaterialColor,
      ),
      home: SplashPage(),
      routes: UiData.routes,
    );
  }
}

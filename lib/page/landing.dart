import 'package:flutter/material.dart';
import 'package:hello_older/util/uidata.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    _loadFirstTimeAppOpen();
  }

  _loadFirstTimeAppOpen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString(UiData.nameKey);
    bool isFirstTime = prefs.getBool(UiData.firstTimeKey);
    if (name != null &&
        isFirstTime != null &&
        name.isNotEmpty &&
        !isFirstTime) {
      // Not first time
      Navigator.pushNamedAndRemoveUntil(
        context,
        UiData.homeTag,
        ModalRoute.withName(UiData.homeTag),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        UiData.objectiveTag,
        ModalRoute.withName(UiData.objectiveTag),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

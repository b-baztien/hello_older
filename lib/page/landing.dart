import 'package:flutter/material.dart';
import 'package:hello_older/util/preference-setting.dart';
import 'package:hello_older/util/uidata.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  _loadFirstTimeAppOpen() async {
    await PreferenceSettings.initPreference();
    String name = PreferenceSettings.getUserNameStream().getValue();
    bool isFirstTime = PreferenceSettings.getFirstTime();
    if (isFirstTime != null && name.isNotEmpty && !isFirstTime) {
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
        ModalRoute.withName(UiData.homeTag),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadFirstTimeAppOpen();
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

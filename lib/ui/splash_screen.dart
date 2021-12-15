import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:svmdiresa/ui/login.dart';
import 'package:svmdiresa/ui/symptoms.dart';
import 'package:svmdiresa/ui/widgets/custom_splash.dart';

class SplashDisplay extends StatefulWidget {
  @override
  _SplashDisplayState createState() => new _SplashDisplayState();
}

bool startPage = false;

class _SplashDisplayState extends State<SplashDisplay> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPreferences();
  }

  void getPreferences() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var user = prefs.getString("id");
    if (user != null) {
      setState(() {
        startPage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/images/logo.png'),
      logoSize: 115,

      title: Text(
        "                        SVM \n Sistema de Vigilancia Materna",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.normal, color: Colors.white),
      ),
      backgroundColor: Colors.pink,
      showLoader: false,
      loadingText: Text(
        "DIRESA AYACUCHO",
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.normal, color: Colors.white),
      ),
      navigator: startPage ? SymptomScreen() : LoginScreen(),
      durationInSeconds: 3,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:svmdiresa/ui/attention_centers.dart';
import 'package:svmdiresa/ui/login.dart';
import 'package:svmdiresa/ui/menu.dart';
import 'package:svmdiresa/ui/obstetricians.dart';
import 'package:svmdiresa/ui/profile.dart';
import 'package:svmdiresa/ui/splash_screen.dart';
import 'package:svmdiresa/ui/symptoms.dart';
import 'package:svmdiresa/ui/symptons_response.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashDisplay());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/obstetrician':
        return MaterialPageRoute(builder: (_) => ObstreticianScreen());
      case '/centers':
        return MaterialPageRoute(builder: (_) => AttentionCenterScreen());
      case '/symptons':
        return MaterialPageRoute(builder: (_) => SymptomScreen());
      case '/symptons-response':
        return MaterialPageRoute(builder: (_) => SymptonResponseScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/menu':
        return MaterialPageRoute(builder: (_) => MenuScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
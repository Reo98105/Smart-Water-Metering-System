import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/dashboard.dart';
import 'package:swms_user_auth_module/login.dart';
import 'package:swms_user_auth_module/profile.dart';
import 'package:swms_user_auth_module/registration.dart';

class Router {
  var routeGenerator = <String, WidgetBuilder>{
    '/login': (context) => Login(),
    '/register': (context) => Register(),
    '/dashboard': (context) => Dashboard(),
    '/profile': (context) => Profile(),
  };
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

var routeGenerator = <String, WidgetBuilder>{
  '/login': (context) => Login(),
  '/register': (context) => Register(),
  '/dashboard': (context) => Dashboard(),
  '/profile': (context) => Profile(),
};

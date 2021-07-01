import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/addAcc.dart';
import 'package:swms_user_auth_module/analyticsAdmin.dart';
import 'package:swms_user_auth_module/analyticsPage.dart';
import 'package:swms_user_auth_module/dashboard.dart';
import 'package:swms_user_auth_module/dashboardAdmin.dart';
import 'package:swms_user_auth_module/login.dart';
import 'package:swms_user_auth_module/payment.dart';
import 'package:swms_user_auth_module/premise.dart';
import 'package:swms_user_auth_module/profile.dart';
import 'package:swms_user_auth_module/profileAdmin.dart';
import 'package:swms_user_auth_module/registration.dart';
import 'package:swms_user_auth_module/startController.dart';
import 'package:swms_user_auth_module/waterReading.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Start());
      case '/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => Dashboard());
      case '/dashboardAdmin':
        return MaterialPageRoute(builder: (_) => DashboardAdmin());
      case '/profile':
        return MaterialPageRoute(builder: (_) => Profile());
      case '/profileAdmin':
        return MaterialPageRoute(builder: (_) => ProfileAdmin());
      case '/register':
        return MaterialPageRoute(builder: (_) => Register());
      case '/addAcc':
        return MaterialPageRoute(builder: (_) => AddAcc());
      case '/waterReading':
        return MaterialPageRoute(builder: (_) => WaterReading());
      case '/payment':
        return MaterialPageRoute(builder: (_) => Payment());
      case '/premise':
        return MaterialPageRoute(builder: (_) => Premise());
      case '/analytics':
        return MaterialPageRoute(builder: (_) => AnalyticsPage());
      case '/analyticsAdmin':
        return MaterialPageRoute(builder: (_) => AnalyticsAdmin());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/addAcc.dart';
import 'package:swms_user_auth_module/addPremise.dart';
import 'package:swms_user_auth_module/analyticsAdmin.dart';
import 'package:swms_user_auth_module/analyticsPage.dart';
import 'package:swms_user_auth_module/dashboard.dart';
import 'package:swms_user_auth_module/dashboardAdmin.dart';
import 'package:swms_user_auth_module/login.dart';
import 'package:swms_user_auth_module/payment.dart';
import 'package:swms_user_auth_module/paymentFailed.dart';
import 'package:swms_user_auth_module/paymentSuccess.dart';
import 'package:swms_user_auth_module/premise.dart';
import 'package:swms_user_auth_module/profile.dart';
import 'package:swms_user_auth_module/profileAdmin.dart';
import 'package:swms_user_auth_module/registration.dart';
import 'package:swms_user_auth_module/Model/startController.dart';
import 'package:swms_user_auth_module/waterReading.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: settings, builder: (context) => Start());
      case '/login':
        return MaterialPageRoute(
            settings: settings, builder: (context) => Login());
      case '/dashboard':
        return MaterialPageRoute(
            settings: settings, builder: (context) => Dashboard());
      case '/dashboardAdmin':
        return MaterialPageRoute(
            settings: settings, builder: (context) => DashboardAdmin());
      case '/profile':
        return MaterialPageRoute(
            settings: settings, builder: (context) => Profile());
      case '/profileAdmin':
        return MaterialPageRoute(
            settings: settings, builder: (context) => ProfileAdmin());
      case '/register':
        return MaterialPageRoute(
            settings: settings, builder: (context) => Register());
      case '/addAcc':
        return MaterialPageRoute(
            settings: settings, builder: (context) => AddAcc());
      case '/addPremise':
        return MaterialPageRoute(
            settings: settings, builder: (context) => AddPremise());
      case '/waterReading':
        return MaterialPageRoute(
            settings: settings, builder: (context) => WaterReading());
      case '/payment':
        return MaterialPageRoute(
            settings: settings, builder: (context) => Payment());
      case '/premise':
        return MaterialPageRoute(
            settings: settings, builder: (context) => Premise());
      case '/analytics':
        return MaterialPageRoute(
            settings: settings, builder: (context) => AnalyticsPage());
      case '/analyticsAdmin':
        return MaterialPageRoute(
            settings: settings, builder: (context) => AnalyticsAdmin());
      case '/paySuccess':
        return MaterialPageRoute(
            settings: settings, builder: (context) => PaymentSuccess());
      case '/payFailed':
        return MaterialPageRoute(
            settings: settings, builder: (context) => PaymentFailed());
      default:
        return MaterialPageRoute(
            settings: settings,
            builder: (context) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}

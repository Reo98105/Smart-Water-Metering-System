import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/dashboard.dart';
import 'package:swms_user_auth_module/login.dart';
import 'package:swms_user_auth_module/registration.dart';

var routeGenerator = <String, WidgetBuilder>{
  '/login': (context) => Login(),
  '/register': (context) => Register(),
  '/dashboard': (context) => Dashboard(),
};

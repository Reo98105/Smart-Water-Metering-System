import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/Model/route_generator.dart';
import 'package:swms_user_auth_module/Model/startController.dart';

void main() => runApp(
      MaterialApp(
        home: Start(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );

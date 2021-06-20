import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/Model/route_generator.dart';
import 'package:swms_user_auth_module/startController.dart';

void main() => runApp(
      MaterialApp(
        home: Start(),
        routes: routeGenerator,
      ),
    );

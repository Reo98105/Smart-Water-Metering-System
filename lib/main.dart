import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/Model/route_generator.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );

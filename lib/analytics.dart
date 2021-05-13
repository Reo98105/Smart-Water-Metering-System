import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Analytics extends StatefulWidget {
  @override
  _AnalyticsState createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Analytics"),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Container());
  }

  //get accNum from sharedPreferences
  getAccNum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var accList = prefs.getStringList('accNumList');
    return accList;
  }
}

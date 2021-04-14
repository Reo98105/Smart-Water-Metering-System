import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
        backgroundColor: Colors.lightBlueAccent,
        
      ),
    );
  }
}
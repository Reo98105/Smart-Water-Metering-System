import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DAO/accountDAO.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int userid;
  AccountDAO accountDAO = new AccountDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: ElevatedButton.icon(
          onPressed: () {
            //accountDAO.getAcc(_getUserid());
          },
          icon: Icon(Icons.admin_panel_settings),
          label: Text('Test'),
        ),
      ),
    );
  } //get userid

  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }
}

import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/Model/user.dart';

class ProcessRegister {
  User user;
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey[300],
      content: new Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Text('Loading...'),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

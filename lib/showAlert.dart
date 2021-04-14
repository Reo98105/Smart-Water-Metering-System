import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/dashboard.dart';
import 'package:swms_user_auth_module/login.dart';

class ShowAlert {
  //processing alert dialog
  showLoadingDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: new Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text('Processing...'),
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

  //register success alert dialog
  showRSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          },
          child: Text('Back to login'),
        ),
      ],
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: new Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text('Register successful!'),
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

  //login success alert dialog
  showLSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Logged in'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
              (Route<dynamic> route) => false,
            );
          },
          child: Text('Ok'),
        ),
      ],
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: new Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 40.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              'Welcome back!',
              style: TextStyle(fontSize: 17.0),
            ),
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

  //login failed dialog
  showLFailed(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Oops!'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Ok'),
        ),
      ],
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      content: new Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 40.0,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0),
            child: Text(
              'Failed to login.',
              style: TextStyle(fontSize: 17.0),
            ),
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

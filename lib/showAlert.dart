import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/dashboard.dart';
import 'package:swms_user_auth_module/profile.dart';

class ShowAlert {
  //processing dialog
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

  //register success dialog
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

  //login success dialog
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

  //show update password success dialog
  showUpdateSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Success!'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/profile', (Route<dynamic> route) => false);
          },
          child: Text('Back to profile'),
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
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Password has been\nsuccessfully updated!'),
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

  showGenericFailed(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Oops!'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Retry'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );
          },
          child: Text('Back to profile'),
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
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Something went wrong!\nTry again later!'),
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

  //show remove success
  showRemoveSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Remove successful'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/profile', (Route<dynamic> route) => false);
          },
          child: Text('Back to profile'),
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
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Account removed\nsuccessfully!'),
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

  //show update success
  showUpdateNameSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Update successful'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/profile', (Route<dynamic> route) => false);
          },
          child: Text('Back to profile'),
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
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Account name\nhas been updated!'),
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

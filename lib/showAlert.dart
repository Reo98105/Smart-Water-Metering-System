import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/dashboard.dart';
import 'package:swms_user_auth_module/dashboardAdmin.dart';
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
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboard', (Route<dynamic> route) => false);
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

  //login admin success dialog
  showLSuccessA(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Logged in'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/dashboardAdmin', (Route<dynamic> route) => false);
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
          onPressed: () async {
            //clear sharedpreferences before logging out
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            //check if sharedpreferences cleared
            String username = prefs.getString('username');
            print(username);
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          },
          child: Text('Confirm'),
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
            child: Text(
              'Password has been\n' +
                  'successfully updated!\n' +
                  'Note: For security reason,\n' +
                  'you will be logged out.',
              textAlign: TextAlign.justify,
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
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 3;
            });
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

  //show delete success
  showDeleteSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Remove successful'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            int count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 3;
            });
          },
          child: Text('Confirm'),
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
            Navigator.popAndPushNamed(context, '/profile');
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

  //account suspended message
  showSuspended(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Account suspended'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Back'),
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
            child: Text('Account has been suspended!\n' +
                'Please contact admin for more information.'),
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

  //show success add premise
  showAddSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Premise Added'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {},
          child: Text('Back'),
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
            child: Text('New premise account\nhas been added!'),
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

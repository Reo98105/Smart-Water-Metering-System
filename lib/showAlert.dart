import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        builder: (context) => alert);
  }

  //register success dialog
  showRSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName('/login'));
          },
          child: Text('confirm'),
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
            child: Text('Registeration successful!'),
          ),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => alert);
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
        builder: (context) => alert);
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
        builder: (context) => alert);
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
              'Account or password is\nincorrect',
              style: TextStyle(fontSize: 17.0),
            ),
          ),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => alert);
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
        builder: (context) => alert);
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
            child: Text('Something went wrong!\nTry again later!'),
          ),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => alert);
  }

  //show remove success
  showRemoveSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Remove successful'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/profile', ModalRoute.withName('/dashboard'));
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
        builder: (context) => alert);
  }

  //show delete success
  showDeleteSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Remove successful'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/premise', ModalRoute.withName('/dashboardAdmin'));
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
            child: Text('Premise removed\nsuccessfully!'),
          ),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => alert);
  }

  //show update nickname success
  showUpdateNameSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Update successful'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/profile', ModalRoute.withName('/dashboard'));
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
        builder: (context) => alert);
  }

  //show update premise success
  showUpdatePremiseSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Update successful'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/premise', ModalRoute.withName('/dashboardAdmin'));
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
            Icons.check_circle_outline,
            color: Colors.green,
            size: 40.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text('Premise details\nhas been updated!'),
          ),
        ],
      ),
    );
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => alert);
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
        builder: (context) => alert);
  }

  //show success add premise
  showAddSuccess(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Premise Added'),
      //actions of the dialog box
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/premise', ModalRoute.withName('/dashboardAdmin'));
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
        builder: (context) => alert);
  }
}

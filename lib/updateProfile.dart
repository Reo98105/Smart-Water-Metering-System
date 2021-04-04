import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/profile.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class UpdateProfile extends StatefulWidget {
  User user;
  UserDAO userDAO = new UserDAO();
  ShowAlert showAlert = new ShowAlert();

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String username = '';
  String oldpassword = '';

  final _formKey = GlobalKey<FormState>();

  TextEditingController oldpw;
  TextEditingController newpw;
  TextEditingController renewpw;

  //get username from sharepreferences
  String _getUsername() {
    getCre().then((value) => setState(() {
          username = value;
        }));
    return username;
  }

  //get current password from sharepreferences
  String _getOldPw() {
    getPassword().then((value) => setState(() {
          oldpassword = value;
        }));
    return oldpassword;
  }

  @override
  void initState() {
    if (widget.user == null) widget.user = new User.def();
    oldpw = TextEditingController();
    oldpw.text = widget.user.password;
    newpw = TextEditingController();
    newpw.text = widget.user.password1;
    renewpw = TextEditingController();
    renewpw.text = widget.user.password2;
    super.initState();
  }

  @override
  void dispose() {
    oldpw.dispose();
    newpw.dispose();
    renewpw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Password"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: oldpw,
                autofocus: true,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Old Password',
                  suffixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: newpw,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'New Password',
                  suffixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: renewpw,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Confirm new password',
                  suffixIcon: Icon(Icons.lock),
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _handleUpdate(context);
                      },
                      icon: Icon(Icons.update),
                      label: Text('Update'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        elevation: 5.0,
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      icon: Icon(Icons.cancel),
                      label: Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        elevation: 5.0,
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //get credential
  Future<String> getCre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    return username;
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('pw');
    return password;
  }

  //handle update request
  Future<void> _handleUpdate(BuildContext context) async {
    String oldpass = oldpw.text;
    if (_formKey.currentState.validate() && (oldpass == _getOldPw())) {
      String newpass = newpw.text;
      widget.showAlert.showAlertDialog(context); //show loading pop up
      try {
        widget.user = new User.login(_getUsername(), newpass);
        int result = await widget.userDAO.updatePass(widget.user);
        print(result);
        if (result == 1) {
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close the dialog
          AlertDialog alert = AlertDialog(
            title: Text('Success!'),
            //actions of the dialog box
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProfile(),
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
        } else {
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close the dialog
          //alert dialog design..?
          AlertDialog alert = AlertDialog(
            title: Text('Oops!'),
            //actions of the dialog box
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Retry'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProfile(),
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
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
      }
    } else
      //debug purpose
      print("something wrong");
  }
}

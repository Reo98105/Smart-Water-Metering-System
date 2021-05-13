import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/profile.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class UpdateProfile extends StatefulWidget {
  User user;
  UserDAO userDAO = new UserDAO();

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int id;
  String oldpassword = '';

  ShowAlert showAlert = new ShowAlert();

  final _formKey = GlobalKey<FormState>();

  TextEditingController oldpw;
  TextEditingController newpw;
  TextEditingController renewpw;

  //get username from sharepreferences
  int _getId() {
    getId().then((value) => setState(() {
          id = value;
        }));
    return id;
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
    super.initState();
    getPassword();
    _getOldPw();
    getId();
    _getId();
    if (widget.user == null) widget.user = new User.def();
    oldpw = TextEditingController();
    oldpw.text = widget.user.password;
    newpw = TextEditingController();
    newpw.text = widget.user.password1;
    renewpw = TextEditingController();
    renewpw.text = widget.user.password2;
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
  Future<int> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('pw');
    return password;
  }

  void saveCre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('pw', newpw.text);
  }

  //handle update request
  Future<void> _handleUpdate(BuildContext context) async {
    String oldpass = oldpw.text;
    if (_formKey.currentState.validate() && (oldpass == _getOldPw())) {
      String newpass = newpw.text;
      showAlert.showLoadingDialog(context); //show loading pop up
      try {
        widget.user = new User.up(_getId(), newpass);
        int result = await widget.userDAO.updatePass(widget.user);
        print(result);
        if (result == 1) {
          //update credential
          saveCre();
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close the dialog
          showAlert.showUpdateSuccess(context);
        } else {
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close the dialog
          showAlert.showGenericFailed(context);
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

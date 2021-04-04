import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/registerDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/registration.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class Login extends StatefulWidget {
  //instantiate things
  User user;
  RegisDAO regisDAO = new RegisDAO();
  ShowAlert showAlert = new ShowAlert();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  //listener for textfields
  TextEditingController nameControl = TextEditingController();
  TextEditingController pwControl = TextEditingController();

  @override
  void initState() {
    if (widget.user == null) widget.user = new User.def();
    nameControl = TextEditingController();
    nameControl.text = widget.user.username;
    pwControl = TextEditingController();
    pwControl.text = widget.user.password;
    super.initState();
  }

  @override
  void dispose() {
    //clean up controller when widget is removed
    nameControl.dispose();
    pwControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Image.asset(
                'assets/swmsword.png',
                scale: 1.2,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: nameControl,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Username';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: pwControl,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Password',
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
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _handleLogin(context);
                      },
                      icon: Icon(Icons.login),
                      label: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        elevation: 5.0,
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        );
                      },
                      icon: Icon(Icons.app_registration),
                      label: Text('Register'),
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

  //save credentials
  void saveCre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', widget.user.username);
    prefs.setString('pw', widget.user.password);
  }

  //handle login event
  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      widget.showAlert.showAlertDialog(context);
      String username = nameControl.text;
      String password = pwControl.text;
      try {
        widget.user = new User.login(username, password);
        String result =
            await widget.regisDAO.validateLogin(User.login(username, password));
        if (result == password) {
          saveCre(); //save the credentials
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close loading dialog
          return widget.showAlert.showLSuccess(context);
        }
        //close loading dialog
        Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
        print(result);
        //guard clause
        return widget.showAlert.showLFailed(context);
        /*else {
          print('something wrong');
          widget.showAlert.showLFailed(context);
        }*/
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
      }
    }
  }
}

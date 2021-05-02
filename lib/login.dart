import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';
import 'package:swms_user_auth_module/DAO/regislogDAO.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/registration.dart';
import 'package:swms_user_auth_module/showAlert.dart';

import 'Model/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //instantiate things
  Account account;
  User user;
  RegislogDAO regislogDAO = new RegislogDAO();
  AccountDAO accountDAO = new AccountDAO();
  ShowAlert showAlert = new ShowAlert();

  final _formKey = GlobalKey<FormState>();

  //listener for textfields
  TextEditingController nameControl = TextEditingController();
  TextEditingController pwControl = TextEditingController();

  @override
  void initState() {
    if (user == null) user = new User.def();
    if (account == null) account = new Account.def();
    nameControl = TextEditingController();
    nameControl.text = user.username;
    pwControl = TextEditingController();
    pwControl.text = user.password;
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
    prefs.setInt('id', user.id);
    prefs.setString('username', user.username);
    prefs.setString('pw', user.password);
    prefs.setStringList('accNumList', account.accList);
  }

  //handle login event
  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      //show loading dialog
      showAlert.showLoadingDialog(context);
      String username = nameControl.text;
      String password = pwControl.text;
      try {
        String result = await regislogDAO.validateLogin(User.cre(username));
        if (result == password) {
          //get user's unique id
          try {
            int result = await regislogDAO.getID(User.cre(username));
            user.id = result;
            user.username = username;
            user.password = password;

            List result2 = await accountDAO.getAccNum(result);
            account.accList = result2;

            //save the credentials
            saveCre();
          } catch (e, stacktrace) {
            print(e);
            print(stacktrace);
          }
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close loading dialog
          return showAlert.showLSuccess(context);
        }
        //close loading dialog
        Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
        print(result);
        //guard clause
        return showAlert.showLFailed(context);
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
      }
    }
  }
}

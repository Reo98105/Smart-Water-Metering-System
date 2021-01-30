import 'package:flutter/material.dart';
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
    if(widget.user == null) widget.user = new User.def();
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
              child: Image.asset('assets/swmsword.png'),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
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
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
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
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
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

  //handle login event
  Future<void> _handleLogin(BuildContext context) async {
    widget.showAlert.showAlertDialog(context);
    String username = nameControl.text;
    String password = pwControl.text;
    if (_formKey.currentState.validate()) {
      try{
        widget.user = new User.login (username, password);
        bool result = await widget.regisDAO.validateLogin(User.login(username, password));
        print(result);
        if(result = true){
           Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close the dialog
              widget.showAlert.showLSuccess(context);
        }
      }catch (e, stacktrace){
        print(e);
        print(stacktrace);
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swms_user_auth_module/login.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Register'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  bool isCheck = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
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
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                decoration: InputDecoration(
                  labelText: 'NRIC',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter NRIC';
                  }
                  return null;
                },
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                    child: ElevatedButton.icon(
                      onPressed: isCheck
                          ? () {
                              if (_formKey.currentState.validate())
                                debugPrint(
                                    'Posting to server for registration...');
                            }
                          : null,
                      icon: Icon(Icons.app_registration),
                      label: Text('Register'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        elevation: 5.0,
                        textStyle: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 15.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
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
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 100.0, 5.0, 5.0),
              child: CheckboxListTile(
                value: isCheck,
                onChanged: (bool value) {
                  setState(
                    () {
                      isCheck = value;
                    },
                  );
                },
                title: Text(
                  'By clicking Register, you agree to our Terms and that you have read our Data Use Policy, including our Cookie Use.',
                  style: TextStyle(fontSize: 12.0),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.lightBlueAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

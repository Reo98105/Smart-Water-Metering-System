import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/profile.dart';

class AddAcc extends StatefulWidget {
  @override
  _AddAccState createState() => _AddAccState();
}

class _AddAccState extends State<AddAcc> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController accNo;
  TextEditingController nick;
  TextEditingController pw;
  TextEditingController repw;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Account'),
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
                controller: accNo,
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter account number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Account Number',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: nick,
                autofocus: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a nickname for the account';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Account Nickname',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: TextFormField(
                controller: pw,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your password';
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
                controller: repw,
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Confirm password',
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
                        //_handleAdd(context);
                      },
                      icon: Icon(Icons.update),
                      label: Text('Add'),
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
}

import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0 , vertical: 15.0),
            child: Image.asset('assets/logo1.png'),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.subject),
              label: Text('Submit'),
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan[400],
                elevation: 5.0,
                textStyle: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

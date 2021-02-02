import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/registerDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/updateProfile.dart';

class Profile extends StatefulWidget {
  RegisDAO regisDAO = new RegisDAO();
  User user;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = '';

  String _getUsername() {
    getCre().then((value) => setState(() {
          username = value;
        }));
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfile(),
                  ),
                );
              },
              child: Icon(
                Icons.edit_rounded,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 0.0),
              alignment: FractionalOffset.center,
              child: Icon(
                Icons.face_sharp,
                size: 100.0,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              alignment: FractionalOffset.center,
              child: FutureBuilder(
                future: getCre(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              alignment: FractionalOffset.center,
              child: FutureBuilder(
                future: widget.regisDAO.getEmail(_getUsername()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data,
                      style: TextStyle(fontSize: 16.0),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30.0,
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

  getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String password = prefs.getString('password');
    return password;
  }
}

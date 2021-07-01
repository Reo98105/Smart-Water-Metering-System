import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/updatePassword.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  UserDAO userDAO = new UserDAO();

  User user;
  int id;
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getUserid();
    _getUserid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              //profile icon
              Container(
                  //move later
                  margin: EdgeInsets.fromLTRB(5.0, 0.0, 25.0, 0.0),
                  alignment: FractionalOffset.center,
                  child: Icon(
                    Icons.face_sharp,
                    size: 100.0,
                  )),
              Container(
                width: 200.0,
                child: FutureBuilder(
                  future: userDAO.getUserDetail(_getUserid()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        snapshot.hasData) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          user = snapshot.data[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child: Text(
                                'Username: ${user.username}',
                                style: TextStyle(fontSize: 17.0),
                              )),
                              Container(
                                  child: Text(
                                'Email: ${user.email}',
                                style: TextStyle(fontSize: 17.0),
                              )),
                              Container(
                                child: Text(
                                  'Status: ${user.status}',
                                  style: TextStyle(fontSize: 17.0),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      return Text('Loading..');
                    }
                  },
                ),
              )
            ]),
            Container(
                child: ElevatedButton(
              child: Text('update password'),
              style: ElevatedButton.styleFrom(
                primary: Colors.cyan[400],
                elevation: 5.0,
              ),
              onPressed: () {
                //route to update password page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdatePassword(),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  //get userid
  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }

  //get userid from sharepreferences
  int _getUserid() {
    getUserid().then((value) => setState(() {
          id = value;
        }));
    return id;
  }

  //get user details
  Future getUserDetail() async {
    User user;
    return user;
  }
}

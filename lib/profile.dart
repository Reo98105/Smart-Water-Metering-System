import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/updateProfile.dart';
import 'package:swms_user_auth_module/addAcc.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';

class Profile extends StatefulWidget {
  UserDAO userDAO = new UserDAO();
  //AccountDAO accountDAO = new AccountDAO();
  User user;
  Account account;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = '';
  int userid;
  AccountDAO accountDAO = new AccountDAO();

  //get username from sharepreferences
  String _getUsername() {
    getUsername().then((value) => setState(() {
          username = value;
        }));
    return username;
  }

  //get userid from sharepreferences
  int _getUserid() {
    getUserid().then((value) => setState(() {
          userid = value;
        }));
    return userid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfile(),
                  ),
                );
              },
              child: Icon(
                Icons.edit_rounded,
                size: 20.0,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            //profile icon
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 0.0),
              alignment: FractionalOffset.center,
              child: Icon(
                Icons.face_sharp,
                size: 100.0,
              ),
            ),
            //display username
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              alignment: FractionalOffset.center,
              child: FutureBuilder(
                future: getUsername(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    );
                  } else {
                    return Text('Loading..');
                  }
                },
              ),
            ),
            //display user email
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              alignment: FractionalOffset.center,
              child: FutureBuilder(
                future: widget.userDAO.getEmail(_getUsername()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data,
                      style: TextStyle(fontSize: 16.0),
                    );
                  } else {
                    return Text('Loading..');
                  }
                },
              ),
            ),
            //act as seperator
            Divider(
              color: Colors.grey[400],
              thickness: 2,
              height: 30.0,
            ),
            //display managed accounts
            Container(
              child: FutureBuilder(
                  future: getAccount(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none &&
                        snapshot.hasData == null) {
                      return CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, index) {
                            accountDAO = snapshot.data[index];
                            //item data here
                            return Container(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      index.toString(),
                                      style: TextStyle(fontSize: 22.0),
                                    ),
                                  ),
                                ));
                          });
                    }
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAcc(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
      ),
    );
  }

  //get username
  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    return username;
  }

  //get userid
  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }

  //get account list
  Future getAccount() async {
    List<Account> accList = await accountDAO.getAcc(_getUserid());
    return accList;
  }
}

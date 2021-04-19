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
  User user;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = '';
  int id;
  Account account;

  AccountDAO accountDAO = new AccountDAO();

  SharedPreferences preferences;
  Future<List> _accList;

  //get userid
  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }

  //get username
  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    return username;
  }

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
          id = value;
        }));
    return id;
  }

  Future<List> getAcc() async {
    List<Account> account = await accountDAO.getAcc(_getUserid());
    return account;
  }

  //invoke once only before building widget
  @override
  void initState() {
    super.initState();
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
              child: FutureBuilder<List>(
                  future: getAcc(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        snapshot.hasData) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            Account account = snapshot.data[index];
                            //item data here
                            return Container(
                                child: Card(
                              child: Column(children: <Widget>[
                                ListTile(
                                    leading: Icon(Icons.home),
                                    title: Text('${account.accNickname}'),
                                    subtitle: Text('${account.accNumber}'))
                              ]),
                            ));
                          });
                    }
                    if (snapshot.hasData == null) {
                      return Center(child: Text('No account has been added.'));
                    } else {
                      return Center(child: CircularProgressIndicator());
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
}

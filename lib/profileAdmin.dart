import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/deleteProfile.dart';
import 'package:swms_user_auth_module/showAlert.dart';
import 'package:swms_user_auth_module/updateProfile.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';

class ProfileAdmin extends StatefulWidget {
  @override
  _ProfileAdminState createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  AccountDAO accountDAO = new AccountDAO();
  UserDAO userDAO = new UserDAO();
  ShowAlert showAlert = new ShowAlert();
  User user;

  String username = '';
  String selectedAcc;
  int id;
  Account account, account2, acc;

  //option and value list
  List optionList = <String>['Update password', 'Delete account'];
  List optValueList = [UpdateProfile(), DeleteAccount()];

  final _formKey = GlobalKey<FormState>();

  TextEditingController newName;
  TextEditingController password;

  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getUserid();
    _getUserid();

    if (acc == null) account = new Account.def();
    newName = TextEditingController();
    newName.text = account.accNickname;
    password = TextEditingController();
    password.text = account.password;
  }

  @override
  void dispose() {
    super.dispose();
    newName.dispose();
    password.dispose();
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
                margin: EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 0.0),
                alignment: FractionalOffset.center,
                child: Icon(
                  Icons.face_sharp,
                  size: 100.0,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                      alignment: FractionalOffset.center,
                      child: FutureBuilder(
                          future: Future.wait([
                            getUsername(),
                            userDAO.getEmail(_getUsername()),
                            userDAO.getUserDetail(_getUserid())
                          ]),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                'Username: ${snapshot.data[0]}' +
                                    '\nEmail: ${snapshot.data[1]}',
                                style: TextStyle(fontSize: 18.0),
                              );
                            } else {
                              return Text('Loading..');
                            }
                          }))
                ],
              )
            ]),
            Container(
                child: ElevatedButton(
              child: Text('update password'),
              onPressed: () {},
            ))
          ],
        )));
  }

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

  //get user details
  Future getUserDetail() async {
    User user;
    return user;
  }
}

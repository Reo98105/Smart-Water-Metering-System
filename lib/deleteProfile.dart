import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  ShowAlert showAlert = new ShowAlert();
  UserDAO userDAO = new UserDAO();
  User user;

  String status;
  int userid;

  @override
  void initState() {
    super.initState();
    getUserid();
    _getUserid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Account"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Icon(
              Icons.error_outline_outlined,
              color: Colors.red,
              size: 100.0,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Proceed to delete the account?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              'Note: You will not be able to recover back the\naccount after this and will be log out from the app.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.0),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 40.0,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      accDeletion(context);
                    },
                    icon: Icon(Icons.check),
                    label: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      elevation: 5.0,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 40.0,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context, '/dashboard');
                    },
                    icon: Icon(Icons.keyboard_return_outlined),
                    label: Text('Back'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan[400],
                      elevation: 5.0,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //get userid from sharepreferences
  int _getUserid() {
    getUserid().then((value) => setState(() {
          userid = value;
        }));
    return userid;
  }

  //get userid
  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }

  //handle logout logic
  void accDeletion(BuildContext context) async {
    //set values to User
    status = 'suspended';
    userid = _getUserid();
    //update account status to 'suspended'
    int result = await userDAO.updateStatus(User.status(status, userid));
    //check if the status has been updated
    if (result == 1) {
      //clear sharedpreferences before logging out
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      //debug purpose
      String username = prefs.getString('username');
      print(username);
      if (username == null) {
        //show loading dialog
        showAlert.showLoadingDialog(context);
        //back to login screen
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      } else {
        //debug purpose
        print('something wrong');
      }
    } else {
      //debug purpose
      print('something wrong');
    }
  }
}

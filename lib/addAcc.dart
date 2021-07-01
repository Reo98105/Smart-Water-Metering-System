import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';
import 'package:swms_user_auth_module/profile.dart';
import 'package:swms_user_auth_module/showAlert.dart';
import 'package:swms_user_auth_module/Model/account.dart';

class AddAcc extends StatefulWidget {
  @override
  _AddAccState createState() => _AddAccState();
}

class _AddAccState extends State<AddAcc> {
  Account account;
  AccountDAO accDao = new AccountDAO();
  ShowAlert showAlert = new ShowAlert();

  String pass = '';
  int userid;

  final _formKey = GlobalKey<FormState>();

  TextEditingController accNo = TextEditingController();
  TextEditingController nick = TextEditingController();
  TextEditingController pw = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserid();
    _getUserid();
    getPass();
    _getPwd();
    if (account == null) account = new Account.def();
    accNo = TextEditingController();
    accNo.text = account.accNumber;
    nick = TextEditingController();
    nick.text = account.accNickname;
    pw = TextEditingController();
    pw.text = account.password;
  }

  @override
  void dispose() {
    //clean up controller when widget is removed
    accNo.dispose();
    nick.dispose();
    pw.dispose();
    super.dispose();
  }

  //get current password from sharepreferences
  String _getPwd() {
    getPass().then((value) => setState(() {
          pass = value;
        }));
    return pass;
  }

  //get current userid from sharepreferences
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
                    return 'required*';
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
                    return 'required*';
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
                    return 'required*';
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
                        _handleAddAcc(context);
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

  //get password
  Future<String> getPass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = prefs.getString('pw');
    return pass;
  }

  //get userid
  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }

  //handle add account
  Future<void> _handleAddAcc(BuildContext context) async {
    String acc = accNo.text;
    String accName = nick.text;
    String pwd = pw.text;
    //check if form empty and password are same
    if (_formKey.currentState.validate() && (pwd == _getPwd())) {
      try {
        //show loading dialog
        showAlert.showLoadingDialog(context);
        String result = await accDao.checkAccExist(acc);
        if (result == acc) {
          try {
            account = new Account.add(_getUserid(), acc, accName, pwd);
            int result = await accDao.addAcc(account);
            if (result == 1) {
              //close the dialog
              Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
              AlertDialog alert = AlertDialog(
                title: Text('Success!'),
                //actions of the dialog box
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.popUntil(context, (route) {
                        return count++ == 2;
                      });
                    },
                    child: Text('Back to profile'),
                  ),
                ],
                backgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                content: new Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 40.0,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text('New account has been\nadded!'),
                    ),
                  ],
                ),
              );
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            } else {
              //close the dialog
              Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
              showAlert.showGenericFailed(context);
            }
          } catch (e, stacktrace) {
            print(e);
            print(stacktrace);
          }
        } else {
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close the dialog
          showAlert.showGenericFailed(context);
        }
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
      }
    } else {
      showAlert.showGenericFailed(context);
    }
  }
}

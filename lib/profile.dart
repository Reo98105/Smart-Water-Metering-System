import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/user.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/showAlert.dart';
import 'package:swms_user_auth_module/updateProfile.dart';
import 'package:swms_user_auth_module/addAcc.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AccountDAO accountDAO = new AccountDAO();
  UserDAO userDAO = new UserDAO();
  ShowAlert showAlert = new ShowAlert();
  User user;

  String username = '';
  String selectedAcc;
  int id;
  Account account, account2, acc;

  final _formKey = GlobalKey<FormState>();

  TextEditingController newName;
  TextEditingController password;

  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getUserid();
    _getUserid();
    getAcc();

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
      body: SafeArea(
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
                future: userDAO.getEmail(_getUsername()),
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
                          account = snapshot.data[index];
                          //item data here
                          return Container(
                              child: Card(
                                  child: Column(children: <Widget>[
                            ListTile(
                                leading: Icon(Icons.home),
                                title: Text('${account.accNickname}'),
                                subtitle: Text('${account.accNumber}'),
                                onTap: () {
                                  setState(() {
                                    account2 = snapshot.data[index];
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                //update dialog
                                                showUpdateDialog(context,
                                                    account2.accNumber);
                                              },
                                              child: Text('Update'),
                                            ),
                                            TextButton(
                                              child: Text(
                                                'Remove',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                              onPressed: () {
                                                //Remove confirmation dialog
                                                showRemoveDialog(context);
                                              },
                                            )
                                          ],
                                          content:
                                              _accDetail(account2.accNumber),
                                        );
                                      });
                                })
                          ])));
                        },
                      );
                    } else if (snapshot.hasData == null) {
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

  //show account's detail, update or delete
  _accDetail(var accNumber) {
    return Container(
      width: 200.0,
      height: 125.0,
      child: FutureBuilder(
        future: getAccDetail(accNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.hasData) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        Account accDetail = snapshot.data[index];
                        //item data here
                        return Container(
                            child: ListTile(
                          leading: Icon(
                            Icons.home,
                            size: 45.0,
                          ),
                          title: Text(
                            '${accDetail.accNickname}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          subtitle: Text(
                              '${accDetail.accNumber}\n\n${accDetail.address}, ${accDetail.postCode}, ${accDetail.district}, ${accDetail.city}'),
                        ));
                      })
                ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  //show remove dialog
  showRemoveDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remove confirmation'),
          content: Text('Are you sure to remove this account from your list?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  //trigger deletion function
                  _handleDelete(account2.accNumber);
                },
                child: Text('Confirm')),
            TextButton(
                onPressed: () {
                  //pop dialog
                  Navigator.of(context).pop(true);
                },
                child: Text('Cancel'))
          ],
        );
      },
    );
  }

  //show update dialog
  showUpdateDialog(BuildContext context, String accNum) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update account nickname'),
          content: Container(
              height: 125.0,
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: TextFormField(
                            controller: newName,
                            autofocus: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter new nickname';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'New account nickname',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                          child: TextFormField(
                            controller: password,
                            autofocus: true,
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
                      ]))),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  //trigger update function
                  _handleUpdate(context, accNum);
                },
                child: Text('Confirm')),
            TextButton(
                onPressed: () {
                  //pop dialog
                  Navigator.of(context).pop(true);
                },
                child: Text('Cancel'))
          ],
        );
      },
    );
  }

  //handle update
  Future _handleUpdate(BuildContext context, String accNum) async {
    //check form if there is empty
    if (_formKey.currentState.validate()) {
      showAlert.showLoadingDialog(context);
      String newNickname = newName.text;
      String pass = password.text;
      String userid = _getUserid().toString();
      String accNumber = accNum;

      try {
        //show loading dialog
        showAlert.showLoadingDialog(context);
        account = new Account.update(userid, newNickname, pass, accNumber);
        int result = await accountDAO.updateAcc(account);
        if (result == 1) {
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close loading dialog
          showAlert.showUpdateNameSuccess(context);
        } else {
          Navigator.of(_formKey.currentContext, rootNavigator: true)
              .pop(); //close loading dialog
          showAlert.showGenericFailed(context);
        }
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
      }
    }
    return;
  }

  //handle deletion
  Future _handleDelete(var accNumber) async {
    try {
      showAlert.showLoadingDialog(context);
      int result = await accountDAO.removeAcc(accNumber);
      if (result == 1) {
        //pop dialog
        Navigator.of(context).pop(true);
        showAlert.showRemoveSuccess(context);
      } else {
        //pop dialog
        Navigator.of(context).pop(true);
        showAlert.showGenericFailed(context);
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
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

  Future<List> getAcc() async {
    List account = await accountDAO.getAcc(_getUserid());
    return account;
  }

  //get acc details
  Future getAccDetail(var accNumber) async {
    List accountDetail = await accountDAO.getAccDetail(accNumber);
    return accountDetail;
  }
}

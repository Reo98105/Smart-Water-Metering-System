import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/addPremise.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class Premise extends StatefulWidget {
  @override
  _PremiseState createState() => _PremiseState();
}

class _PremiseState extends State<Premise> {
  AccountDAO accountDAO = new AccountDAO();
  ShowAlert showAlert = new ShowAlert();

  Account account, account2;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Premise"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
          child: Column(children: <Widget>[
        Divider(
          color: Colors.grey[600],
          thickness: 2,
          height: 0.0,
        ),
        Container(
            child: FutureBuilder(
                future: getAllAcc(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done ||
                      snapshot.hasData) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          account = snapshot.data[index];
                          //list data here
                          return Container(
                            child: Card(
                                child: Column(children: <Widget>[
                              ListTile(
                                  leading: Icon(Icons.place),
                                  title: Text('${account.accNumber}'),
                                  subtitle: Text('${account.district}'),
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
                                                  /*showUpdateDialog(context,
                                                    account2.accNumber);*/
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
                            ])),
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }))
      ])),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPremise(),
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

  //show account's detail
  _accDetail(var accNumber) {
    return Container(
      width: 200.0,
      height: 110.0,
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
                          leading: Container(
                            padding: EdgeInsets.only(top: 28.0),
                            child: Icon(
                              Icons.place,
                              size: 40.0,
                            ),
                          ),
                          title: Text(
                            '$accNumber',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                          subtitle: Text('\n${accDetail.address}, ' +
                              '${accDetail.postCode}, ' +
                              '${accDetail.district}, ' +
                              '${accDetail.city}'),
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

  //show update dialog
  showUpdateDialog(BuildContext context) {
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
                  //_handleUpdate(context, accNum);
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

  //show delete dialog
  showRemoveDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Remove confirmation'),
          content: Text('Remove this account?'),
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

  //handle update

  //handle deletion
  Future _handleDelete(var accNumber) async {
    try {
      showAlert.showLoadingDialog(context);
      int result = await accountDAO.deleteAcc(accNumber);
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

  //get all available account
  Future getAllAcc() async {
    List acc = await accountDAO.getAllAcc();
    return acc;
  }

  //get acc details
  Future getAccDetail(var accNumber) async {
    List accountDetail = await accountDAO.getAccountDetail(accNumber);
    return accountDetail;
  }
}

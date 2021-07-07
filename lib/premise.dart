import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';
import 'package:swms_user_auth_module/Model/account.dart';
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

  TextEditingController address, postCode, district, city;

  @override
  void initState() {
    super.initState();
    if (account == null) account = new Account();
    address = TextEditingController();
    address.text = account.address;
    postCode = TextEditingController();
    account.postCode = int.tryParse(postCode.text);
    district = TextEditingController();
    district.text = account.district;
    city = TextEditingController();
    city.text = account.city;
  }

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
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
        ])),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              Navigator.pushNamed(context, '/addPremise');
            },
            child: Icon(
              Icons.add,
              size: 30.0,
            )));
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0),
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
            }));
  }

  //show update dialog
  showUpdateDialog(BuildContext context, String accNum) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update premise detail'),
          content: Container(
              height: 300.0,
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                          child: TextFormField(
                            controller: address,
                            decoration: InputDecoration(
                              labelText: 'Address',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'required*';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                          child: TextFormField(
                            controller: postCode,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: 'Postcode',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'required*';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
                          child: TextFormField(
                            controller: district,
                            decoration: InputDecoration(
                              labelText: 'District',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'required*';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                          child: TextFormField(
                            controller: city,
                            decoration: InputDecoration(
                              labelText: 'City',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'required*';
                              }
                              return null;
                            },
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
        });
  }

  //handle update event
  Future _handleUpdate(BuildContext context, String accNum) async {
    //check form if there is empty
    if (_formKey.currentState.validate()) {
      showAlert.showLoadingDialog(context);
      String accountAddress = address.text;
      int accountPostCode = int.tryParse(postCode.text);
      String accountDistrict = district.text;
      String accountCity = city.text;

      try {
        showAlert.showLoadingDialog(context);
        account = new Account.updatePremise(accountAddress, accountPostCode,
            accountDistrict, accountCity, accNum);
        int result = await accountDAO.updatePremise(account);
        if (result == 1) {
          Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
          showAlert.showUpdatePremiseSuccess(context);
        } else {
          Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
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
      int result = await accountDAO.deleteAcc(accNumber);
      if (result == 1) {
        //pop dialog
        Navigator.of(context).pop(true);
        showAlert.showDeleteSuccess(context);
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

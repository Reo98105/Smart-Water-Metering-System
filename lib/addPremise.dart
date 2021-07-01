import 'package:flutter/material.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/premise.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class AddPremise extends StatefulWidget {
  @override
  _AddPremiseState createState() => _AddPremiseState();
}

class _AddPremiseState extends State<AddPremise> {
  Account account = new Account();
  AccountDAO accountDAO = new AccountDAO();
  ShowAlert showAlert = new ShowAlert();

  final _formKey = GlobalKey<FormState>();

  TextEditingController accNumber, address, postCode, district, city;

  @override
  void initState() {
    super.initState();
    if (account == null) account = new Account();
    accNumber = TextEditingController();
    accNumber.text = account.accNumber;
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
        title: Text("Add Premise"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
              child: TextFormField(
                controller: accNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Premise Account Number',
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
                controller: address,
                decoration: InputDecoration(
                  labelText: 'Premise Address',
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
                  labelText: 'Premise Postcode',
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
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _handleAdd(context);
                    },
                    icon: Icon(Icons.add),
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
                            builder: (context) => Premise(),
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
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }

  //handle add request
  Future _handleAdd(BuildContext context) async {
    String accountNumber = accNumber.text;
    String accountAddress = address.text;
    int accountPostcode = int.tryParse(postCode.text);
    String accountDistrict = district.text;
    String accountCity = city.text;

    showAlert.showLoadingDialog(context); //show loading pop up

    try {
      account = new Account.addPremise(accountNumber, accountAddress,
          accountPostcode, accountDistrict, accountCity);
      int result = await accountDAO.addAccount(account);
      //debug purpose
      print(result);
      if (result == 1) {
        //close loading dialog
        Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
        showAlert.showUpdateSuccess(context);
      } else {
        //close the dialog
        Navigator.of(_formKey.currentContext, rootNavigator: true).pop();
        showAlert.showGenericFailed(context);
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
  }
}

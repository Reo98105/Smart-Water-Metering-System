import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Account account = new Account();
  AccountDAO accountDAO = new AccountDAO();

  int userid;
  Account acc, acc2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              vertical: 25.0,
              horizontal: 20.0,
            ),
            color: Colors.grey.shade300,
            child: Text(
              'Choose an account',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
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
                            acc = snapshot.data[index];
                            //item data here
                            return Container(
                                child: Card(
                                    child: Column(children: <Widget>[
                              ListTile(
                                  leading: Icon(Icons.home),
                                  title: Text('${acc.accNickname}'),
                                  subtitle: Text('${acc.accNumber}'),
                                  onTap: () {
                                    /*setState(() {
                                      acc2 = snapshot.data[index];
                                    });*/
                                  }),
                            ])));
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }))
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

  Future<List> getAcc() async {
    List account = await accountDAO.getAcc(_getUserid());
    return account;
  }
}

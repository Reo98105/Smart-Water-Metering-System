import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';
import 'package:swms_user_auth_module/Model/account.dart';

class WaterReading extends StatefulWidget {
  @override
  _WaterReadingState createState() => _WaterReadingState();
}

class _WaterReadingState extends State<WaterReading> {
  int id;

  AccountDAO accountDAO = new AccountDAO();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Reading"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 40.0),
              child: Text(
                'account name here..',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              child: LiquidCustomProgressIndicator(
                value: 0.7,
                valueColor: AlwaysStoppedAnimation(Colors.blue),
                backgroundColor: Colors.lightBlue[200],
                direction: Axis.vertical,
                shapePath: _buildCirclePath(),
                //display reading of the account here
                /*center: FutureBuilder(
                      future: ,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          );
                        } else {
                          return Text('Loading...');
                        }
                      },
                    ),*/
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                alignment: Alignment.center,
                child: Text(
                  'Last update timestamp here...',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
              child: ElevatedButton.icon(
                //show listtile
                onPressed: () {},
                icon: Icon(Icons.home),
                label: Text('Managed Accounts'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[400],
                  elevation: 5.0,
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //show a list of managed accounts
  Widget showList() {
    return Container(
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
                        /*ListTile(
                                    leading: Icon(Icons.home),
                                    title: Text('${account.accNickname}'),
                                    subtitle: Text('${account.accNumber}'))*/
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
    );
  }

  //get userid
  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
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
}

//painting a circle using path
Path _buildCirclePath() {
  return Path()
    ..moveTo(100, 200)
    ..addOval(Rect.fromCircle(center: Offset(200, 150), radius: 100))
    ..close();
}

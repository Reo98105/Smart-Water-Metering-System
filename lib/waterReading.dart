import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/accountDAO.dart';
import 'package:swms_user_auth_module/DAO/readingDAO.dart';
import 'package:swms_user_auth_module/Model/account.dart';

class WaterReading extends StatefulWidget {
  @override
  _WaterReadingState createState() => _WaterReadingState();
}

class _WaterReadingState extends State<WaterReading> {
  int id;
  Account account;
  var selectedAccount;

  AccountDAO accountDAO = new AccountDAO();
  ReadingDAO readingDAO = new ReadingDAO();

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    //call the future list*
    getUserid();
    _getUserid();
    getAcc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Reading"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: RefreshIndicator(
          onRefresh: _refresh,
          key: _refreshIndicatorKey,
          child: ListView(
            children: <Widget>[
              SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 40.0),
                      child: FutureBuilder(
                        future: getAccName(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '${snapshot.data}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.justify,
                            );
                          } else {
                            return Text(
                              'N/A',
                              style: TextStyle(fontSize: 18.0),
                            );
                          }
                        },
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
                        center: FutureBuilder<double>(
                          future: getUsage(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data.toString()} \nLitres',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0,
                                ),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Text('N/A');
                            }
                          },
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        alignment: Alignment.center,
                        child: FutureBuilder(
                          future: getTimeStamp(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                'Last updated: ${snapshot.data.toString()}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.justify,
                              );
                            }
                            if (snapshot.hasData == null) {
                              return Text(
                                'N/A',
                                style: TextStyle(fontSize: 18.0),
                              );
                            } else {
                              return Container();
                            }
                          },
                        )),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 30.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            //pop dialog
                                            Navigator.of(context).pop(true);
                                            //call function do something to update UI
                                            setState(() {
                                              getFutures();
                                            });
                                          },
                                          child: Text('Confirm'),
                                        ),
                                      ],
                                      title: Text('Managed Accounts'),
                                      content: showList());
                                });
                              });
                        },
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
              )
            ],
          )),
    );
  }

  //show a list of managed accounts
  showList() {
    return Container(
      height: 400.0,
      width: 300.0,
      child: FutureBuilder<List>(
        future: getAcc(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.hasData) {
            return StatefulBuilder(
                builder: (BuildContext context, _setState) => ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Account account = snapshot.data[index];
                      //item data here
                      return Card(
                        child: Column(children: <Widget>[
                          Container(
                              child: RadioListTile(
                            value: account.accNumber,
                            groupValue: selectedAccount,
                            title: Text('${account.accNickname}'),
                            subtitle: Text('${account.accNumber}'),
                            onChanged: (account) {
                              _setState(() => selectedAccount = account);
                            },
                            selected: selectedAccount == account,
                            activeColor: Colors.blueAccent,
                          ))
                        ]),
                      );
                    }));
          }
          if (snapshot.hasData == null) {
            return Center(child: Text('No account has been added.'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
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

  //return accounts list
  Future<List> getAcc() async {
    List account = await accountDAO.getAcc(_getUserid());
    return account;
  }

  //return usage reading
  Future<double> getUsage() async {
    double readings = await readingDAO.getReading(selectedAccount);
    return readings;
  }

  //return timeStamp
  Future getTimeStamp() async {
    DateTime timeStamp = await readingDAO.getTimeStamp(selectedAccount);
    if (timeStamp != null) {
      String formatted = DateFormat('EEE, d MMM - kk:mm:ss').format(timeStamp);
      return formatted;
    }
  }

  //return account's nickname
  Future<String> getAccName() async {
    String accNickname = await accountDAO.getAccName(selectedAccount);
    return accNickname;
  }

  getFutures() async {
    getUsage();
    getTimeStamp();
    getAccName();
  }

  Future _refresh() async {
    setState(() {
      getFutures();
    });
  }
}

//painting a circle using path
Path _buildCirclePath() {
  return Path()
    ..moveTo(100, 200)
    ..addOval(Rect.fromCircle(center: Offset(195, 130), radius: 100))
    ..close();
}

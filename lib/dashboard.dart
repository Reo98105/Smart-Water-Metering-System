import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: FutureBuilder(
                      future: getCre(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          );
                        } else {
                          return Text('');
                        }
                      },
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.topRight,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 25.0),
                    child: Icon(
                      Icons.face_sharp,
                      size: 100.0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                  );
                },
                icon: Icon(Icons.person),
                label: Text('Profile'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[400],
                  elevation: 5.0,
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.bar_chart),
                label: Text('Water Reading'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[400],
                  elevation: 5.0,
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.access_time),
                label: Text('History'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[400],
                  elevation: 5.0,
                  textStyle: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.monetization_on),
                label: Text('Bills'),
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

  getCre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    return username;
  }
}

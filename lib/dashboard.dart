import 'package:flutter/material.dart';

import 'profile.dart';

class Dashboard extends StatelessWidget {
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
                    child: Text(
                      'Hello, Helena!',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                    alignment: FractionalOffset.topRight,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 25.0),
                    child: Icon(
                      Icons.face_unlock_rounded,
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
}

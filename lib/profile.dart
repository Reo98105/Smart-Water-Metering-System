import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(5.0, 50.0, 5.0, 0.0),
              alignment: FractionalOffset.center,
              child: Icon(
                Icons.face_sharp,
                size: 100.0,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              alignment: FractionalOffset.center,
              child: Text(
                'Name here..',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              alignment: FractionalOffset.center,
              child: Text(
                'email here..',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              alignment: FractionalOffset.center,
              child: Text(
                'phone number here..',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          Container(
              child: Opacity(
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/testbg1.png'),
              fit: BoxFit.cover,
            ))),
            opacity: 0.3,
          )),
          Center(
            child: Text(
              'Make your life more convenient by\nusing this app to monitor your\nwater meter remotely and\npay bill via the apps!',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 22.0),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
              alignment: Alignment.bottomCenter,
              child: Text(
                'Swipe left to continue',
                style: TextStyle(fontSize: 18.0),
              ))
        ]),
      ),
    );
  }
}

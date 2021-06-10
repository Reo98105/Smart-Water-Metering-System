import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  @override
  _PaymentSuccessState createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Payment Result"),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 100.0,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Payment has been accepted!\nPlease wait for it to be further process.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 40.0,
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/dashboard', (Route<dynamic> route) => false);
                },
                icon: Icon(Icons.keyboard_return_outlined),
                label: Text('Return to Dashboard'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.cyan[400],
                  elevation: 5.0,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class PaymentFailed extends StatefulWidget {
  @override
  _PaymentFailedState createState() => _PaymentFailedState();
}

class _PaymentFailedState extends State<PaymentFailed> {
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
                Icons.error_outline,
                color: Colors.red,
                size: 100.0,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'Something went wrong when processing transaction.\nPlease retry again after 5 minutes.',
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

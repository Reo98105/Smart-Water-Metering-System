import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swms_user_auth_module/DAO/userDAO.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/Model/payment.dart';
import 'package:swms_user_auth_module/Services/stripeService.dart';
import 'package:swms_user_auth_module/showAlert.dart';

class PaymentDetail extends StatefulWidget {
  Account account;
  PaymentDetail(this.account);

  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  UserDAO userDAO = new UserDAO();
  Payment payment = new Payment();
  ShowAlert showAlert = new ShowAlert();

  int id;
  double price;
  String status, test, amount;

  @override
  void initState() {
    super.initState();
    getUserid();
    _getUserid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Payment Detail"),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            color: Colors.grey.shade300,
            child: Text(
              'Account detail',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
              child: FutureBuilder(
                  future: getPaymentDetail(widget.account.accNumber),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done ||
                        snapshot.hasData) {
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            payment = snapshot.data[index];
                            price = payment.price;
                            payment.userid = id;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 5.0),
                                    child: Text(
                                      'Bill ID: ${payment.billid}',
                                      style: TextStyle(fontSize: 17.0),
                                    )),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 5.0),
                                    child: Text(
                                      'Account Number: ${payment.accNumber}',
                                      style: TextStyle(fontSize: 17.0),
                                    )),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 5.0),
                                    child: Text(
                                      'Amount: RM ${payment.price}',
                                      style: TextStyle(fontSize: 17.0),
                                    )),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 5.0),
                                    child: Text(
                                      'Status: ${payment.status}',
                                      style: TextStyle(fontSize: 17.0),
                                    )),
                              ],
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
          Divider(
            color: Colors.grey[400],
            thickness: 2,
            height: 0.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                color: Colors.grey.shade300,
                child: Text(
                  'Payment',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                  child: RadioListTile(
                value: 'cimb',
                groupValue: test,
                title: Text(
                  'Pay now',
                  style: TextStyle(color: Colors.black),
                ),
                onChanged: (value) {
                  setState(() => test = value);
                  //create payment method
                  StripeService.createPaymentMethod(test);
                },
                activeColor: Colors.blue.shade400,
              )),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: ElevatedButton(
                      child: Text('Confirm'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan[400],
                        elevation: 5.0,
                      ),
                      onPressed: () async {
                        //show loading dialog
                        showAlert.showLoadingDialog(context);
                        //convert and create intent
                        amount = (price * 100).toStringAsFixed(0);
                        //confirm payment intent
                        await StripeService.onPaymentMethodResult(amount);
                        if (StripeService.paymentStatus == 'succeeded') {
                          //set status to paid
                          status = 'Paid';
                          payment.status = status;
                          //update database
                          updatePayment(payment);
                          //pop dialog
                          Navigator.of(context).pop(true);
                          //go to success page
                          Navigator.pushNamed(context, '/paySuccess');
                        } else {
                          //pop dialog
                          Navigator.of(context).pop(true);
                          //navigate to failed page
                          Navigator.pushNamed(context, '/payFailed');
                        }
                      }))
            ],
          )
        ]));
  }

  //get userid from sharepreferences
  int _getUserid() {
    getUserid().then((value) => setState(() {
          id = value;
        }));
    return id;
  }

  //get payment details
  Future getPaymentDetail(var accNumber) async {
    List paymentDetail = await userDAO.paymentDetail(accNumber);
    return paymentDetail;
  }

  //get userid from sharedPreferences
  Future<int> getUserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userid = prefs.getInt('id');
    return userid;
  }

  Future updatePayment(Payment payment) async {
    int status = await userDAO.updatePayment(payment);
    return status;
  }
}

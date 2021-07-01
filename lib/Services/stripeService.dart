import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_payments_stripe_sdk/flutter_payments_stripe_sdk.dart';

class StripeService {
  static String secret =
      'sk_test_51ICP4aEc7t5vYLosGSI1XZ4pLScDwyL3oEMXcMOE85BGBJWvBDad68dJePSzAju3T4fMqd4x8dLIEJbNZeILeBdr00Vtp4fgiE';
  static String apiBase = 'https://api.stripe.com/v1';
  static Uri paymentApiUrl =
      Uri.parse('${StripeService.apiBase}/payment_intents');
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static var stripe = Stripe(
      'pk_test_51ICP4aEc7t5vYLos0g0OsDGJg690uJyUWpSKPxz36KLJ2ZXEovYHWr2BUOqZ6lMbPQRmRrvy0wwWcU7R909qjnhU00F9HgexUv');
  static String clientSecret = '';
  static var testPaymentMethodId = '';
  static String paymentStatus = '';

  //create a payment intent
  static Future<Map<String, dynamic>> createPaymentIntent(String amount) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': 'myr',
        'payment_method_types[]': 'fpx'
      };
      var response = await http.post(
        StripeService.paymentApiUrl,
        body: body,
        headers: StripeService.headers,
      );
      var respond = jsonDecode(response.body);
      if (respond != null && respond['client_secret'] != null) {
        clientSecret = respond['client_secret'];
        print(clientSecret);
      } else {
        print("Something went wrong!");
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static createPaymentMethod(String bankRef) async {
    var res = await stripe.paymentMethods.create(PaymentMethodData(
        type: PaymentMethodType.fpx, fpx: FpxMethod(bank: bankRef)));
    if (res.runtimeType == StripeError) {
      print((res as StripeError).toJson());
    } else {
      var respond = (res as PaymentMethod).toJson();
      if (respond != null && respond['id'] != null) {
        testPaymentMethodId = respond['id'];
        print(testPaymentMethodId);
      } else {
        print('Something went wrong!');
      }
    }
  }

  //pay via FPX
  static Future onPaymentMethodResult(var amount) async {
    await createPaymentIntent(amount);
    var res = await stripe.paymentIntents?.confirmPaymentIntent(clientSecret,
        data: ConfirmPaymentIntentRequest(
          paymentMethod: testPaymentMethodId,
          returnUrl: 'swms://dashboard',
          useStripeSdk: false,
        ));
    if (res.runtimeType == StripeError) {
      print((res as StripeError).toJson());
    } else {
      var respond = (res as PaymentIntent).toJson();
      if (respond != null && respond['status'] == 'succeeded') {
        paymentStatus = respond['status'];
        return paymentStatus;
      }
    }
  }
}

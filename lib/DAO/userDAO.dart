import 'package:swms_user_auth_module/DBConnection/mysql.dart';
import 'package:swms_user_auth_module/Model/account.dart';
import 'package:swms_user_auth_module/Model/payment.dart';
import 'package:swms_user_auth_module/Model/user.dart';

class UserDAO {
  var conn = new Mysql();

  //get name from database
  Future<String> getEmail(String username) async {
    String email = '';
    String ps = 'select email from user where username = ?';
    var connect = await conn.getConnection();
    var results = await connect.query(ps, [username]);
    for (var row in results) {
      email = row[0];
    }
    connect.close();
    return email;
  }

  //update password
  Future<int> updatePass(User user) async {
    int status = 0;
    String ps = 'update user set uPassword = ? where user_ID = ?';
    var connect = await conn.getConnection();
    var results = await connect.query(ps, [user.password, user.id]);

    status = results.affectedRows;

    print(status);
    connect.close();
    return status;
  }

  //retrieve payment details
  Future paymentDetail(var accNumber) async {
    List<Payment> payList = [];

    String ps =
        'select * from bill where accNumber = ? and status = 0 order by bill_ID desc limit 1';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [accNumber]);

      for (var row in results) {
        Payment payment = new Payment();
        payment.accNumber = row['accNumber'];
        payment.billid = row['bill_ID'];
        payment.price = row['price'];
        payment.status = row['status'];

        payList.add(payment);
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return payList;
  }

  //retrieve payment amount
  Future paymentAmount(Account account) async {
    double price;

    String ps =
        'select price from bill where accNumber = ? and status = 0 order by bill_ID desc limit 1';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [account.accNumber]);

      for (var row in results) {
        price = row['price'];
      }

      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return price;
  }

  //update payment status
  Future updatePayment(Payment payment) async {
    int status = 0;

    String ps = 'update bill set user_ID = ?, status = ? where bill_ID = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect
          .query(ps, [payment.userid, payment.status, payment.billid]);

      status = results.affectedRows;

      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return status;
  }

  //update acc status
  Future updateStatus(User user) async {
    int status = 0;

    String ps = 'update user set status = ? where user_ID = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [user.status, user.id]);

      status = results.affectedRows;
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return status;
  }

  //retrieve user detail
  Future getUserDetail(var userid) async {
    List<User> userDetail = [];

    String ps = 'select username, email, status from user where user_ID = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [userid]);

      for (var row in results) {
        User user = new User.test();
        user.username = row['email'];

        userDetail.add(user);
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return userDetail;
  }
}

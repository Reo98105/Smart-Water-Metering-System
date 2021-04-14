import 'package:swms_user_auth_module/DBConnection/mysql.dart';
import 'package:swms_user_auth_module/Model/user.dart';

class RegislogDAO {
  var conn = new Mysql();

  //registration
  Future<int> registerUser(User user) async {
    int status = 0;
    String ps =
        'insert into user (username, NRIC, uPassword, email) values (?, ?, ?, ?)';
    try {
      var connect = await conn.getConnection();
      var results = await connect
          .query(ps, [user.username, user.nric, user.password, user.email]);
      status = results.affectedRows;
      connect.close();
    } catch (e) {
      print(e);
    }
    return status;
  }

  //validate login info
  Future<String> validateLogin(User user) async {
    var pw = '';
    String ps = 'select uPassword from user where username = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [user.username]);
      for (var row in results) {
        pw = row[0];
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return pw;
  }

  //get user unique id
  Future<int> getID(User user) async {
    var userID;
    String ps = 'select user_ID from user where username = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [user.username]);
      for (var row in results) {
        userID = row[0];
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return userID;
  }
}

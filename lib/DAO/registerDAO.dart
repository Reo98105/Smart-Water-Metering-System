import 'package:swms_user_auth_module/DBConnection/mysql.dart';
import 'package:swms_user_auth_module/Model/user.dart';

class RegisDAO {
  var conn = new Mysql();

  //get info and insert to db
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
}

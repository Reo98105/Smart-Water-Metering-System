import 'package:swms_user_auth_module/DBConnection/mysql.dart';
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
}

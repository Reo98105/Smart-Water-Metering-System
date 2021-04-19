import 'package:swms_user_auth_module/DBConnection/mysql.dart';
import 'package:swms_user_auth_module/Model/account.dart';

class AccountDAO {
  var conn = new Mysql();

  //add account into db
  Future<int> addAcc(Account acc) async {
    int status = 0;
    String ps =
        'insert into supervision (user_ID, accNumber, accNickname) values (?, ?, ?)';
    try {
      var connect = await conn.getConnection();
      var results =
          await connect.query(ps, [acc.userid, acc.accNumber, acc.accNickname]);
      status = results.affectedRows;
      connect.close();
    } catch (e) {
      print(e);
    }
    return status;
  }

  //get managed accounts lists
  Future<List> getAcc(int userid) async {
    //create a list
    List<Account> accounts = [];
    //get the whole list
    String ps =
        'select accNumber, accNickname from supervision where user_ID = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [userid]);
      Account account = new Account();
      if (results.length == 1) {
        for (var row in results) {
          account.accNumber = row[0];
          account.accNickname = row[1];
          accounts.add(account);
        }
      } else {
        for (var row in results) {
          account.accNumber = row['accNumber'];
          account.accNickname = row['accNickname'];
          accounts.add(account);
        }
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return accounts;
  }
}

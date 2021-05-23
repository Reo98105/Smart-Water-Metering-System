import 'package:swms_user_auth_module/DBConnection/mysql.dart';
import 'package:swms_user_auth_module/Model/account.dart';

class AccountDAO {
  var conn = new Mysql();

  //check against db if this acc number exist
  Future checkAccExist(String accNum) async {
    String accNumber;
    String ps = 'select accNumber from account where accNumber = ? LIMIT 1';

    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [accNum]);

      for (var row in results) {
        accNumber = row['accNumber'];
        connect.close();
      }
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return accNumber;
  }

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
    List accounts = [];
    //get the whole list
    String ps =
        'select accNumber, accNickname from supervision where user_ID = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [userid]);
      for (var row in results) {
        Account acc = new Account();
        acc.accNickname = row['accNickname'];
        acc.accNumber = row['accNumber'];

        accounts.add(acc);
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return accounts;
  }

  //get managed accounts lists
  Future<List<Account>> getAccList(int userid) async {
    //create a list
    List<Account> accounts = [];
    //get the whole list
    String ps =
        'select accNumber, accNickname from supervision where user_ID = ?';
    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [userid]);
      for (var row in results) {
        Account acc = new Account();
        acc.accNickname = row['accNickname'];
        acc.accNumber = row['accNumber'];

        accounts.add(acc);
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return accounts;
  }

  //get managed accounts' numbers
  Future<List> getAccNum(int userid) async {
    //create a list
    List<String> accounts = [];
    //get the whole list
    String ps = 'select accNumber from supervision where user_ID = ?';

    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [userid]);
      for (var row in results) {
        String accNumber = row['accNumber'];
        accounts.add(accNumber);
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return accounts;
  }

  //get account's nickname
  Future<String> getAccName(var accNumber) async {
    String accNickname;

    String ps = 'select accNickname from supervision where accNumber = ?';

    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [accNumber]);
      for (var row in results) {
        accNickname = row['accNickname'];
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return accNickname;
  }

  //get account's detail
  Future getAccDetail(var accNumber) async {
    List<Account> accDetail = [];

    String ps =
        'select account.address, account.postCode, account.district, account.city, supervision.accNumber, supervision.accNickname ' +
            'from account inner join supervision ' +
            'on account.accNumber = supervision.accNumber ' +
            'where account.accNumber = ?';

    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [accNumber]);
      for (var row in results) {
        Account account = new Account();
        account.address = row['address'];
        account.postCode = row['postCode'];
        account.district = row['district'];
        account.city = row['city'];
        account.accNumber = row['accNumber'];
        account.accNickname = row['accNickname'];

        accDetail.add(account);
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }

    return accDetail;
  }

  //remove from supervision
  Future removeAcc(var accNumber) async {
    int status = 0;

    String ps = 'delete from supervision where accNumber = ?';

    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [accNumber]);

      status = results.affectedRows;
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }

    return status;
  }

  //update account nickname
  Future updateAcc(Account account) async {
    int status = 0;

    String ps = 'update supervision set accNickname = ? where user_ID = ? and accNumber = ?';

    try {
      var connect = await conn.getConnection();
      var results =
          await connect.query(ps, [account.accNickname, account.userid, account.accNumber]);
      status = results.affectedRows;
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return status;
  }
}

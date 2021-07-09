import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = "10.0.2.2",
      user = "root",
      password = "admin",
      db = "swms";

  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings;
    try {
      settings = new ConnectionSettings(
          host: host, port: port, user: user, password: password, db: db);
    } catch (e) {
      print(e);
    }
    return await MySqlConnection.connect(settings);
  }
}

import 'package:swms_user_auth_module/DBConnection/mysql.dart';

class ReadingDAO{
  var conn = new Mysql();

  //get readings from database
  Future<double> getReading(int accNumber) async {
    double reading = 0;
    String ps = 'select waterUsage from waterreading where accNumber = ?';
    var connect = await conn.getConnection();
    var results = await connect.query(ps, [accNumber]);
    for (var row in results) {
      reading = row[0];
    }
    connect.close();
    return reading;
  }
}
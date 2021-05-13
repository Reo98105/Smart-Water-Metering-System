import 'package:swms_user_auth_module/DBConnection/mysql.dart';

class ReadingDAO {
  var conn = new Mysql();

  //get readings from database
  Future<double> getReading(var accNumber) async {
    double reading = 0;

    String ps =
        'select waterUsage from meterreading where accNumber = ?';
    var connect = await conn.getConnection();
    var results = await connect.query(ps, [accNumber]);

    try {
      for (var row in results) {
        reading = row['waterUsage'];
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return reading;
  }

  Future getTimeStamp(var accNumber) async{
    DateTime timeStamp;

    String ps = 'select timeStamp from meterreading where accNumber = ?';
    var connect = await conn.getConnection();
    var results = await connect.query(ps, [accNumber]);

    try {
      for (var row in results) {
        timeStamp = row['timeStamp'];
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return timeStamp;
  }
}
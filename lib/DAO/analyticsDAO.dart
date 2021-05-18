import 'package:swms_user_auth_module/DBConnection/mysql.dart';
import 'package:swms_user_auth_module/Model/analytics.dart';

class AnalyticsDAO {
  var conn = new Mysql();

  //get water usage
  Future getWaterUsage(var accNumber) async {
    List<Analytics> waterUsage = [];

    String ps = 'select waterUsage, date(dateTime) from history where accNumber = ?';

    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [accNumber]);

      for(var row in results){
        Analytics analytics = new Analytics();
        analytics.waterUsage = row['waterUsage'];
        analytics.dateTime = row['date(dateTime)'];

        waterUsage.add(analytics);
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return waterUsage;
  }

  //get pay amount
  Future getPayAmount(var accNumber) async{
    List<Analytics> price = [];

    String ps = 'select price, date(dateTime) from history where accNumber = ?';

    try {
      var connect = await conn.getConnection();
      var results = await connect.query(ps, [accNumber]);

      for(var row in results){
        Analytics analytics = new Analytics();
        analytics.price = row['price'];
        analytics.dateTime = row['date(dateTime)'];

        price.add(analytics);
      }
      connect.close();
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
    }
    return price;
  }
}
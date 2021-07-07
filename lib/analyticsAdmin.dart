import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swms_user_auth_module/DAO/analyticsDAO.dart';
import 'package:swms_user_auth_module/Model/analytics.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsAdmin extends StatefulWidget {
  @override
  _AnalyticsAdminState createState() => _AnalyticsAdminState();
}

class _AnalyticsAdminState extends State<AnalyticsAdmin> {
  AnalyticsDAO analyticsDAO = new AnalyticsDAO();

  Analytics analytics = new Analytics();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analytics"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(children: <Widget>[
          Container(
              height: 325.0,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 10, 12.5, 0),
              child: _renderChart()),
          Divider(
            color: Colors.grey[600],
            thickness: 2,
            height: 0.0,
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey[350]),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
              left: 10.0,
            ),
            child: Text(
              'Details',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
              child: ListTile(
            title: Text(
              'Date',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Text(
              'Total Usage (m\u{00b3})',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          Container(
            child: FutureBuilder(
              future: getTotalUsage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.hasData) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      analytics = snapshot.data[index];
                      String formatted =
                          DateFormat('yyyy-MM-dd').format(analytics.dateTime);
                      return ListTile(
                        title: Text('$formatted'),
                        trailing: Text(
                          '${analytics.waterUsage} m\u{00b3}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ]),
      ),
    );
  }

  //function to render charts
  _renderChart() {
    return FutureBuilder(
        future: getTotalUsage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done ||
              snapshot.hasData) {
            return SfCartesianChart(
              title: ChartTitle(text: 'Past Total Water Usage'),
              primaryYAxis:
                  NumericAxis(title: AxisTitle(text: 'Cubic Metre m\u{00b3}')),
              primaryXAxis: DateTimeAxis(
                title: AxisTitle(text: 'Months'),
                intervalType: DateTimeIntervalType.months,
                interval: 1,
              ),
              series: <ChartSeries>[
                //render line chart
                LineSeries<Analytics, DateTime>(
                  dataSource: snapshot.data,
                  xValueMapper: (analytics, _) => analytics.dateTime,
                  yValueMapper: (analytics, _) => analytics.waterUsage,
                  markerSettings: MarkerSettings(
                    isVisible: true,
                  ),
                )
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  //get water usage history
  Future<List> getTotalUsage() async {
    List totalUsage = await analyticsDAO.getTotalUsage();
    return totalUsage;
  }
}

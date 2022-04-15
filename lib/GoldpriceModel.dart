import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

class GoldpriceModel {
  Map<String, dynamic> latestPrice;
  List<double> csvData = [];
  List<double> csvData1 = [];
  List<int> serialNo = [];
  List<int> serialNo1 = [];
  int i = 0;
  List temp = [];
  List temp1 = [];
  final _path = "assets/gold_rate_history1.csv";
  final pureToStandard = 0.9258;
  final DateTime startDate = DateTime(2006, 1, 2);
  final DateTime lastDate = DateTime(2020, 10, 10);

  Future<List> getGoldPriceData() async {
    final myData = await rootBundle.loadString(_path);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    csvTable.forEach((element) {
      i++;

      temp.add(element[0]);

//      csvData.add(double.parse(element[1]));
      csvData.add(element[1].toDouble());

      //Y-axis
      serialNo.add(i); //X-axis
    });

    return [serialNo, csvData, temp];
    // the time stamp is in mm-dd-yyyy format
  }

  Future<List> getSilverPriceData() async {
    final myData = await rootBundle.loadString("assets/silver_price.csv");
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);

    csvTable.forEach((element) {
      i++;

      temp1.add(element[0]);

//      csvData.add(double.parse(element[1]));
      csvData1.add(double.parse(element[1].toString()));

      //Y-axis
      serialNo1.add(i); //X-axis
    });

    return [serialNo1, csvData1, temp1];
    // the time stamp is in mm-dd-yyyy format
  }

  Widget linearGraph(List<int> x, List<double> y, int n, double maxY,
      Color graphColor, Color spotsColor) {
    List<FlSpot> spots = [];
    for (int i = 0; i < n; i++) {
      spots.add(FlSpot(x[i].toDouble(), y[i]));
    }
    return LineChart(LineChartData(
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 13450,
        minY: 0,
        maxY: maxY,
        gridData: FlGridData(show: false, drawVerticalLine: true),
        titlesData: FlTitlesData(
            show: false, bottomTitles: SideTitles(showTitles: false)),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            spots: spots,
            colors: [spotsColor],
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
                show: true,
                colors: [graphColor, Colors.white],
                gradientColorStops: [0, 1],
                gradientFrom: Offset.fromDirection(-1),
                gradientTo: Offset.fromDirection(1.5)),
          ),
        ]));
  }

  double getRingPrice(double price, int weight) {
    final gst = 3;
    final makingCharges = 10;

    return (price + price * (gst / 100) + price * (makingCharges / 100)) *
        weight;
  }

  double getChainPrice(double price, int weight) {
    final gst = 3;
    final makingCharges = 10;

    return (price + price * (gst / 100) + price * (makingCharges / 100)) *
        weight;
  }

  double getCoinPrice(double price, int weight) {
    final gst = 3;
    final makingCharges = 2;

    return (price + price * (gst / 100) + price * (makingCharges / 100)) *
        weight;
  }

  double getEarringPrice(double price, int weight) {
    final gst = 3;
    final makingCharges = 10;

    return (price + price * (gst / 100) + price * (makingCharges / 100)) *
        weight;
  }

  String linearRegression(
      List<double> prices, List<int> serialNo, DateTime date) {
    //initialization
    final int length = prices.length;
    int index = date.difference(startDate).inDays;
    double sumX = 0, sumY = 0, sumX2 = 0, sumXY = 0;

    for (i = 0; i < length; i++) {
      sumY += prices[i];
      sumX += serialNo[i];
      sumXY += prices[i] * serialNo[i];
      sumX2 += serialNo[i] * serialNo[i];
    } // yoo

    double b = (length * sumXY - sumX * sumY) / (length * sumX2 - sumX * sumX);
    double a = (sumY - b * sumX) / length;

    // a is the y intercept b is slope
    return ((a + b * index) * 10).toStringAsPrecision(6);

    //alternative algorithm
  }

  void dataSorting(List prices) {
    List dates = [];
    prices.forEach((element) {
      dates.add(element.split("-"));
    });

    dates.forEach((element) {});
  }

  Future<Map<String, dynamic>> getLatestPrices() async {
    try {
      var response = await http.get(
        Uri.tryParse("https://www.goldapi.io/api/XAU/INR"),
        headers: {"x-access-token": "goldapi-5rj59ukm3bs7cl-io"},
      );

      String data = response.body;

      data = data.substring(1, data.length - 1); // get rid of curly braces
      var list = data.split(",");
      var temp = [];
      list.forEach((element) {
        temp.add(element.trim().split(":"));
      });
      Map<String, dynamic> map = {};
      temp.forEach((element) {
        element[0] = element[0].toString().substring(
            1,
            element[0].toString().length -
                1); // get rid of the extra double quotes
        map.addAll({element[0]: element[1]});
      });

      int priceOfGoldToday = (double.parse(map["price"]) / 28.35)
          .round(); //This is per gram price of gold today(on that day)

      return map;
//{"timestamp":1617261207,"metal":"XAU","currency":"INR","exchange":"IDC","symbol":"FX_IDC:XAUINR","prev_close_price":124922,"open_price":124961.6,"low_price":124961.6,"high_price":126061.8,"open_time":1617228000,"price":126025.6,"ch":1103.6,"chp":0.88,"ask":126035.6,"bid":126025.6}
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> getLatestPricesSilver() async {
    try {
      var response = await http.get(
        Uri.tryParse("https://www.goldapi.io/api/XAG/INR"),
        headers: {"x-access-token": "goldapi-5rj59ukm3bs7cl-io"},
      );

      String data = response.body;
      data = data.substring(1, data.length - 1); // get rid of curly braces
      var list = data.split(",");
      var temp = [];
      list.forEach((element) {
        temp.add(element.trim().split(":"));
      });
      Map<String, dynamic> map = {};
      temp.forEach((element) {
        element[0] = element[0].toString().substring(
            1,
            element[0].toString().length -
                1); // get rid of the extra double quotes
        map.addAll({element[0]: element[1]});
      });

      int priceOfGoldToday = (double.parse(map["price"]) / 28.35)
          .round(); //This is per gram price of gold today(on that day)

      return map;
//{"timestamp":1617261207,"metal":"XAU","currency":"INR","exchange":"IDC","symbol":"FX_IDC:XAUINR","prev_close_price":124922,"open_price":124961.6,"low_price":124961.6,"high_price":126061.8,"open_time":1617228000,"price":126025.6,"ch":1103.6,"chp":0.88,"ask":126035.6,"bid":126025.6}
    } catch (e) {
      print(e);
    }
  }
}

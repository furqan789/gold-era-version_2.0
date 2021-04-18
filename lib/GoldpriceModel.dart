import 'package:csv/csv.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
class GoldpriceModel {
  Map<String, dynamic> latestPrice;
  List<double> csvData = [];
  List<int> serialNo = [];
  int i = 0;
  List temp = [];
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

      csvData.add(element[1].toDouble()); //Y-axis
      serialNo.add(i); //X-axis
    });

    return [serialNo, csvData, temp];
    // the time stamp is in mm-dd-yyyy format
  }
  Widget linearGraph(List<int> x,List<double> y,int n){
    List<FlSpot> spots = [];
    for(int i = 0;i<n;i++){

      spots.add(FlSpot(x[i].toDouble(),y[i]));
    }
    return LineChart(

      LineChartData(
        minX: 0,
        maxX: 5000,
        minY: 0,
        maxY: 6000,
        titlesData: FlTitlesData(
          show: false
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            dotData: FlDotData(show: false),
            colors: [
              Colors.red,
              Color(0xFFC89149)
              
            ],



          ),

        ]

      )
    );
  }

  int errorCalculation(List<int> prices, int a, int b) {
    List<int> predicted = [];
    final length = prices.length;
    for (int i = 0, j = 1; i < length; i++) {
      predicted.add(b * j + a);
    }
  }

  int linearRegression(List<double> prices, List<int> serialNo, DateTime date) {
    //initialization
    final int length = prices.length;
    int index = date.difference(startDate).inDays;
    double sumX = 0, sumY = 0, sumX2 = 0, sumXY = 0;

    for (i = 0; i < length; i++) {
      sumY += prices[i];
      sumX += serialNo[i];
      sumXY += prices[i] * serialNo[i];
      sumX2 += serialNo[i] * serialNo[i];
    }

    double b = (length * sumXY - sumX * sumY) / (length * sumX2 - sumX * sumX);
    double a = (sumY - b * sumX) / length;
    print("a is" + a.toString());
    print("b is" + b.toString());
    // a is the y intercept b is x coordinate
    return (a + b * index).round();
    //alternative algorithm
  }

  void dataSorting(List prices) {
    List dates = [];
    prices.forEach((element) {
      dates.add(element.split("-"));
    });

    dates.forEach((element) {
      
    });
  }


  Future<void> getLatestPrices() async {
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

      int priceOf22kGold = (priceOfGoldToday * pureToStandard).round();

      print("Price of 24k today : " +
          priceOfGoldToday.toString() +
          "\n Price of 22k today:" +
          priceOf22kGold.round().toString());
//{"timestamp":1617261207,"metal":"XAU","currency":"INR","exchange":"IDC","symbol":"FX_IDC:XAUINR","prev_close_price":124922,"open_price":124961.6,"low_price":124961.6,"high_price":126061.8,"open_time":1617228000,"price":126025.6,"ch":1103.6,"chp":0.88,"ask":126035.6,"bid":126025.6}
    } catch (e) {
      print(e);
    }
  }
}

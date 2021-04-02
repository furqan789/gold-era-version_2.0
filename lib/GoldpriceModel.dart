import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
class GoldpriceModel{
Map<String,dynamic> latestPrice;
List<double> csvData = [];
List<int> serialNo  = [];
int i =0;
final _path = "assets/gold_rate_history1.csv";
final pureToStandard = 0.9258;
final DateTime startDate = DateTime(2006,1,2);
Future<List> getGoldPriceData() async{
  final myData = await rootBundle.loadString(_path);
  List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
//  print(csvTable);
 csvTable.forEach((element) {
   i++;

   csvData.add(element[1].toDouble()); //Y-axis
   serialNo.add(i); //X-axis
 });

return [serialNo,csvData];
  // the time stamp is in mm-dd-yyyy format
}
int linearRegression(List<double> prices,List<int> serialNo, DateTime date){
  //initialization
  final int length = prices.length;

  int index = date.difference(startDate).inDays;

  final int epochs = 3;
  final int lc = epochs*length; // for training phase
  double err, b0= 0.0,b1= 0.0;
  final double alpha = 0.01;

//  //training phase
//  for (int i = 0; i < lc; i ++) {
//    int idx = i % length; //for accessing index after every epoch
//    double p = b0 + b1 * prices[idx]; //calculating prediction
//    err = p - serialNo[idx]; // calculating error
//    b0 = b0 - alpha * err; // updating b0
//    b1 = b1 - alpha * err * prices[idx]; // updating b1
//    print(b0);
//    print(b1);
//  }
//  print(lc);
//  print("b0 is" + b0.toString() + "\nb1 is" + b1.toString());
//  // testing phase
//    return b0+b1*index;
double sumX = 0,sumY = 0,sumX2= 0,sumXY= 0;
for(i=0;i<length;i++){
  sumY += prices[i];
  sumX += serialNo[i];
  sumXY += prices[i]*serialNo[i];
  sumX2 += serialNo[i] *serialNo[i];


}

  double b = (length*sumXY-sumX*sumY)/(length*sumX2-sumX*sumX);
  double a = (sumY - b*sumX)/length;
  print(a + b * index);
  return (a + b * index).round();

}
Future<void> getLatestPrices() async{
  
  try{var response = await http.get(Uri.tryParse("https://www.goldapi.io/api/XAU/INR"),
    headers: {
      "x-access-token": "goldapi-5rj59ukm3bs7cl-io"
    },
  );


  String data = response.body;

  data = data.substring(1,data.length - 1); // get rid of curly braces
  var list = data.split(",");
  var temp =[];
  list.forEach((element) {
    temp.add(element.trim().split(":")) ;

  });
  Map<String,dynamic> map = {};
  temp.forEach((element) {
    element[0] = element[0].toString().substring(1,element[0].toString().length - 1); // get rid of the extra double quotes
    map.addAll({element[0]:element[1]});
  });


  int priceOfGoldToday = (double.parse(map["price"]) / 28.35).round() ; //This is per gram price of gold today(on that day)

int priceOf22kGold = (priceOfGoldToday * pureToStandard).round();

print("Price of 24k today : " + priceOfGoldToday.toString() + "\n Price of 22k today:" + priceOf22kGold.round().toString() );
//{"timestamp":1617261207,"metal":"XAU","currency":"INR","exchange":"IDC","symbol":"FX_IDC:XAUINR","prev_close_price":124922,"open_price":124961.6,"low_price":124961.6,"high_price":126061.8,"open_time":1617228000,"price":126025.6,"ch":1103.6,"chp":0.88,"ask":126035.6,"bid":126025.6}
  }
  catch(e){
    print(e);
  }

}
}

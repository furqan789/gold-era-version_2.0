import 'package:flutter/foundation.dart';
import 'package:gold_price_predictor/second.dart';

class GoldInfo extends ChangeNotifier{
Map<String,dynamic> latestNews;
List<dynamic> goldPriceData;
double estimatedPrice;
DateTime selectedDate;


void getEstimatedPrice(double kimat){
  estimatedPrice = kimat;
}

double setEstimatedPrice(){
  return estimatedPrice;
}

void getSelectedDate(DateTime tareekh){
  selectedDate = tareekh;
}

DateTime setSelectedDate(){
  return selectedDate ;
}
void getLatestData(Map<String, dynamic> taajaKhabar){
   latestNews = taajaKhabar;
 }

Map<String,dynamic> setLatestData(){
  return latestNews;
}

 void getGoldData(List<dynamic> data){
  goldPriceData = data;
 }

List<dynamic> setGoldData(){
  return goldPriceData ;
}

}
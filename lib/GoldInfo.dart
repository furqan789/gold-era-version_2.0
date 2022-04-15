import 'package:flutter/foundation.dart';
import 'package:gold_price_predictor/second.dart';
import 'package:flutter/material.dart';

class GoldInfo extends ChangeNotifier {
  Map<String, dynamic> latestNews;
  Map<String, dynamic> latestNewsSilver;
  List<dynamic> goldPriceData;
  double estimatedPrice;
  DateTime selectedDate;
  List<Map<String, dynamic>> shoppingCart;
  List<dynamic> silverPriceData;

  void getEstimatedPrice(double kimat) {
    estimatedPrice = kimat;
  }

  void getEstimatedPriceSilver(double kimat) {
    estimatedPrice = kimat;
  }

  double setEstimatedPrice() {
    return estimatedPrice;
  }

  double setEstimatedPriceSilver() {
    return estimatedPrice;
  }

  void getSelectedDate(DateTime tareekh) {
    selectedDate = tareekh;
  }

  DateTime setSelectedDate() {
    return selectedDate;
  }

  void getLatestData(Map<String, dynamic> taajaKhabar) {
    latestNews = taajaKhabar;
  }

  void getLatestDataSilver(Map<String, dynamic> taajaKhabar) {
    latestNewsSilver = taajaKhabar;
    print(latestNewsSilver);
    print(taajaKhabar);
  }

  Map<String, dynamic> setLatestData() {
    return latestNews;
  }

  Map<String, dynamic> setLatestDataSilver() {
    return latestNewsSilver;
  }

  void getGoldData(List<dynamic> data) {
    goldPriceData = data;
  }

  void getSilverData(List<dynamic> data) {
    silverPriceData = data;
  }

  List<dynamic> setGoldData() {
    return goldPriceData;
  }

  List<dynamic> setSilverData() {
    return silverPriceData;
  }

  void addItemInCart(Map<String, dynamic> item) {
    if (shoppingCart == null) {
      shoppingCart = [item];
    } else {
      shoppingCart.add(item);
    }
  }

  void proceedToCheckout() {
    //idhar main assume karrau in the Map of the ornament jo add horayy usme price karke ek field haii jisme price of the ornament stored hai
    double cost = 0.0;
    shoppingCart.forEach((element) {
      cost += element["Price"];
    });

    //gst adding logic

    cost += cost * 0.18;
  }
}

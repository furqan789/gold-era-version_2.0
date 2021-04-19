import 'package:flutter/material.dart';
import 'package:gold_price_predictor/signup.dart';
import 'MainPage.dart';
import 'first.dart';
import 'login.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home:Home(),
  ));
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'Main',
      routes: {
        'Main' : (context) => MainPage(),
        'Login' : (context) => LoginPage(),
        'Sign Up' : (context) => SignupPage(),
        'First'  : (context) => FirstPage()

      },
    );
  }
}






import 'package:flutter/material.dart';
import 'package:gold_price_predictor/Cart.dart';
import 'package:gold_price_predictor/GoldInfo.dart';
import 'package:gold_price_predictor/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'MainPage.dart';
import 'first.dart';
import 'login.dart';
import 'second.dart';
import 'third.dart';
import 'bottom.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => GoldInfo(),
    child: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'Main',
      routes: {
        'Main': (context) => MainPage(),
        'Login': (context) => LoginPage(),
        'Sign Up': (context) => SignupPage(),
        'First': (context) => FirstPage(),
        'Second': (context) => SecondPage(),
        'Third': (context) => ThirdPage(),
        'Bottom': (context) => Bottom(),
        'Cart': (context) => Cart()
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gold_price_predictor/Cart.dart';
import 'package:gold_price_predictor/first.dart';
import 'package:gold_price_predictor/second.dart';
import 'package:gold_price_predictor/third.dart';
import 'Cart.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int _currentIndex = 0;
  final tabs = <Widget>[
    FirstPage(),
    SecondPage(),
    Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
        child: BottomNavigationBar(

          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Color(0xff505050).withOpacity(0.7),
          backgroundColor: Color(0xffF8CF82),
          currentIndex: _currentIndex,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined,size: 26,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_sharp,size: 26),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined,size: 26),
              label: '',
            ),
          ],
          onTap: (index) {
            _currentIndex = index;
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

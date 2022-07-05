import 'package:flutter/material.dart';
import 'package:gold_price_predictor/Cart.dart';
import 'package:gold_price_predictor/first.dart';
import 'package:gold_price_predictor/second.dart';
import 'package:gold_price_predictor/third.dart';
import 'Cart.dart';
import 'GoldpriceModel.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';

class Bottom extends StatefulWidget {
  @override
  _BottomState createState() => _BottomState();
}

var goldLatest, goldDataSet, silverLatest, silverDataset;
bool isLoaded = false;

Future loadData() async {
  await GoldpriceModel().getLatestPrices().then((value) {
    goldLatest = value;
  }).then((value) async {
    await GoldpriceModel().getGoldPriceData().then((value) {
      goldDataSet = value;
    });
  }).then((value) async {
    await GoldpriceModel().getLatestPricesSilver().then((value) {
      silverLatest = value;
    });
  }).then((value) async {
    await GoldpriceModel().getSilverPriceData().then((value) {
      silverDataset = value;
    });
  });
}

class _BottomState extends State<Bottom> {
  bool isLoaded = false;

  int _currentIndex = 0;
  final tabs = <Widget>[
    FirstPage(),
    SecondPage(),
    Cart(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    loadData().then((value) => {
          setState(() {
            isLoaded = true;
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<GoldInfo>(context, listen: false).getLatestData(goldLatest);
    Provider.of<GoldInfo>(context, listen: false).getGoldData(goldDataSet);
    Provider.of<GoldInfo>(context, listen: false)
        .getLatestDataSilver(silverLatest);
    Provider.of<GoldInfo>(context, listen: false).getSilverData(silverDataset);

    return isLoaded
        ? Scaffold(
            body: tabs[_currentIndex],
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                    icon: Icon(
                      Icons.home_outlined,
                      size: 26,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.trending_up_sharp, size: 26),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined, size: 26),
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
          )
        : Scaffold(body: Center(child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.grey)),
            SizedBox(height:15),
            Text('Loading...',style: TextStyle(
              fontWeight: FontWeight.bold
            ),)
          ],
        )));
  }
}

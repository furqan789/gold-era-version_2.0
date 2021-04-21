import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'GoldpriceModel.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Map<String, dynamic> latest_prices;
  FirebaseAuth _firebaseAuth;
  List<dynamic> goldPriceData;
  DateTime today;
  final double conversion_factor = 28.35;

  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    setState(() {


      today = DateTime.now();
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    goldPriceData = Provider.of<GoldInfo>(context).setGoldData();
    latest_prices = Provider.of<GoldInfo>(context).setLatestData();

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color(0xffe7b875),
            Color(0xffe7b875),
          ])),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0)),
              child: Icon(
                Icons.close,
                size: 28,
                color: Colors.black,
              ),
              onPressed: () async {
                await _firebaseAuth.signOut().then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, "Main", (route) => false));
              },
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Latest News',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "PlayfairDisplay",
                                fontSize: 21,
                                color: Color(0xffac5317),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            Text(
                              'See all',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "PlayfairDisplay",
                                fontSize: 21,
                                color: Color(0xffac5317),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 13),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.white.withOpacity(0.20),
                                ],
                                stops: [
                                  0.0,
                                  1.0
                                ]),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.white,
                            )),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 15 / 100,
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                CarouselSlider(
                                  items: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'assets/login2.jpeg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://responsive.fxempire.com/v7/_fxempire_/2020/07/Gold-Bars-and-Dollar-2.jpg?func=cover&q70&width=400'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://bsmedia.business-standard.com/_media/bs/img/misc/2020-12/17/full/gold-gold-price-gold-rally-1608188394-15622620.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                'https://researchingreform.files.wordpress.com/2012/07/news12.jpg'),
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  ],
                                  options: CarouselOptions(
                                      height: 100,
                                      enlargeCenterPage: false,
                                      autoPlay: false,
                                      aspectRatio: 16 / 9,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enableInfiniteScroll: true,
                                      viewportFraction: 0.35,
                                      autoPlayAnimationDuration:
                                          Duration(microseconds: 1000)),
                                )
                              ],
                            )),
                      ),
                      SizedBox(height: 38),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.white.withOpacity(0.3),
                                  Colors.white.withOpacity(0.20),
                                ],
                                stops: [
                                  0.0,
                                  1.0
                                ]),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.white,
                            )),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 25, bottom: 30),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(35),
                                  gradient: LinearGradient(colors: [
                                    Colors.white.withOpacity(1),
                                    Colors.white.withOpacity(0.8),
                                    Colors.white.withOpacity(0.1),
                                  ]),
                                  border: Border.all(
                                    width: 1.5,
                                    color: Colors.white,
                                  ),
                                ),
                                width: double.infinity,
                                height: 130,
                                child: Column(children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Gold Price',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0xCD872309),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "PlayfairDisplay",
                                        ),
                                      ),
                                      SizedBox(width: 80),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Last Change',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xCD872309),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "PlayfairDisplay",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            today.day.toString() +
                                                " / " +
                                                today.month.toString() +
                                                " / " +
                                                today.year.toString() +
                                                " - " +
                                                today.hour.toString() +
                                                " : " +
                                                today.minute.toString(),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.0, vertical: 12),
                                    child: Container(
                                      height: 1.0,
                                      width: 240.0,
                                      color: Color(0xCD872309),
                                    ),
                                  ),
                                  double.parse(latest_prices["price"]) != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "\u{20B9}" +
                                                (double.parse(latest_prices[
                                                            "price"]) /
                                                        conversion_factor)
                                                    .toStringAsPrecision(6),
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xCD872309),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "PlayfairDisplay",
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              "Couldn't fetch recent data"),
                                        ),
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 30),
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: GoldpriceModel().linearGraph(
                                      goldPriceData[0],
                                      goldPriceData[1],
                                      goldPriceData[0].length),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(colors: [
                                      Colors.white.withOpacity(0.8),
                                      Colors.white.withOpacity(0.1),
                                    ]),
                                    border: Border.all(
                                      width: 1.8,
                                      color: Colors.white,
                                    )),
                                width: double.infinity,
                                height: 240,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

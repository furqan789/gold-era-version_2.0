import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gold_price_predictor/second.dart';
import 'BackendCode.dart';
import 'GoldInfo.dart';
import 'GoldpriceModel.dart';
import 'package:provider/provider.dart';
import 'BackendCode.dart';
import 'GoldInfo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui';
import 'package:gold_price_predictor/categories.dart';
import 'RingPredict.dart';
import 'dart:io';
import 'Scategories.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';

import "package:http/http.dart" as http;
import 'package:carousel_slider/carousel_slider.dart';

import 'GoldpriceModel.dart';
import 'GoldpriceModel.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  Map<String, dynamic> latest_prices;
  Map<String, dynamic> latest_prices_Silver;
  GoldpriceModel _model;
  FirebaseAuth _firebaseAuth;
  List<dynamic> goldPriceData;
  DateTime today;
  List<File> images;
  String dropdownvalue = 'Gold';
  String dropdownvalueCategory = 'Ring';
  final adminEmail = "atharvtmnh823@gmail.com";
  final double conversion_factor = 28.35;
  final url =
      "https://economictimes.indiatimes.com/commoditysummary/symbol-gold.cms";

  Future get_Image(String productName) async {
    var _image;
    final image = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(image.path);
    if (_image != null) {
      images == null ? images = [_image] : images.add(_image);
      await FirebaseFunctions()
          .addImages(images, context, productName)
          .then((value) => print("Success!"));
    }
  }

  Future launchURLInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
      );
    }
  }

  @override
  void initState() {
    _firebaseAuth = FirebaseAuth.instance;
    _model = GoldpriceModel();

    setState(() {
      today = DateTime.now();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> productDetails = {
      "Name": "default",
      "Weight": 0,
      "Making Charge": 0
    };
    String designation = FirebaseAuth.instance.currentUser.email == adminEmail
        ? "admin"
        : "user";
    goldPriceData = Provider.of<GoldInfo>(context).setGoldData();
    latest_prices = Provider.of<GoldInfo>(context).setLatestData();
    latest_prices_Silver = Provider.of<GoldInfo>(context).setLatestDataSilver();
    final _formKey = GlobalKey<FormState>();

    var items = [
      DropdownMenuItem(
        child: Text('Gold'),
        value: "Gold",
        onTap: () {
          dropdownvalue = "Gold";
        },
      ),
      DropdownMenuItem(
        child: Text('Silver'),
        value: "Silver",
        onTap: () {
          dropdownvalue = "Silver";
        },
      ),
    ];
    //**************************************
    var categoriesList = [
      DropdownMenuItem(
        child: Text('Ring'),
        value: "Ring",
        onTap: () {
          dropdownvalueCategory = "Ring";
        },
      ),
      DropdownMenuItem(
        child: Text('Necklace'),
        value: "Necklace",
        onTap: () {
          dropdownvalueCategory = "Necklace";
        },
      ),
    ];

    bool formsubmission() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        return true;
      } else {
        return false;
      }
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 30, top: 30),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffC4C4C4),
                  ),
                ),
                Text(
                  'Hello, Naithik',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff505050)),
                ),
                Spacer(),
//                ElevatedButton(
//                  child: Text("Silver price prediction"),
//                  onPressed: () async {
//                    var silverPrice =
//                        await GoldpriceModel().getSilverPriceData();
//                    print(GoldpriceModel().linearRegression(
//                        silverPrice[1], silverPrice[0], DateTime.now()));
//                    Provider.of<GoldInfo>(context, listen: false)
//                        .getSilverData(silverPrice);
//                  },
//                ),
                //jdh
                designation.toLowerCase() == "admin"
                    ? ElevatedButton(
                        child: Icon(
                          Icons.add,
                          size: 25,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            primary: Color(0xff505050),
                            shadowColor: Color(0xff505050)),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(top: 5),
                                  height:
                                      MediaQuery.of(context).size.height / 1.5,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 2,
                                                width: 65,
                                                color: Colors.black,
                                                margin:
                                                    EdgeInsets.only(bottom: 30),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Color(
                                                              0xff505050)),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                              ElevatedButton(
                                                child: Text("Pick Images"),
                                                onPressed: () async {
                                                  await get_Image("Destiny");
                                                },
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0),
                                                child: TextFormField(
                                                  onSaved: (value) {
                                                    print(value);
                                                    productDetails["Name"] =
                                                        value;
                                                  },
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return "Please don't leave this field empty";
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: const InputDecoration(
                                                      fillColor:
                                                          Color(0xffDCDCDC),
                                                      filled: true,
                                                      hintText:
                                                          'Name Of The Product',
                                                      border: InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      errorBorder:
                                                          InputBorder.none,
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Color(0xff767676),
                                                          fontSize: 17)),
                                                ),
                                              ),
                                              TextFormField(
                                                onSaved: (value) {
                                                  print(value);
                                                  productDetails["Weight"] =
                                                      value;
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return "Please don't leave this field empty";
                                                  }
                                                  return null;
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: const InputDecoration(
                                                    fillColor:
                                                        Color(0xffDCDCDC),
                                                    filled: true,
                                                    hintText:
                                                        'Weight Of The Metal',
                                                    border: InputBorder.none,
                                                    focusedBorder:
                                                        InputBorder.none,
                                                    enabledBorder:
                                                        InputBorder.none,
                                                    errorBorder:
                                                        InputBorder.none,
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xff767676),
                                                        fontSize: 17)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0),
                                                child: TextFormField(
                                                  onSaved: (value) {
                                                    print(value);
                                                    productDetails[
                                                            "Making Charge"] =
                                                        value;
                                                  },
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return "Please don't leave this field empty";
                                                    }
                                                    return null;
                                                  },
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration:
                                                      const InputDecoration(
                                                          fillColor: Color(
                                                              0xffDCDCDC),
                                                          filled: true,
                                                          hintText:
                                                              'Making Charge',
                                                          border:
                                                              InputBorder.none,
                                                          focusedBorder:
                                                              InputBorder.none,
                                                          enabledBorder:
                                                              InputBorder.none,
                                                          errorBorder:
                                                              InputBorder.none,
                                                          hintStyle: TextStyle(
                                                              color: Color(
                                                                  0xff767676),
                                                              fontSize: 17)),
                                                ),
                                              ),
                                              DropdownButton(
                                                  value: dropdownvalue,
                                                  items: items,
                                                  hint: Text("Select metal"),
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      setState(
                                                        () {
                                                          print(value);
                                                          setState(() {
                                                            dropdownvalue =
                                                                value;
                                                          });
                                                        },
                                                      );
                                                    }
                                                  }),
                                              DropdownButton(
                                                  value: dropdownvalueCategory,
                                                  items: categoriesList,
                                                  hint: Text("Select metal"),
                                                  onChanged: (value) {
                                                    if (value != null) {
                                                      setState(
                                                        () {
                                                          print(value);
                                                          setState(() {
                                                            dropdownvalueCategory =
                                                                value;
                                                          });
                                                        },
                                                      );
                                                    }
                                                  })
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Center(
                                          child: GestureDetector(
                                            onTap: () async {
                                              if (formsubmission()) {
                                                await FirebaseFunctions()
                                                    .addOrnament(productDetails,
                                                        context);
                                                print(productDetails);
                                              }
                                            },
                                            child: Container(
                                              height: 66,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width, //set your height here
                                              //set your width here
                                              decoration: BoxDecoration(
                                                  color: Color(0xffF5BA4C),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              child: Center(
                                                  child: Text(
                                                'Confirm',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 21.5,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : Icon(Icons.add_alert),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.39,
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 0, right: 0),
                  decoration: BoxDecoration(
                    color: Color(0xffF5BA4C).withOpacity(0.6),
                    border: Border.all(color: Color(0xffDF9100), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/gold_bar.png',
                              scale: 35, color: Color(0xffDF9100)),
                          Text(
                            'Gold',
                            style: TextStyle(
                                color: Color(0xffDF9100),
                                fontSize: 21,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                        child: Text('Live buy price',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      double.parse(latest_prices["price"]) != null
                          ? Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                  "\u{20b9}" +
                                      (double.parse(latest_prices["price"]) /
                                              conversion_factor)
                                          .toStringAsPrecision(6),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            )
                          : Text('uu'),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Text('Purity',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      Text(
                        '24 Karat',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFFFFFF),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.39,
                  padding:
                      EdgeInsets.only(top: 20, bottom: 20, left: 0, right: 0),
                  decoration: BoxDecoration(
                    color: Color(0xff261C1C).withOpacity(0.3),
                    border: Border.all(color: Color(0xff848484), width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/gold_bar.png',
                            scale: 35,
                            color: Color(0xff848484),
                          ),
                          Text(
                            'Silver',
                            style: TextStyle(
                                color: Color(0xff848484),
                                fontSize: 21,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                        child: Text('Live buy price',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      latest_prices_Silver != null
                          ? Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                "\u{20b9}" +
                                    (double.parse(
                                                latest_prices_Silver["price"]) /
                                            conversion_factor)
                                        .toStringAsPrecision(6),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : Text('uu'),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                        child: Text('Purity',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      Text(
                        '925',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffFFFFFF),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 26, right: 26),
            child: Row(
              children: [
                Text(
                  'Brand Collection',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff505050),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: Color(0xff505050).withOpacity(0.7),
                          fontSize: 14),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 180,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff3A3A3A).withOpacity(0.2),
                      offset: const Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius: 5.0,
                      spreadRadius: 1.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Color(0xff0C0C0C).withOpacity(0.28),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: AssetImage('assets/images/brands.png'),
                    fit: BoxFit.contain,
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 5),
                child: Column(
                  children: [
                    Text(
                      'PROPOSAL RINGS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6),
                    ),
                    Text(
                      'LUXURY JEWELERY',
                      style: TextStyle(
                          letterSpacing: 5,
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 14.2),
                    ),
                    Spacer(),
                    Text(
                      'GOLD ERA COLLECTION',
                      style: TextStyle(
                          color: Color(0xffC5A879),
                          letterSpacing: 1.5,
                          fontSize: 10),
                    ),
                    Text(
                      '25th March - Release Date',
                      style: TextStyle(
                          letterSpacing: 1,
                          color: Color(0xff505050),
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 26, right: 26),
            child: Row(
              children: [
                Text(
                  'Gold Categories',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff505050),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Categories()));
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: Color(0xff505050).withOpacity(0.7),
                          fontSize: 14),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 140,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.35,
              ),
              items: [
                //1st Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/ringgs.png',
                        height: 65,
                      ),
                      Text(
                        'Rings',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),

                //2nd Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/coin.png',
                        height: 70,
                      ),
                      Text(
                        'Coins',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),

                //3rd Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/earings.png',
                        height: 70,
                      ),
                      Text(
                        'Earrings',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),

                //4th Image of Slider

                //5th Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/biscuitss.png',
                        height: 70,
                      ),
                      Text(
                        'Buiscuits',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 26, right: 26),
            child: Row(
              children: [
                Text(
                  'Silver Categories',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff505050),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Scategories()));
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: Color(0xff505050).withOpacity(0.7),
                          fontSize: 14),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 140,
                autoPlay: false,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.35,
              ),
              items: [
                //1st Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/silver_ring.png',
                        height: 75,
                      ),
                      Text(
                        'Rings',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),

                //2nd Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/coin.png',
                        height: 70,
                      ),
                      Text(
                        'Coins',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),

                //3rd Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/earings.png',
                        height: 70,
                      ),
                      Text(
                        'Earrings',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),

                //4th Image of Slider

                //5th Image of Slider
                Container(
                  width: 115,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Color(0xffEBEBEB),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/silver_pendants.png',
                        height: 75,
                      ),
                      Text(
                        'Pendants',
                        style: TextStyle(
                            color: Color(0xff3A3A3A),
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

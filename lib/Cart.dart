import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import 'GoldInfo.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double total = 0;
  double gst = 1.8 / 100;

  openwhatsapp() async {
    var whatsapp = "+918451976510";
    String text = "hello";
    var whatsappURl_android =
        "whatsapp://send?phone=" + whatsapp + "&text= $text";
    var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunch(whatappURL_ios)) {
        await launch(whatappURL_ios, forceSafariVC: false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: new Text("whatsapp no installed")));
      }
    } else {
      // android , web
      if (await canLaunch(whatsappURl_android)) {
        await launch(whatsappURl_android);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cart =
        Provider.of<GoldInfo>(context).shoppingCart;
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Shopping Cart',
            style: TextStyle(
                color: Color(0xff505050),
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          elevation: 0,
          centerTitle: true,
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
                Container(
                  height: 1.5,
                  color: Color(0xff505050).withOpacity(0.3),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        width: 110,
                        height: 105,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffEBEBEB),
                        ),
                        child: Positioned(
                          child: Image.asset('assets/images/ringgs.png',
                              scale: 3.0),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Rings',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff505050)),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Gold',
                              style: TextStyle(
                                  color: Color(0xfff3a922), letterSpacing: 1),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' | 7 gram',
                                    style: TextStyle(
                                      color: Color(0xff505050),
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        '₹ 5439.0',
                        style: TextStyle(color: Color(0xff505050)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 1.5,
                  color: Color(0xff505050).withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 215, //set your height here
              width: double.maxFinite, //set your width here
              decoration: BoxDecoration(
                  color: Color(0xff505050),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20.0))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Sub Total',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                          ),
                        ),
                        Text(
                          '₹ 5718',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white.withOpacity(0.75),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 18.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'GST (1.8%)',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white.withOpacity(0.75),
                                    ),
                          ),
                        ),
                        Text(
                          '₹ 75',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white.withOpacity(0.75),
                              ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      height: 1.5,
                      color: Color(0xFFFFFFFF).withOpacity(0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 18.0, bottom: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      color: Colors.white,
                                    ),
                          ),
                        ),
                        Text(
                          '₹ 5793',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await openwhatsapp();
                    },
                    child: Container(
                      height: 53, //set your height here
                      width: double.maxFinite, //set your width here
                      decoration: BoxDecoration(
                          color: Color(0xffF5BA4C),
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Center(
                          child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

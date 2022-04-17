import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'RingPredict.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';

class Rings extends StatefulWidget {
  @override
  _RingsState createState() => _RingsState();
}

class _RingsState extends State<Rings> {
  @override
  Widget build(BuildContext context) {
    var rings;
    rings = Provider.of<GoldInfo>(context).ring;
    print(rings);
    var priceData = Provider.of<GoldInfo>(context).setLatestData();
    num price = double.parse(priceData["price"].toString()) / 28.35;
    print(price);
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Rings',
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
                ElevatedButton(
                    onPressed: () {
                      Provider.of<GoldInfo>(context, listen: false)
                          .shoppingCart
                          .clear();
                    },
                    child: Text('Clear Cart')),
                Container(
                  height: 1.5,
                  color: Color(0xff505050).withOpacity(0.3),
                ),
                Container(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...rings.map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 0.3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffC9C9C9),
                                  offset: const Offset(
                                    3.0,
                                    3.0,
                                  ),
                                  blurRadius: 7.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Image.asset(
                                    'assets/images/ringgs.png',
                                    scale: 2.25,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      e["Name"],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 18),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      (price * double.parse(e["Weight"]) +
                                              double.parse(e["Making Charge"]) *
                                                  double.parse(e["Weight"]))
                                          .toStringAsPrecision(8),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Provider.of<GoldInfo>(context,
                                            listen: false)
                                        .addItemInCart(e);
                                    print(Provider.of<GoldInfo>(context,
                                            listen: false)
                                        .shoppingCart);
                                  },
                                  child: Container(
                                    height: 40, //set your height here
                                    //set your width here
                                    decoration: BoxDecoration(
                                        color: Color(0xffF5BA4C),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Center(
                                        child: Text(
                                      'Add to cart',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
//                      ,Container(
//                        width: MediaQuery.of(context).size.width * 0.4,
//                        decoration: BoxDecoration(
//                          border: Border.all(color: Colors.black12, width: 0.3),
//                          borderRadius: BorderRadius.all(Radius.circular(8)),
//                          boxShadow: [
//                            BoxShadow(
//                              color: Color(0xffC9C9C9),
//                              offset: const Offset(
//                                3.0,
//                                3.0,
//                              ),
//                              blurRadius: 7.0,
//                              spreadRadius: 1.0,
//                            ), //BoxShadow
//                            BoxShadow(
//                              color: Colors.white,
//                              offset: const Offset(0.0, 0.0),
//                              blurRadius: 0.0,
//                              spreadRadius: 0.0,
//                            ), //BoxShadow
//                          ],
//                        ),
//                        child: Column(
//                          children: [
//                            Padding(
//                              padding: const EdgeInsets.all(25.0),
//                              child: Image.asset(
//                                'assets/images/ringgs.png',
//                                scale: 2.25,
//                              ),
//                            ),
//                            Padding(
//                              padding:
//                                  const EdgeInsets.only(left: 15, bottom: 8),
//                              child: Align(
//                                alignment: Alignment.centerLeft,
//                                child: Text(
//                                  'Destiny Meets Ring',
//                                  style: TextStyle(fontWeight: FontWeight.w500),
//                                ),
//                              ),
//                            ),
//                            Padding(
//                              padding:
//                                  const EdgeInsets.only(left: 15, bottom: 18),
//                              child: Align(
//                                alignment: Alignment.centerLeft,
//                                child: Text(
//                                  '₹ 54406.98',
//                                  style: TextStyle(fontWeight: FontWeight.w500),
//                                ),
//                              ),
//                            ),
//                            InkWell(
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => RingPredict()));
//                              },
//                              child: Container(
//                                height: 40, //set your height here
//                                //set your width here
//                                decoration: BoxDecoration(
//                                    color: Color(0xffF5BA4C),
//                                    borderRadius:
//                                        BorderRadius.all(Radius.circular(8))),
//                                child: Center(
//                                    child: Text(
//                                  'Add to cart',
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      color: Colors.white, fontSize: 20),
//                                )),
//                              ),
//                            ),
//                          ],
//                        ),
//                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_gold/Rings.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';
import 'Rings.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  FirebaseFirestore _firebaseFirestore;
  List<dynamic> rings;

  List<dynamic> sortCategory(List<dynamic> ps) {
    print(ps.length);
    ps.forEach((element) {
      if (element["Category"].toString().toLowerCase() == "ring") {
        rings != null ? rings.add(element) : rings = [element];
      }
    });
    Provider.of<GoldInfo>(context).ring == null
        ? {print("Hiilooo"), Provider.of<GoldInfo>(context).getRings(rings)}
        : null;
    print("alllllllllllllllllllll" + rings.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    _firebaseFirestore = FirebaseFirestore.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productDetails;
    var products;
    var productName, productNamelist;

    return StreamBuilder(
        stream: _firebaseFirestore.collection('Product').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data.docs;

            for (var event in events) {
              productDetails = event.data();
              productName = productDetails["Name"];
              productNamelist != null
                  ? productNamelist.add(productName)
                  : productNamelist = [productName];

              if (products == null) {
                products = [productDetails];
              } else {
                products.add(productDetails);
              }

              //projects will contain all the projects that are being retrieved from the database
            }
          }
          sortCategory(products);
          print(rings);

          return Container(
            decoration: BoxDecoration(
              color: Color(0xffF8F8F8),
            ),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                title: Text(
                  'Gold Categories',
                  style: TextStyle(
                      color: Color(0xff505050),
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
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
                              width: 115,
                              height: 110,
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
                                Text(
                                  '2 items',
                                  style: TextStyle(
                                      color: Color(0xff505050).withOpacity(.6)),
                                )
                              ],
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_right,
                                size: 35,
                                color: Color(0xff2E3A59),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Rings()));
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.5,
                        color: Color(0xff505050).withOpacity(0.3),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 115,
                              height: 110,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffEBEBEB),
                              ),
                              child: Positioned(
                                child: Image.asset('assets/images/chain.png',
                                    scale: 3.0),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Chains',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff505050)),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '2 items',
                                  style: TextStyle(
                                      color: Color(0xff505050).withOpacity(.6)),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,
                                size: 35, color: Color(0xff2E3A59)),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.5,
                        color: Color(0xff505050).withOpacity(0.3),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 115,
                              height: 110,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffEBEBEB),
                              ),
                              child: Positioned(
                                child: Image.asset('assets/images/earings.png',
                                    scale: 3.0),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Earrings',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff505050)),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '2 items',
                                  style: TextStyle(
                                      color: Color(0xff505050).withOpacity(.6)),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,
                                size: 35, color: Color(0xff2E3A59)),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.5,
                        color: Color(0xff505050).withOpacity(0.3),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 115,
                              height: 110,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffEBEBEB),
                              ),
                              child: Positioned(
                                child: Image.asset('assets/images/coin.png',
                                    scale: 3.0),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Coins',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff505050)),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '2 items',
                                  style: TextStyle(
                                      color: Color(0xff505050).withOpacity(.6)),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,
                                size: 35, color: Color(0xff2E3A59)),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.5,
                        color: Color(0xff505050).withOpacity(0.3),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 115,
                              height: 110,
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffEBEBEB),
                              ),
                              child: Positioned(
                                child: Image.asset(
                                  'assets/images/biscuitss.png',
                                  scale: 0.01,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Biscuits',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff505050)),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  '2 items',
                                  style: TextStyle(
                                      color: Color(0xff505050).withOpacity(.6)),
                                )
                              ],
                            ),
                            Spacer(),
                            Icon(Icons.arrow_right,
                                size: 35, color: Color(0xff2E3A59)),
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
            ),
          );
        });
  }
}

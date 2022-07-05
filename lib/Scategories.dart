import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Rings.dart';

class Scategories extends StatefulWidget {
  @override
  _ScategoriesState createState() => _ScategoriesState();
}

class _ScategoriesState extends State<Scategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Silver Categories',
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

                          child: Image.asset('assets/images/silver_ring.png',
                          ),
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
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Rings()));
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
                          child: Image.asset('assets/images/silver_chain.png',
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
                          child: Image.asset('assets/images/silver_earings.png',
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
                          child:
                              Image.asset('assets/images/silver_coin.png', scale: 3.0),
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
                            'assets/images/gold_bar.png',
                            color: Colors.grey[400],
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
  }
}

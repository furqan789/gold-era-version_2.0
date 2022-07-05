import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Rings.dart';

class AllBrands extends StatefulWidget {
  @override
  _AllBrandsState createState() => _AllBrandsState();
}

class _AllBrandsState extends State<AllBrands> {
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
            'Brand Categories',
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





              ],
            ),
          ),
        ),
      ),
    );
  }
}

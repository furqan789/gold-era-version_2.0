import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'RingPredict.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';
import 'RingPredict.dart';

class Chains extends StatefulWidget {
  @override
  _ChainsState createState() => _ChainsState();
}

class _ChainsState extends State<Chains> {
  @override
  Widget build(BuildContext context) {
    var chains;
    chains = Provider.of<GoldInfo>(context,listen: false).chain;
    print(chains);
    var priceData = Provider.of<GoldInfo>(context,listen: false).setLatestData();
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
            'Chains',
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
        body: chains!=null ? GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent:260 ,
            crossAxisSpacing: 30,
            mainAxisSpacing: 60,
          ),
          shrinkWrap: true,
          padding: EdgeInsets.all(20),
          physics: ClampingScrollPhysics(),


          children: [
            ...chains.map(
                  (e) => Expanded(
                child: GestureDetector(
                  onTap: (){
                    Provider.of<GoldInfo>(context, listen: false).ornament=e;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RingPredict()));
                  },
                  child: Container(
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
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Image.asset(
                            'assets/images/ringgs.png',
                            scale: 2.25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              e["Name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,fontSize: 15),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16,top: 8, bottom: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('₹ '+
                                (price * double.parse(e["Weight"]) +
                                    double.parse(e["Making Charge"]) *
                                        double.parse(e["Weight"]))
                                    .toStringAsPrecision(8),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700),
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
        ): Text('No data'),
      ),
    );
  }
}

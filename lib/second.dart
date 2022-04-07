import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GoldpriceModel.dart';
import 'GoldInfo.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

DateTime selectedDate;
String estimatedPrice;
//j
class _SecondPageState extends State<SecondPage> {
  Map<String, dynamic> latest_prices_Silver;
  GoldpriceModel _model;
  @override
  Widget build(BuildContext context) {
    List<dynamic> goldData = Provider.of<GoldInfo>(context).setGoldData();
    Map<String, dynamic> latestData =
        Provider.of<GoldInfo>(context).setLatestData();

    final double conversion_factor = 28.35;
    latest_prices_Silver = Provider.of<GoldInfo>(context).setLatestDataSilver();


    return Container(
      color: Color(0xffF8F8F8),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Price Estimation',
            style: TextStyle(
                color: Color(0xff505050),
                fontWeight: FontWeight.w700,
                fontSize: 24),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Container(
            padding: EdgeInsets.only(top: 25, bottom: 25),
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
                              fontSize: 15,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      Text(
                        ' \u{20B9} ' +
                            (double.parse(latestData["price"]) /
                                conversion_factor)
                                .toStringAsPrecision(6) +
                            " /gm",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                        child: Text('Predicted Buy Price',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      selectedDate != null && estimatedPrice != null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Text(
                            '\u{20B9} ${estimatedPrice} /gm',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFFFFF),
                            ),
                          )
                        ],
                      )
                          : Text(
                            '\u{20B9} - -/- -',style: TextStyle(color: Colors.white,fontSize: 19),

                          ),
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
                              fontSize: 15,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      latest_prices_Silver!=null?
                      Padding(
                        padding: EdgeInsets.all(4),

                        child: Text(
                          "\u{20b9}" + (double.parse(latest_prices_Silver["price"])/conversion_factor).toStringAsPrecision(6),style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.w600),
                        ),
                      ):Text('uu'),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 10),
                        child: Text('Predicted Buy Price',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xffFFFFFF),
                            )),
                      ),
                      selectedDate != null && estimatedPrice != null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          Text(
                            '\u{20B9} - - / -- gm',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFFFFF),
                            ),
                          )
                        ],
                      )
                          : Text(
                        '\u{20B9} - -/- -',style: TextStyle(color: Colors.white,fontSize: 19),

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
                Center(
                  child: InkWell(
                    onTap: () async {
                      var value = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate:
                          DateTime.now().add(Duration(days: 100)));

                      setState(() {
                        if (value != null) {
                          selectedDate = value;
                          estimatedPrice = GoldpriceModel()
                              .linearRegression(
                              goldData[1], goldData[0], selectedDate);
                        }
                        Provider.of<GoldInfo>(context, listen: false)
                            .getEstimatedPrice(
                            double.parse(estimatedPrice));
                        Provider.of<GoldInfo>(context, listen: false)
                            .getSelectedDate(selectedDate);
                      });
                    },

                    child: Container(
                      height:50,
                      width:MediaQuery.of(context).size.width*0.5,//set your height here
                      //set your width here
                      decoration: BoxDecoration(
                          color: Color(0xffF5BA4C),
                          borderRadius: BorderRadius.all(Radius.circular(8))

                      ),
                      child: Center(child: Text('Choose Date', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 21.5,fontWeight: FontWeight.w600,shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(2.85, 2.85),
                            blurRadius: 3.5),
                      ]),)),
                    ),
                  ),
                )
                ,
          Center(
            child:  Container(
              decoration: BoxDecoration(
                border: Border(
                )
              ),
              color: Color(0xff505050).withOpacity(0.20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(onPressed: null, child: Text("Gold"),style: ElevatedButton.styleFrom(primary: Colors.white),),
                  SizedBox(width: 5),
                  ElevatedButton(onPressed: null, child: Text("Silver"),style: ElevatedButton.styleFrom(primary: Colors.white),),

                ],
              ),
            ),
          ),


                //graph
                Padding(
                  padding: const EdgeInsets.only(top:30.0,right: 18),
                  child: Container(
                    child: GoldpriceModel().linearGraph(
                        goldData[0], goldData[1], goldData[0].length),



                    width: double.infinity,
                    height: 240,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

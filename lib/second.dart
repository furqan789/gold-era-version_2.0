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
                      Text(
                        '₹ 6506.26/gm',
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
                      Text(
                        '₹ 106.45/gm',
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
          )
                ,
                Container(

                  height: 65,
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () async {
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
                    child: Text(
                      'CHOOSE DATE',
                      style: TextStyle(
                        color: Color(0xff8b3721),
                        fontFamily: "PlayfairDisplay",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                selectedDate != null && estimatedPrice != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'On ' +
                                selectedDate.day.toString() +
                                "/" +
                                selectedDate.month.toString() +
                                "/" +
                                selectedDate.year.toString(),
                            style: TextStyle(
                              fontFamily: "PlayfairDisplay",
                              color: Color(0xCD872309),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Estimated Price : \u{20B9} ${estimatedPrice} /gm',
                            style: TextStyle(
                              fontFamily: "PlayfairDisplay",
                              color: Color(0xCD872309),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      )
                    : Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Please select a date to make a prediction for that day.',
                          style: TextStyle(
                            fontFamily: "PlayfairDisplay",
                            color: Color(0xCD872309),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, top: 50, bottom: 50),
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: GoldpriceModel().linearGraph(
                          goldData[0], goldData[1], goldData[0].length),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(colors: [
                          Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.1),
                        ] //i
                            ),
                        border: Border.all(
                          width: 1.8,
                          color: Colors.white,
                        )),
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

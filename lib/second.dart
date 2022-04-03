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
  @override
  Widget build(BuildContext context) {
    List<dynamic> goldData = Provider.of<GoldInfo>(context).setGoldData();
    Map<String, dynamic> latestData =
        Provider.of<GoldInfo>(context).setLatestData();

    final double conversion_factor = 28.35;

    return Container(
      color: Color(0xffe7b875),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(50)),
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
                      color: Colors.white,
                      width: 2.5,
                    )),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Text(
                            'Price Estimation',
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "PlayfairDisplay",
                              color: Color(0xCD2B201F),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 12),
                          child: Container(
                            height: 1.0,
                            width: 230.0,
                            color: Color(0xCD872309),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Current Price : \u{20B9} ' +
                              (double.parse(latestData["price"]) /
                                      conversion_factor)
                                  .toStringAsPrecision(6) +
                              " /gm (24 k)",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PlayfairDisplay",
                            color: Color(0xCD872309),
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 90, right: 90, top: 70, bottom: 70),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.white.withOpacity(1),
                              Colors.white.withOpacity(0.8),
                              Colors.white.withOpacity(0.1),
                            ]),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.7),
                              width: 1.5,
                            )),
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
        ),
      ),
    );
  }
}

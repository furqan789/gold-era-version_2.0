import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'GoldpriceModel.dart';
import 'GoldInfo.dart';
import 'package:provider/provider.dart';
import 'package:slidable_button/slidable_button.dart';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

DateTime selectedDate;
String estimatedPrice, estimatedPriceSilver;
bool isSilver = false;

//j
class _SecondPageState extends State<SecondPage> {
  Map<String, dynamic> latest_prices_Silver;
  GoldpriceModel _model;
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> latestData =
        Provider.of<GoldInfo>(context).setLatestData();
    List<dynamic> goldData = Provider.of<GoldInfo>(context).setGoldData();
    List<dynamic> silverData = Provider.of<GoldInfo>(context).setSilverData();

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
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: SlidableButton(
                    height: 44,
                    width: MediaQuery.of(context).size.width / 1.75,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    buttonWidth: MediaQuery.of(context).size.width,
                    color: Color(0xff505050).withOpacity(0.05),
                    buttonColor: Colors.black.withOpacity(0.10),
                    border:
                        Border.all(color: Color(0xff505050).withOpacity(0.2)),
                    dismissible: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Gold',
                          style: TextStyle(
                              color: Color(0xff505050),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        Text('Silver',
                            style: TextStyle(
                                color: Color(0xff505050),
                                fontWeight: FontWeight.w600,
                                fontSize: 16)),
                      ],
                    ),
                    onChanged: (position) {
                      setState(() {
                        if (position == SlidableButtonPosition.right) {
                          print('Button is on the right');
                          print(silverData[1]);
                          setState(() {
                            isSilver = true;
                          });
                        } else {
                          print(goldData[1]);
                          isSilver = false;

                          print('Button is on the left');
                        }
                      });
                    },
                  ),
                ),
                isSilver
                    ? Container(
                        child: GoldpriceModel().linearGraph(
                            silverData[0],
                            silverData[1],
                            silverData[0].length,
                            60,
                            Color(0xFFBEBBBB),
                            Color(0xffBEBBBB)),
                        width: double.infinity,
                        height: 200,
                      )
                    : Container(
                        child: GoldpriceModel().linearGraph(
                            goldData[0],
                            goldData[1],
                            goldData[0].length,
                            2700,
                            Color(0xFFF5BA4C),
                            Color(0xffF5BA4C)),
                        width: double.infinity,
                        height: 200,
                      ),
                Container(
                  padding: EdgeInsets.only(top: 68, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.39,
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 0, right: 0),
                        decoration: BoxDecoration(
                          color: Color(0xffF5BA4C).withOpacity(0.6),
                          border:
                              Border.all(color: Color(0xffDF9100), width: 1),
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
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 10),
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
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 10),
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
                                    '\u{20B9} - -/- -',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.39,
                        padding: EdgeInsets.only(
                            top: 20, bottom: 20, left: 0, right: 0),
                        decoration: BoxDecoration(
                          color: Color(0xff261C1C).withOpacity(0.3),
                          border:
                              Border.all(color: Color(0xff848484), width: 1),
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
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 10),
                              child: Text('Live buy price',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xffFFFFFF),
                                  )),
                            ),
                            latest_prices_Silver != null
                                ? Text(
                                  "\u{20b9}" +
                                      (double.parse(latest_prices_Silver[
                                                  "price"]) /
                                              conversion_factor)
                                          .toStringAsPrecision(5),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                )
                                : Text('uu'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 25.0, bottom: 10),
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
                                        '\u{20B9} ${estimatedPriceSilver} gm',
                                        style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFFFFFF),
                                        ),
                                      )
                                    ],
                                  )
                                : Text(
                                    '\u{20B9} - -/- -',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //graph
                Center(
                  child: InkWell(
                    onTap: () async {
                      var value = await showDatePicker(
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: Color(0xffFBD58E),
                                  onPrimary: Colors.white,
                                  surface: Color(0xffFBD58E),
                                  onSurface: Color(0xff505050),
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child,
                            );
                          },
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 100)));

                      setState(() {
                        if (value != null) {
                          selectedDate = value;
                          estimatedPrice = GoldpriceModel().linearRegression(
                              goldData[1], goldData[0], selectedDate);
                          estimatedPriceSilver = GoldpriceModel()
                              .linearRegression(
                                  silverData[1], silverData[0], selectedDate);
                        }

                        Provider.of<GoldInfo>(context, listen: false)
                            .getEstimatedPrice(double.parse(estimatedPrice));
                        Provider.of<GoldInfo>(context, listen: false)
                            .getSelectedDate(selectedDate);
                        Provider.of<GoldInfo>(context, listen: false)
                            .getEstimatedPriceSilver(
                                double.parse(estimatedPriceSilver));
                      });
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width *
                          0.5, //set your height here
                      //set your width here
                      decoration: BoxDecoration(
                          color: Color(0xffF5BA4C),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        'Choose Date',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.5,
                            fontWeight: FontWeight.w600),
                      )),
                    ),
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

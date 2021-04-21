import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gold_price_predictor/GoldpriceModel.dart';
import 'package:gold_price_predictor/second.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';

class ThirdPage extends StatefulWidget {
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  double currentOrnamentPrice,estimatedOrnamentPrice;
  @override

  Widget build(BuildContext context) {
    Map<String,dynamic> latest_prices = Provider.of<GoldInfo>(context).setLatestData();
    final double conversion_factor = 28.35;



    return Container(
      color: Color(0xffe7b875),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(top:24.0,left: 3,right: 3),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50),),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.20),
                        ],
                        stops: [0.0,1.0]
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.8),
                      width: 2.5,
                    )
                ),
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [

                        Padding(
                          padding: const EdgeInsets.only(top:30.0),
                          child: Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 28,
                              fontFamily: "PlayfairDisplay",
                              color: Color(0xCD2B201F),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding:EdgeInsets.symmetric(horizontal:0.0,vertical:12),
                          child:Container(
                            height:1.0,
                            width:230.0,
                            color: Color(0xCD872309),
                          ),
                        ),
                        SizedBox(height: 40,),
                        currentOrnamentPrice!=null?Text(
                          'Current Price : \u{20B9} $currentOrnamentPrice for 10g of 24k',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PlayfairDisplay",
                            color: Color(0xCD872309),
                            fontWeight: FontWeight.w600,
                          ),
                        ) : SizedBox(),
                        SizedBox(height: 20,),
                        estimatedOrnamentPrice!=null?Text(
                          'Estimated Price : \u{20B9} $estimatedOrnamentPrice for 10g of 24k',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "PlayfairDisplay",
                            color: Color(0xCD872309),
                            fontWeight: FontWeight.w600,
                          ),
                        ) : SizedBox()
                      ],
                    ),
                    SizedBox(height: 50,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage('https://images.melorra.com/image/upload/fl_progressive,f_auto,q_auto/v1595527022/live-melorra/dev/catalogue/images/C2/OPT/580/C16CC201C_P_580.jpg'),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4)
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF747373),
                                    offset: const Offset(7,13),
                                    spreadRadius: -4,
                                    blurRadius: 12,
                                  )
                                ]
                              ),
                              height: 170,
                              width: 155,
                              child: MaterialButton(
                                onPressed: (){
                                  double estimatedPrice = Provider.of<GoldInfo>(context,listen: false).setEstimatedPrice();
                                  int weight = 10;
                                  setState(() {

                                    currentOrnamentPrice = GoldpriceModel().getChainPrice(double.parse(latest_prices["price"])/conversion_factor, weight).toInt().toDouble();
                                  });
                                  if(estimatedPrice!=null){
                                    setState(() {
                                      estimatedOrnamentPrice = GoldpriceModel().getChainPrice(estimatedPrice, weight).toInt().toDouble();
                                    });
                                  }
                                },
                                child: Text(
                                  'CHAIN',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontFamily: "PlayfairDisplay",
                                    color: Color(0xE13D3B3B),
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('https://i.pinimg.com/originals/4f/3e/32/4f3e3259e700ee04288e98dd059003d4.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.4)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF747373),
                                      offset: const Offset(7,13),
                                      spreadRadius: -4,
                                      blurRadius: 12,
                                    )
                                  ]
                              ),
                              height: 170,
                              width: 155,
                              child: MaterialButton(
                                onPressed: (){
                                  double estimatedPrice = Provider.of<GoldInfo>(context,listen: false).setEstimatedPrice();
                                  int weight = 10;
                                  setState(() {

                                    currentOrnamentPrice = GoldpriceModel().getRingPrice(double.parse(latest_prices["price"])/conversion_factor, 10).toInt().toDouble();
                                  });
                                  if(estimatedPrice!=null){
                                    setState(() {
                                      estimatedOrnamentPrice = GoldpriceModel().getRingPrice(estimatedPrice, weight).toInt().toDouble();
                                    });
                                  }
                                },
                                child: Text(
                                  'RING',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "PlayfairDisplay",
                                      color: Color(0xE13D3B3B),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 85,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/coins.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.4)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF747373),
                                      offset: const Offset(7,13),
                                      spreadRadius: -4,
                                      blurRadius: 12,
                                    )
                                  ]
                              ),
                              height: 170,
                              width: 155,
                              child: MaterialButton(
                                onPressed: (){
                                  double estimatedPrice = Provider.of<GoldInfo>(context,listen: false).setEstimatedPrice();
                                  int weight = 10;
                                  setState(() {

                                    currentOrnamentPrice = GoldpriceModel().getCoinPrice(double.parse(latest_prices["price"])/conversion_factor, weight).toInt().toDouble();
                                  });
                                  if(estimatedPrice!=null){
                                    setState(() {
                                      estimatedOrnamentPrice = GoldpriceModel().getCoinPrice(estimatedPrice, weight).toInt().toDouble();
                                    });
                                  }
                                },
                                child: Text(
                                  'COINS',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "PlayfairDisplay",
                                      color: Color(0xE13D3B3B),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('https://staticimg.titan.co.in/Tanishq/Catalog/512219SOKABA00_2.jpg?impolicy=pqmed&imwidth=640'),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(
                                      color: Colors.white.withOpacity(0.4)
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF747373),
                                      offset: const Offset(7,13),
                                      spreadRadius: -4,
                                      blurRadius: 12,
                                    )
                                  ]
                              ),
                              height: 170,
                              width: 155,
                              child: MaterialButton(
                                onPressed: (){
                                  double estimatedPrice = Provider.of<GoldInfo>(context,listen: false).setEstimatedPrice();
                                  int weight = 10;
                                  setState(() {

                                    currentOrnamentPrice = GoldpriceModel().getEarringPrice(double.parse(latest_prices["price"])/conversion_factor, weight).toInt().toDouble();
                                  });
                                  if(estimatedPrice!=null){
                                    setState(() {
                                      estimatedOrnamentPrice = GoldpriceModel().getEarringPrice(estimatedPrice, weight).toInt().toDouble();
                                    });
                                  }
                                },
                                child: Text(
                                  'EARRINGS',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: "PlayfairDisplay",
                                      color: Color(0xE13D3B3B),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 50,),
                      ],
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

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';


class RingPredict extends StatefulWidget {


  @override
  _RingPredictState createState() => _RingPredictState();

}

class _RingPredictState extends State<RingPredict> {

  @override
  Widget build(BuildContext context) {
    double total = 0;
    double gst = 1.8 / 100;

    var priceData =
    Provider.of<GoldInfo>(context, listen: false).setLatestData();
    num price = double.parse(priceData["price"].toString()) / 28.35;

    void totalPrice(Map element, num price) {
      total += ((price * double.parse(element["Weight"])) +
          (double.parse(element["Making Charge"]) *
              double.parse(element["Weight"]))).toInt();
    }
    var orn =Provider.of<GoldInfo>(context,listen: false).ornament;
    total == 0 ? totalPrice(orn, price) : null;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
      ),
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Rings',style: TextStyle(color: Color(0xff505050), fontWeight: FontWeight.bold,fontSize: 23),),
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body:Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children:<Widget> [
                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    child: ClipRRect(
                      child: Image.asset('assets/images/ringgs.png',scale: 1.35,),
                      ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 1.5,
                        color: Color(0xff505050).withOpacity(0.3) ,
                      ),
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(orn['Name'],style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,color: Color(0xff505050),fontWeight: FontWeight.w900),),

                            Text(orn['Metal'],style: TextStyle(fontSize: 14,color: Color(0xffF5BA4C),fontWeight: FontWeight.w600),),

                          ],
                        ),
                      )
                    ],
                  ),
                Text(''+total.toString(), style: TextStyle(fontWeight: FontWeight.w800,fontSize: 24, color: Color(0xff505050)),),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Ring Size: 2 inch',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff505050),
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                      TextButton(
                        child: Text(
                          'Sizing guide',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff505050).withOpacity(0.6)
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top:18,left:18,right:18,bottom:0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:5.0),
                          child: Text(
                            orn['Description'],style: TextStyle(color: Color(0xff505050).withOpacity(0.6),fontSize: 15),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(

                  child: Center(child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        color: Color(0xffF5BA4C),
                        width: MediaQuery.of(context).size.width*0.85,
                        child: TextButton(style: TextButton.styleFrom(
                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 22),


                        ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Add to cart',style: TextStyle(fontWeight: FontWeight.bold),),SizedBox(width: 8,),Icon(Icons.shopping_cart_outlined,color: Colors.white,)
                            ],
                          )),
                      ),
                      Container(

                        width: MediaQuery.of(context).size.width*0.15,
                        decoration: BoxDecoration(
                          color: Color(0xff505050),
                            borderRadius: BorderRadius.only(bottomRight:Radius.circular(7),topRight: Radius.circular(7))
                        ),
                        child: TextButton(style: TextButton.styleFrom(


                          primary: Colors.white,
                          textStyle: const TextStyle(fontSize: 22),

                        ),
                            onPressed: () {},
                            child: Icon(Icons.trending_up_sharp)),
                      ),


                    ],
                  )),
                ),



                ]
            ),
          ),

      ),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool getStarted = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(12.0),
          child: getStarted
              ? InkWell(
                  onTap: () {
                    setState(() {
                      getStarted = false;
                      print(getStarted);
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width *
                        0.6, //set your height here
//set your width here
                    decoration: BoxDecoration(
                        color: Color(0xffF5BA4C),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                        child: Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.5,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ),
                )
              : Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'Login');
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width *
                          0.6, //set your height here
//set your width here
                      decoration: BoxDecoration(
                          color: Color(0xffF5BA4C),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        'Log in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.5,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, 'Sign Up');
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context)
                          .size
                          .width, //set your height here
                      //set your width here
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                          child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffF5BA4C),
                          fontSize: 18.5,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                ]),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/sign_up_bg.png'),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.73),
                        height: MediaQuery.of(context).size.height * 0.59,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5.0,
                                  offset: Offset(0, -7.0))
                            ],
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 50.0, left: 40, right: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18, bottom: 20),
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Predict future prices of',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color:
                                            Color(0xff505050).withOpacity(0.8),
                                        fontWeight: FontWeight.w700),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' GOLD ',
                                        style: TextStyle(
                                            color: Color(0xfff3a922),
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),
                                      ),
                                      TextSpan(text: '&'),
                                      TextSpan(
                                          text: ' SILVER',
                                          style: TextStyle(
                                              color: Colors.grey[300],
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24)),
                                      TextSpan(text: ' price '),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Text(
                                  'Use our application to compare the live price with your future date price then invest and buy accordingly.',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xff505050).withOpacity(0.8),
                                      fontWeight: FontWeight.w600,
                                      height: 1.3),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}

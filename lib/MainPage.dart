import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        body:SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/login2.jpeg'),
                    fit:BoxFit.cover,
                  )
              ),
              width: double.infinity,
              height:MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        'GOLDERA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Color(0xFF663F11),
                        ),
                      ),
                      SizedBox(height: 13,),
                      Text(
                          'WHERE THE WORLD CHECKS THE GOLD PRICE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color(0xff84520b),
                              fontSize: 17
                          )
                      )
                    ],
                  ),
                  SizedBox(height: 80,),
                  Column(
                    children:<Widget> [
                      Container(
                        decoration: BoxDecoration(
                            boxShadow:[
                              BoxShadow(
                                color: Color(0xFF747373),
                                offset: const Offset(7,13),
                                spreadRadius: -4,
                                blurRadius: 12,
                              )
                            ]
                        ),
                        child: MaterialButton(
                          minWidth:double.infinity,
                          height: 50,
                          color: Color(0xFFFFFFFF),
                          onPressed: (){
                            Navigator.pushNamed(context, "Login");
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white10
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontSize: 24,
                              color: Color(0xffA97829),
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25,),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow:[
                              BoxShadow(
                                color:Color(0xFF747373),
                                offset: const Offset(7,16),
                                spreadRadius: -4.0,
                                blurRadius: 12.0,
                              )
                            ]
                        ),
                        child: MaterialButton(

                          minWidth:double.infinity,
                          height: 50,
                          color: Color(0xFFA97829),
                          onPressed: (){
                            Navigator.pushNamed(context, 'Sign Up');
                          },
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.white10
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),

                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                                fontSize: 24,
                                letterSpacing: 1,
                                color: Colors.white

                            ),
                          ),
                        ),
                      )
                    ],
                  )


                ],
              ),
            )
        )
    );
  }
}

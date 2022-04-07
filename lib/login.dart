import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gold_price_predictor/signup.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'GoldInfo.dart';
import 'GoldpriceModel.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';
import 'GoldpriceModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool subvalue = false;
  bool _isObscure = true;
  FirebaseAuth _firebaseAuth;
  String _email, _password;
  bool showPassword = true, isLoaded = false;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> _showMyDialog(String title, String message, String buttonText,
      Function function) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xfffcf6ba).withOpacity(0.7),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    fontFamily: 'QuickSand',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
          actions: <Widget>[
            ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all<double>(0),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.transparent)),
                child: Text(
                  buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onPressed: function),
          ],
        );
      },
    );
  }

  bool formSubmission() {
    try {
      if (_formkey.currentState.validate()) {
        _formkey.currentState.save();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    _firebaseAuth = FirebaseAuth.instance;
    bool subvalue = false;
    bool _isObscure = true;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF8F8F8),
      ),
      child: Scaffold(
        body: SingleChildScrollView(
          child: ModalProgressHUD(
            inAsyncCall: isLoaded,
            progressIndicator: CircularProgressIndicator(
                backgroundColor: Colors.brown.shade50.withOpacity(0.8),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.brown.shade200.withOpacity(0.8),
                )),
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
                          height: MediaQuery.of(context).size.height*0.5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/sign_up_bg.png'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(top:300),
                            height: MediaQuery.of(context).size.height*0.6,
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0,
                                      offset: Offset(0, -7.0)
                                  )
                                ],
                                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                color: Colors.white
                            ),
                            child: Form(
                              key: _formkey,
                              child: Padding(
                                padding: const EdgeInsets.only(top:50.0,left:40,right: 40),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Welcome Back',
//                                      style: GoogleFonts.raleway(fontSize: 24,fontWeight: FontWeight.w700,color:Color(0xff505050)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only( bottom: 5,top: 25),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "Please do not leave this field blank";
                                          } else if (!RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(value)) {
                                            return "Please enter a valid email address";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _email = value;
                                        },
                                        decoration: const InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Name',
                                            hintStyle: TextStyle(color: Color(
                                                0xffa59f9f),fontSize: 17)


                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value == null || value == "") {
                                            return "Please don't leave this field empty";
                                          } else if (!RegExp(
                                              r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})")
                                              .hasMatch(value)) {
                                            return "Please enter a valid password!";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          value != null ? _password = value : null;
                                        },
                                        obscureText: _isObscure,
                                        enableSuggestions: false,
                                        autocorrect: false,

                                        decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Password',
                                            suffixIcon: IconButton(
                                                icon: Icon(
                                                    _isObscure ? Icons.visibility : Icons.visibility_off),
                                                onPressed: () {
                                                  setState(() {
                                                    _isObscure = !_isObscure;
                                                  });
                                                }),
                                            hintStyle: TextStyle(color: Color(
                                                0xffa59f9f),fontSize: 17)
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0,bottom: 30),
                                      child: Align(alignment:Alignment.centerRight,child: Text('Forgot Passcode?',style: TextStyle(color: Color(
                                          0xff505050).withOpacity(0.8),letterSpacing: 1,decoration: TextDecoration.underline),)),
                                    ),

                                    Center(
                                      child: InkWell(
                                        onTap: () async {
                                          if (formSubmission()) {
                                            try {
                                              setState(() {
                                                isLoaded = true;
                                              });
                                              var auth = await _firebaseAuth
                                                  .signInWithEmailAndPassword(
                                                  email: _email,
                                                  password: _password);

                                              if (auth != null) {
                                                await GoldpriceModel()
                                                    .getLatestPrices()
                                                    .then((value) {
                                                  Provider.of<GoldInfo>(context,
                                                      listen: false)
                                                      .getLatestData(value);
                                                }).then((value) async {
                                                  await GoldpriceModel()
                                                      .getGoldPriceData()
                                                      .then((value) {
                                                    Provider.of<GoldInfo>(context,
                                                        listen: false)
                                                        .getGoldData(value);
                                                  });
                                                }).then((value) async {
                                                  await GoldpriceModel()
                                                      .getLatestPricesSilver().then((value) { Provider.of<GoldInfo>(context,listen: false).getLatestDataSilver(value);
                                                  print(Provider.of<GoldInfo>(context,listen: false).setLatestDataSilver());
                                                      });
                                                });

                                                setState(() {
                                                  isLoaded = false;
                                                });

                                                Navigator.pushNamedAndRemoveUntil(
                                                    context,
                                                    'Bottom',
                                                        (route) => false);
                                              }
                                            } catch (e) {
                                              setState(() {
                                                isLoaded = false;
                                              });
                                              print(e);
                                              await _showMyDialog(
                                                  "Error!",
                                                  "Some error occurred while signing in. Please  check your email and password and try again",
                                                  "Ok", () {
                                                Navigator.of(context,
                                                    rootNavigator: true)
                                                    .pop();
                                              });
                                            }
                                          }
                                        },

                                        child: Container(
                                          height:50,
                                          width:MediaQuery.of(context).size.width,//set your height here
                                          //set your width here
                                          decoration: BoxDecoration(
                                              color: Color(0xffF5BA4C),
                                              borderRadius: BorderRadius.all(Radius.circular(8))

                                          ),
                                          child: Center(child: Text('Log in', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 18.5,fontWeight: FontWeight.w600,
                                          ),)),
                                        ),
                                      ),
                                    ),
                                    Spacer(),

                                    Center(
                                      child: Column(
                                        children: [
                                          Text('Already have an account ?',style: TextStyle(color: Color(0xff505050)),),SizedBox(height: 4,),
                                          GestureDetector(onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => SignupPage()));
                                          },child: Text('Register',style: TextStyle(color:Color(0xffF5BA4C),fontSize: 15,fontWeight: FontWeight.w600
                                          ))),
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                        )




                      ],
                    ),


                  ],
                )),
          ),
        ),
      ),
    );
  }
}

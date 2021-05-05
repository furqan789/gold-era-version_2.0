import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'GoldpriceModel.dart';
import 'package:provider/provider.dart';
import 'GoldInfo.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth _firebaseAuth;
  String _email,_password;
  bool showPassword = true,isLoaded = false;


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
                    fontFamily: 'QuickSand', fontWeight: FontWeight.bold,
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
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent)
                ),
                child: Text(buttonText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),), onPressed: function),
          ],
        );
      },
    );
  }

  bool formSubmission(){
    try{if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      return true;

    }
    else{
      return false;
    }} catch(e){
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    _firebaseAuth = FirebaseAuth.instance;

    return Scaffold(

      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color(0xfffcf6ba),
                Color(0xfffcf6ba),
              ])),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoaded,
        progressIndicator: CircularProgressIndicator(
            backgroundColor: Colors.brown.shade50.withOpacity(0.8),
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.brown.shade200.withOpacity(0.8),
            )),
        child: SingleChildScrollView(
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Color(0xfffcf6ba),
                    Color(0xffdcbf7e),
                    Color(0xfffcf6ba),
                    Color(0xfffcf6ba),
                    Color(0xffc7a865),
                  ])),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Column(
                    children: [
                      SizedBox(
                        height: 90,
                      ),
                      Column(
                        children: [
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 30,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2B2A0B),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text('Login to your account',
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xbe24200a),
                                letterSpacing: 1,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(38.0),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value){
                                  if(value==null || value == ""){
                                    return "Please do not leave this field blank";
                                  }
                                  else if(!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                    return "Please enter a valid email address";

                                  }
                                  return null;
                                },
                                onSaved: (value){
                                  _email = value;
                                },
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                  labelText: 'Enter your email',


                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                validator: (value){
                                  if(value==null || value == ""){
                                    return "Please don't leave this field empty";
                                  }
                                  else if(!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,})").hasMatch(value))
                                  {

                                    return "Please enter a valid password!";}
                                  return null;
                                },
                                onSaved: (value){
                                  value!=null ? _password = value : null;
                                },
                                obscureText: showPassword,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Password'
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 1, top: 1),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border(
                                      bottom: BorderSide(color: Colors.black),
                                      right: BorderSide(color: Colors.black),
                                      left: BorderSide(color: Colors.black),
                                      top: BorderSide(color: Colors.black),
                                    )),
                                child: MaterialButton(
                                  height: 60,
                                  minWidth: double.infinity,
                                  onPressed: () async {
                                      if(formSubmission()){
                                       try{
                                            setState(() {
                                              isLoaded = true;
                                            });
                                         var auth = await _firebaseAuth.signInWithEmailAndPassword(email: _email, password: _password);

                                         if(auth !=null){
                                          await GoldpriceModel().getLatestPrices().then((value) {

                                             Provider.of<GoldInfo>(context,listen: false).getLatestData(value);

                                           }).then((value)async  {
                                             await GoldpriceModel().getGoldPriceData().then((value) {

                                               Provider.of<GoldInfo>(context,listen: false).getGoldData(value);

                                             });
                                           });
                                           setState(() {
                                             isLoaded = false;
                                           });

                                           Navigator.pushNamedAndRemoveUntil(context, 'Bottom', (route) => false);
                                         }
                                       }catch(e){
                                         setState(() {
                                           isLoaded = false;
                                         });
                                         print(e);
                                         await _showMyDialog("Error!", "Some error occurred while signing in. Please  check your email and password and try again", "Ok", (){Navigator.of(context, rootNavigator: true).pop();});
                                       }
                                      }


                                    },
                                  elevation: 0,
                                  color: Color(0xFFA97829),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: GestureDetector(
                                    onTap:(){
                                      setState(() {
                                        showPassword = false;
                                      });
                                    } ,
                                    child: Text('Show password')),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?",
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pushNamed(context, 'Sign Up');
                                    },
                                    child: Text(
                                      ' Click here',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF2B2A0B),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              )),
        ),
      ),
    );
  }
}

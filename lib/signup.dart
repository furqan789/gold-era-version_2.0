import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseAuth _auth;

  bool showPassword = true;
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
            child: Text(
              title,
              style: TextStyle(
                  fontFamily: 'QuickSand', fontWeight: FontWeight.bold,
                  color: Colors.black),
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

  @override
  Widget build(BuildContext context) {
    _auth = FirebaseAuth.instance;
    String _email,_password,_confirmPassword;
    final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

    Future<bool> formSubmission() async {
      try{if(_formkey.currentState.validate()){
        _formkey.currentState.save();
        if(_password == _confirmPassword)
        return true ;
        else
          { await _showMyDialog("Password and Confirm Password do not match", "Please make sure, you confirm password field and password value matches.", "Ok", (){Navigator.of(context, rootNavigator: true).pop();});
            return false;}

      }
      else{
        return false;
      }} catch(e){
        return false;
      }

    }
    return Scaffold(
      resizeToAvoidBottomInset: true,

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
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.bottomRight,

                  colors:[
                    Color(0xfffcf6ba),
                    Color(0xffdcbf7e),
                    Color(0xfffcf6ba),
                    Color(0xfffcf6ba),
                    Color(0xffc7a865),
                  ]
              )
          ),
          padding: EdgeInsets.symmetric(horizontal: 40),
          width: double.infinity,
          height: MediaQuery.of(context).size.height-50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        letterSpacing: 1,
                        color: Color(0xFFA97829)
                    ),
                  ),
                  SizedBox(height: 15,),
                  Text(
                    "Create an account, It's free",
                    style: TextStyle(

                        fontSize: 15,
                        letterSpacing: 1,
                        color: Color(0xFF4C4C45)
                    ),
                  ),
                ],
              ),
              Form(
                key: _formkey,
                child: Column(
                  children:<Widget> [

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

                          return "Password too weak!";}
                        return null;
                      },
                      onSaved: (value){
                        value!=null ? _password = value : null;
                      },
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,

                            ))),
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

                          return "Password too weak!";}
                        return null;
                      },
                      onSaved: (value){
                        value!=null ? _confirmPassword = value : null;
                      },
                      obscureText: showPassword,
                      decoration: InputDecoration(
                        labelText: ' Confirm Password',
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            )),),
                    ),

                  ],
                ),
              ),
              Container(
                padding:EdgeInsets.only(left:1,top: 1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border(

                      bottom: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                    )
                ),
                child: MaterialButton(
                  height: 60,
                  minWidth: double.infinity,
                  onPressed: () async {
                   try{ if(await formSubmission()){
                     var signUp = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                     if(signUp!=null){
                       await _showMyDialog("Success!", "You have been successfully signed up. Head on to our login page to sign in", "Ok", () {Navigator.of(context, rootNavigator: true).pop();});
                       Navigator.pop(context);
                     }
                   }}catch(e){
                     await _showMyDialog("Error", "Some error occurred while signing up.", "Ok", (){Navigator.of(context, rootNavigator: true).pop();});
                   }
                  },
                  elevation: 5,
                  color: Color(0xFFA97829),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),


                ),
                ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                    onTap:(){
                      setState(() {
                        showPassword = !showPassword;
                      });
                    } ,
                    child: Text('Show password')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  Text(
                    'Already have an account?',
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, 'Login');
                    },
                    child: Text(
                      ' Click here',
                      style:TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue
                      )
                    ),
                  )
                ],
              )



            ],
        ),
      ),
      )
    );
  }
}

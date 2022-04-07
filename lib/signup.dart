import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  FirebaseAuth _auth;
  bool subvalue = false;
  bool _isObscure = true;
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

      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                      height: MediaQuery.of(context).size.height*0.6,
                      margin: EdgeInsets.only(top:300),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top:50.0,left:40,right: 40),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Get Started', style: GoogleFonts.raleway(fontSize: 27,fontWeight: FontWeight.w700,color:Color(0xff505050)),),


                              Padding(
                                padding: const EdgeInsets.only(top: 40, bottom: 8),
                                child: TextFormField(
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
                                  keyboardType: TextInputType.text,



                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Name',
                                      hintStyle: TextStyle(color: Color(
                                          0xffa59f9f),fontSize: 17)
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,


                                  decoration: const InputDecoration(
                                      border: UnderlineInputBorder(),
                                      hintText: 'Phone Number',
                                      hintStyle: TextStyle(color: Color(
                                          0xffa59f9f),fontSize: 17)
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                                child: TextFormField(
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


                              Container(
                                padding: EdgeInsets.only(bottom: 30,top:18),

                                child: Row(

                                  children: [
                                    SizedBox(
                                      height:24,
                                      width: 24,
                                      child: Checkbox(value: this.subvalue, onChanged: (bool value) {
                                        setState(() {
                                          this.subvalue = value;
                                        },);
                                      }),
                                    ),
                                    SizedBox(width: 12,),
                                    RichText(
                                      text: TextSpan(
                                        text: 'I agree to the',
                                        style:TextStyle(color: Color(0xff505050),letterSpacing: 1),
                                        children: <TextSpan>[
                                          TextSpan(text: ' T&C ', style: TextStyle(color: Color(
                                              0xfff3a922),)),
                                          TextSpan(text: 'and'),
                                          TextSpan(text: ' Privacy Policy',style: TextStyle(color: Color(
                                              0xfff3a922),)),
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),



                              Center(
                                child: InkWell(
                                  onTap: null,
                            //{
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) => Admin()));
                                  // },

                                  child: MaterialButton(
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
                                    child: Container(
                                      height:50,
                                      width:MediaQuery.of(context).size.width,//set your height here
                                      //set your width here
                                      decoration: BoxDecoration(
                                          color: Color(0xffF5BA4C),
                                          borderRadius: BorderRadius.all(Radius.circular(8))

                                      ),

                                      child: Center(child: Text('Sign up', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 21.5,fontWeight: FontWeight.w500,),)),
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),

                              Center(
                                child: Column(
                                  children: [
                                    Text("Don't have an account ?",style: TextStyle(color: Color(0xff505050)),),SizedBox(height: 4,),

                                    GestureDetector(onTap:(){
                                      Navigator.pushNamed(context, 'Login');
                                    },child: Text('Log in',style: TextStyle(color:Color(0xffF5BA4C),fontSize: 15,fontWeight: FontWeight.w600)))
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
              )




            ],
        ),
      ),
      )
    );
  }
}

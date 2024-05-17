
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:videocall/common/theme_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

class LoginPage extends StatefulWidget{
  LoginPage({Key? key, this.user}): super(key:key);
  User ?user;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  double _headerHeight = 250;

  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    _auth.authStateChanges().listen((event) {
      User ? _user = widget.user;
      setState(() {

        _user=event;
      });
      if (_user!=null)
      {
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ProfilePage()));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    String _emailval = '';
    String _passval = "";
    bool check1=false;
    bool check2=false;


    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container( 
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Resolute AI',
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Sign In to your Account',
                      style: TextStyle(color: Colors.orange),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                        child: Column(
                          children: [
                            Container(
                              child: TextFormField(


                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),

                                  hintText: 'Email',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontSize: 16, color: Colors.grey),
                                  prefixIcon: Icon(Icons.email_outlined),
                                  labelText: "Enter your Email Id",
                                  labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.red),
                                ),


                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Can\'t be empty';
                                  }
                                  if (text.length < 7) {
                                    return 'Too short';
                                  }
                                  if (text.contains("@") == false) return 'Missing @';

                                  return null;
                                },
                                // update the state variable when the text changes
                                onChanged: (text) {
                                  setState(() {
                                    _emailval = text;
                                  });


                                },

                              ),

                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextFormField(
                                obscureText: true,
                                obscuringCharacter: "#",
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                  errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                  focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                  hintText: 'Password',

                                  prefixIcon: Icon(Icons.password_outlined),
                                  labelText: "Enter Password",
                                  labelStyle:
                                  TextStyle(fontSize: 15, color: Colors.red),
                                ),// decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),


                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Can\'t be empty';
                                  }
                                  if (text.length < 6) {
                                    return 'Too short';
                                  }
                                  return null;
                                },
                                // update the state variable when the text changes
                                onChanged: (text) {
                                  setState(() {
                                    _passval = text;
                                  });
                                },

                              ),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                },
                                child: Text( "Forgot your password?", style: TextStyle( color: Colors.black,fontWeight: FontWeight.bold ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.orangeAccent.shade200,
                                      Colors.red,
                                      Colors.deepOrange.shade300 //add more colors
                                    ],
                                  ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                  //After successful login we will redirect to profile page. Let's create profile page now
                                  if (_emailval.contains("@") &&
                                      _emailval.length > 7 &&
                                      _emailval != null &&
                                      _emailval.isEmpty &&
                                      EmailValidator.validate(_emailval)) check1 = true;

                                  if (_passval != null &&
                                      _passval.isEmpty &&
                                      _passval.length > 6) check2 = true;

                                  if (check1 == false || check2 == false) {
                                    _dialogBuilder(context);
                                    return null;
                                  }

                                    FocusManager.instance.primaryFocus?.unfocus();
                                    // Future.delayed(const Duration(seconds: 2)).then(
                                    //   (value) => Navigator.pop(context),
                                    // );
                                    Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                    builder: (context) =>
                                    ProfilePage()));
                                    },

                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  ]
                                )
                              ),
                            ),

                            Text("Or login using social media",  style: TextStyle(color: Colors.deepOrange),),
                            SizedBox(height: 15.0),



                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: FaIcon(
                                    FontAwesomeIcons.google, size: 45,
                                    color: HexColor("#EC2D2F"),),
                                  onTap: () async{
                                    setState(() {
                                      _handlesignin();

                                    });
                                  },
                                ),
                                SizedBox(width: 40.0,),
                                GestureDetector(
                                  child: Container(
                                    padding: EdgeInsets.all(0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(width: 5, color: HexColor("#40ABF0")),
                                      color: HexColor("#40ABF0"),
                                    ),
                                    child: FaIcon(
                                      FontAwesomeIcons.linkedinIn, size: 35,
                                      color: HexColor("#FFFFFF"),),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog("Twitter","You tap on Twitter social icon.",context);
                                        },
                                      );
                                    });
                                  },
                                ),
                                SizedBox(width: 40.0,),
                                GestureDetector(
                                  child: FaIcon(
                                    FontAwesomeIcons.meta, size: 42,
                                    color: HexColor("#3E529C"),),
                                  onTap: () {
                                    setState(() {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ThemeHelper().alartDialog("Facebook",
                                              "You tap on Facebook social icon.",
                                              context);
                                        },
                                      );
                                    });
                                  },
                                ),

                              ],
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
  void _handlesignin()
  {
    try {
      GoogleAuthProvider _googleauth = GoogleAuthProvider();
      _auth.signInWithProvider(_googleauth);
    }
    catch(e)
    {
      print(e);
    }


  }
}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Invalid Credentials',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Colors.red)),
          content: const Text('Either Email or Password is Incorrect\n'
              'Try Again or Click Forget Password'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontStyle: FontStyle.normal,
                ),
              ),
              child: const Text('Quit App'),
              onPressed: () {
                exit(0);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontStyle: FontStyle.normal),
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}




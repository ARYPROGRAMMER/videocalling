
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:videocall/pages/login_page.dart';
import 'package:videocall/pages/splash_screen.dart';
import 'package:videocall/pages/widgets/header_widget.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';

class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  final FirebaseAuth _auth = FirebaseAuth.instance;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Information",
          style: TextStyle(fontSize:25,color: Colors.white, fontWeight: FontWeight.bold),
        ),

        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace:Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.orangeAccent.shade100, Colors.deepOrange]
              )
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only( top: 16, right: 16,),
            child: Stack(
              children: <Widget>[
                Container(child: IconButton(iconSize: 35,icon: Icon(Icons.notifications),onPressed: (){log("pressed");},)),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                    constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                    child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 15,), textAlign: TextAlign.center,),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      drawer: Drawer(

        child: Container(

          decoration:BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: [0.0, 1.0],
                  colors: [
                    Colors.white70, Colors.deepOrange.shade600
                  ]
              )
          ) ,
          child: ListView(
            children: [
              SizedBox(
                height: 150,
                child: DrawerHeader(

                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [ Colors.white70, Colors.deepOrange.shade600],
                    ),
                  ),
                  child: Container(

                    alignment: Alignment.center,
                    child: Text("ResoluteAI",
                      style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color:Colors.black),
                title: Text('Restart', style: TextStyle(fontSize: 17, color: Colors.black),),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                },
              ),

              Divider(color: Colors.black,height: 2,),

              ListTile(
                leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Colors.black),
                title: Text('Login Page', style: TextStyle(fontSize: _drawerFontSize, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                },
              ),
              Divider(color: Colors.black, height: 2,),

              ListTile(
                leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Colors.black),
                title: Text('Registration Page',style: TextStyle(fontSize: _drawerFontSize,color: Colors.black),),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
                },
              ),

              Divider(color: Colors.black, height: 2,),

              ListTile(
                leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Colors.black),
                title: Text('Forgot Password Page',style: TextStyle(fontSize: _drawerFontSize,color: Colors.black),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                },
              ),
              Divider(color: Colors.black, height: 2,),

              ListTile(
                leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Colors.black),
                title: Text('Verification Page',style: TextStyle(fontSize: _drawerFontSize,color: Colors.black),),
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
                },
              ),
              Divider(color: Colors.black, height: 2,),
              ListTile(
                leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color:Colors.black,),
                title: Text('Sign Out',style: TextStyle(fontSize: _drawerFontSize,color: Colors.black),),
                onTap: () async{
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didpop){
          _dialogBuilder(context);
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                        ],
                      ),
                      child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                    ),
                    SizedBox(height: 20,),
                    Text('Mr. Arya Singh', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text('Software Developer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "User Information",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Card(
                            elevation: 5,
                            child: Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.all(15),

                              child: Column(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      ...ListTile.divideTiles(
                                        color: Colors.grey,
                                        tiles: [
                                          ListTile(
                                            contentPadding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 4),
                                            leading: Icon(Icons.my_location),
                                            title: Text("Location"),
                                            subtitle: Text("INDIA"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.email),
                                            title: Text("Email"),
                                            subtitle: Text("aryasingh8405@gmail.com"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.phone),
                                            title: Text("Phone"),
                                            subtitle: Text("+91 92024 92849"),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.person),
                                            title: Text("About Me"),
                                            subtitle: Text(
                                                "I am a genius, POV: MORE TO UPDATE BUT LATER."),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

Future<void> _dialogBuilder(BuildContext context) {
  return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Exit',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  color: Colors.red)),
          content: const Text('Are you Sure to Quit?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontStyle: FontStyle.normal,letterSpacing: 3
                ),
              ),
              child: const Text('Quit'),
              onPressed: () {
                exit(0);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontStyle: FontStyle.normal,letterSpacing: 3),
              ),
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
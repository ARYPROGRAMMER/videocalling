import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:videocall/pages/splash_screen.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDI_rUZixkaIc-oFafpTJLJlSiD8vjT0RE",
          appId: "1:382915254672:android:bd0ab66f24234bfccffb15",
          messagingSenderId: "382915254672",
          projectId: "videocalling-3f397"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ResoluteAI',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashScreen(title: 'Flutter Sample Login',),
    );
  }
}

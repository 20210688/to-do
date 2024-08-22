


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/homescreen.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/login/SignUp.dart';
import 'package:to_do/providers/my_provider.dart';

import 'login/login.dart';

  void main() async{
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseFirestore.instance.enableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context)=>MyProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return MaterialApp(
      routes: {
        HomeScreen.routName:(context)=>HomeScreen(),
        LoginScreen.routName:(context)=>LoginScreen(),
        SignUpScreen.routName:(context)=>SignUpScreen(),

      },
      initialRoute:provider.firebaseUser!=null?HomeScreen.routName:
      LoginScreen.routName,
      debugShowCheckedModeBanner: false,
    );
  }
}

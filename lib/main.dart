
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do/homescreen.dart';


  void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomeScreen.routName:(context)=>HomeScreen(),
      },
      initialRoute: HomeScreen.routName,
      debugShowCheckedModeBanner: false,
    );
  }
}


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do/firebase_functions.dart';
import 'package:to_do/models/user_model.dart';

class MyProvider extends ChangeNotifier {
  late User? firebaseUser;
   UserModel? userModel;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null);
    initUser();
    
  }

  initUser() async{
   userModel=await FirebaseFunctions.readUser();
  notifyListeners();
  }
}
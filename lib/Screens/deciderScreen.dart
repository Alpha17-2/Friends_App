import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Screens/homeScreen.dart';
import 'package:firstapp/Screens/welcomeScreen.dart';
import 'package:flutter/material.dart';

class deciderScreen extends StatelessWidget {
  User? currentUser;

  @override
  Widget build(BuildContext context) {
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser!.emailVerified)
      return homeScreen();
    else
      return welcomeScreen();
  }
}

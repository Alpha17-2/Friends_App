import 'package:flutter/material.dart';

class AuthOptions extends ChangeNotifier{
  bool loginState = true;
  bool get fetchLoginState{
    return loginState;
  }
  void change(){
    loginState = !loginState;
    notifyListeners();
  }
}
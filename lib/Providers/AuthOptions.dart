import 'package:flutter/material.dart';

class AuthOptions extends ChangeNotifier {
  bool loginState = true;
  bool viewPass = false;


  bool get fetchObscureTextInfo {
    return viewPass;
  }

  bool get fetchLoginState {
    return loginState;
  }

  void toggle() {
    loginState = !loginState;
    notifyListeners();
  }

  void viewPassword() {
    viewPass = !viewPass;
    notifyListeners();
  }
}

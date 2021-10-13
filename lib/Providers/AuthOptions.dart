import 'package:flutter/material.dart';

class AuthOptions extends ChangeNotifier {
  bool loginState = true;
  bool viewPass = false;
  bool authenticationState = false;
  bool get fetchAuthStatus {
    return authenticationState;
  }

  bool get fetchObscureTextInfo {
    return viewPass;
  }

  bool get fetchLoginState {
    return loginState;
  }

  void tryToAuthenticate() {
    authenticationState = !authenticationState;
    notifyListeners();
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

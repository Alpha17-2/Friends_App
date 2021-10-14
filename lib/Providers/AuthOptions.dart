import 'package:flutter/material.dart';

class AuthOptions extends ChangeNotifier {
  bool loginState = true;
  bool viewPass = false;
  bool authenticationStateForLoading = false;
  bool get fetchAuthStatusForLoading {
    return authenticationStateForLoading;
  }

  bool get fetchObscureTextInfo {
    return viewPass;
  }

  bool get fetchLoginState {
    return loginState;
  }

  void tryToAuthenticate() {
    authenticationStateForLoading = !authenticationStateForLoading;
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

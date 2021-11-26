import 'package:flutter/cupertino.dart';

class screenIndexProvider extends ChangeNotifier {
  int index = 0;
  void updateIndex(int newIndex) {
    index = newIndex;
    notifyListeners();
  }

  int get currentScreen {
    return index;
  }
}

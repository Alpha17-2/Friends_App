import 'package:flutter/material.dart';
class categoryManager extends ChangeNotifier{
  int index = 0;
  int get fetchCurrentCategory{
    return index;
  }
  void updateCategory(int newIndex){
    index = newIndex;
    notifyListeners();
  }
}
import 'package:flutter/material.dart';

class friend {
  final String title;
  final String image;
  friend({this.image, this.title});
}

class friendsProvider {
  List<friend> list = [friend(
     image: '',
     title: 'Naruto'
  )];
}

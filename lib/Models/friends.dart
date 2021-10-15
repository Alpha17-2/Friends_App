import 'package:flutter/material.dart';

class friend {
  final String title;
  final String image;
  friend({this.image, this.title});
}

class friendsProvider {
  List<friend> list = [friend(
     image: 'images/naruto.jpg',
     title: 'Naruto'
  ),
    friend(image: 'images/sasuke.jpg',title: 'Sasuke'),
    friend(image: 'images/kakashi.jpg',title: 'Kakashi'),
    friend(image: 'images/minato.jpg',title: 'Minato'),
    friend(image: 'images/guy.jpg',title: 'Guy'),
  ];
  List<friend> get fetchBestFriends{
    return [...list];
  }
}

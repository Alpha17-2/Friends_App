import 'dart:ui';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Screens/addFriendScreen.dart';
import 'package:firstapp/Screens/exploreScreen.dart';
import 'package:firstapp/Screens/myFriendsScreen.dart';
import 'package:firstapp/Screens/profileScreen.dart';
import 'package:firstapp/Screens/quotesScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class homeScreen extends StatelessWidget {
  //const homeScreen({Key? key}) : super(key: key);

  final List<dynamic> screens= [
    exploreScreen(),
    myFriendsScreen(),
    addFriendScreen(),
    quotesScreen(),
    profileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final iconSize = displayWidth(context) * 0.075;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(color: Color(0xfb004953)),
      height: displayHeight(context),
      width: displayWidth(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: displayHeight(context) * 0.03,
              left: displayWidth(context) * 0.025,
              right: displayWidth(context) * 0.025,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: displayHeight(context) * 0.88,
                width: displayWidth(context),
                child: exploreScreen()
              )),
          Positioned(
            bottom: 0,
            child: Container(
              height: displayHeight(context) * 0.075,
              width: displayWidth(context),
              color: Colors.transparent,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.home_outlined),
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline),
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add_circle_outline),
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.auto_awesome_outlined),
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.person_outlined),
                        color: Colors.white,
                        iconSize: iconSize,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

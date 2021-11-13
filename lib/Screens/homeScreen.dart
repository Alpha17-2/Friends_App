import 'dart:ui';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/screenIndexProvider.dart';
import 'package:firstapp/Screens/exploreScreen.dart';
import 'package:firstapp/Screens/myFriendsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'addFriendScreen.dart';

class homeScreen extends StatelessWidget {
  //const homeScreen({Key? key}) : super(key: key);

  final List<dynamic> screens = [
    exploreScreen(),
    addFriendScreen(),
    myFriendsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenProvider = Provider.of<screenIndexProvider>(context);
    int currentScreen = screenProvider.currentScreen;
    final iconSize = displayWidth(context) * 0.06;
    return Scaffold(
        //backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.orange[300],
          onTap: (value) {
            Provider.of<screenIndexProvider>(context, listen: false)
                .updateIndex(value);
          },
          items: [
            BottomNavigationBarItem(
                label: "Home",
                icon: Icon(
                  (currentScreen == 0) ? Icons.home : Icons.home_outlined,
                )),
            BottomNavigationBarItem(
              label: "New",
              icon: Icon((currentScreen == 1)
                  ? Icons.add_circle
                  : Icons.add_circle_outline),
            ),
            BottomNavigationBarItem(
              label: "Friends",
              icon: Icon(
                (currentScreen == 2) ? Icons.group : Icons.group_outlined,
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 15,
          currentIndex: currentScreen,
          iconSize: iconSize,
          showUnselectedLabels: true,
          showSelectedLabels: true,
        )
        ,
        body: screens[currentScreen]);
  }
}

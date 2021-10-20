import 'dart:ui';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/screenIndexProvider.dart';
import 'package:firstapp/Screens/exploreScreen.dart';
import 'package:firstapp/Screens/myFriendsScreen.dart';
import 'package:firstapp/Screens/quotesScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addFriendScreen.dart';

class homeScreen extends StatelessWidget {
  //const homeScreen({Key? key}) : super(key: key);

  final List<dynamic> screens = [
    exploreScreen(),
    myFriendsScreen(),
    addFriendScreen(),
    quotesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenProvider = Provider.of<screenIndexProvider>(context);
    int currentScreen = screenProvider.currentScreen;
    final iconSize = displayWidth(context) * 0.06;
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          iconSize: iconSize,
          showSelectedLabels: true,
          backgroundColor: Colors.white,
          fixedColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentScreen,
          onTap: (value) {
            screenProvider.updateIndex(value);
          },
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.black54,
                label: 'Home',

                icon: Icon(
                    (currentScreen == 0) ? Icons.home : Icons.home_outlined,
                    color:
                        (currentScreen == 0) ? Colors.black : Colors.black54)),
            BottomNavigationBarItem(
                label: 'Friends',
                icon: Icon(
                    (currentScreen == 1)
                        ? Icons.favorite
                        : Icons.favorite_outline,
                    color:
                        (currentScreen == 1) ? Colors.black : Colors.black54)),
            BottomNavigationBarItem(
                label: 'Connect',
                icon: Icon(
                  (currentScreen == 2)
                      ? Icons.add_circle
                      : Icons.add_circle_outline,
                  color: (currentScreen == 2) ? Colors.black : Colors.black54,
                )),
            BottomNavigationBarItem(
                label: 'Quotes',

                icon: Icon(
                  (currentScreen == 3)
                      ? Icons.auto_awesome
                      : Icons.auto_awesome_outlined,
                  color: (currentScreen == 3) ? Colors.black : Colors.black54,
                )),

          ],
        ),
        body:
             screens[currentScreen]);
  }
}

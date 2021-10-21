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
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
        //backgroundColor: Colors.white,
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeOutQuart,
          animationDuration: Duration(microseconds: 500000),
          backgroundColor: Colors.white,
          color: Colors.orange[400],
          items: [
            Icon((currentScreen == 0) ? Icons.home : Icons.home_outlined,
                color: (currentScreen == 0) ? Colors.white : Colors.white70),
            Icon((currentScreen == 1) ? Icons.favorite : Icons.favorite_outline,
                color: (currentScreen == 1) ? Colors.white : Colors.white70),
            Icon(
              (currentScreen == 2)
                  ? Icons.add_circle
                  : Icons.add_circle_outline,
              color: (currentScreen == 2) ? Colors.white : Colors.white70,
            ),
            Icon(
              (currentScreen == 3)
                  ? Icons.auto_awesome
                  : Icons.auto_awesome_outlined,
              color: (currentScreen == 3) ? Colors.white : Colors.white70,
            ),
          ],
          height: displayHeight(context) * 0.07,
          index: currentScreen,
          onTap: (value) =>
              Provider.of<screenIndexProvider>(context, listen: false)
                  .updateIndex(value),
        ),
        body: screens[currentScreen]);
  }
}

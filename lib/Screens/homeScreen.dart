import 'dart:ui';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/AuthOptions.dart';
import 'package:firstapp/Providers/screenIndexProvider.dart';
import 'package:firstapp/Screens/addFriendScreen.dart';
import 'package:firstapp/Screens/exploreScreen.dart';
import 'package:firstapp/Screens/myFriendsScreen.dart';
import 'package:firstapp/Screens/profileScreen.dart';
import 'package:firstapp/Screens/quotesScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

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
    final screenProvider = Provider.of<screenIndexProvider>(context);
    int currentScreen = screenProvider.currentScreen;
    final iconSize = displayWidth(context) * 0.075;
    final selectedIconSize = displayWidth(context)*0.078;
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
                child: screens[currentScreen]
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
                        onPressed: () {
                          screenProvider.updateIndex(0);
                        },
                        icon: Icon((currentScreen == 0)?Icons.home:Icons.home_outlined),
                        color: (currentScreen == 0)?Colors.white:Colors.white70,
                        iconSize: (currentScreen==0)?selectedIconSize:iconSize,
                      ),
                      IconButton(
                        onPressed: () {
                          screenProvider.updateIndex(1);
                        },
                        icon: Icon((currentScreen == 1)?Icons.favorite:Icons.favorite_outline),
                        color: (currentScreen == 1)?Colors.white:Colors.white70,
                        iconSize: (currentScreen==1)?selectedIconSize:iconSize,
                      ),
                      IconButton(
                        onPressed: () {
                          screenProvider.updateIndex(2);
                        },
                        icon: Icon((currentScreen == 2)?Icons.add_circle:Icons.add_circle_outline),
                        color: (currentScreen == 2)?Colors.white:Colors.white70,
                        iconSize: (currentScreen==2)?selectedIconSize:iconSize,
                      ),
                      IconButton(
                        onPressed: () {
                          screenProvider.updateIndex(3);
                        },
                        icon: Icon((currentScreen == 3)?Icons.auto_awesome:Icons.auto_awesome_outlined),
                        color: (currentScreen == 3)?Colors.white:Colors.white70,
                        iconSize: (currentScreen==3)?selectedIconSize:iconSize,
                      ),
                      IconButton(
                        onPressed: () {
                          screenProvider.updateIndex(4);
                        },
                        icon: Icon((currentScreen == 4)?Icons.person:Icons.person_outlined),
                        color: (currentScreen == 4)?Colors.white:Colors.white70,
                        iconSize: (currentScreen==4)?selectedIconSize:iconSize,
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

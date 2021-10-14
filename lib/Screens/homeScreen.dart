import 'dart:ui';

import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class homeScreen extends StatelessWidget {
  //const homeScreen({Key? key}) : super(key: key);

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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: displayHeight(context) * 0.45,
                        width: displayWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          image: DecorationImage(
                              image: AssetImage(
                                  'images/08809940d40530bfdb457d7a60466657.jpg'),
                              fit: BoxFit.cover),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                          child: Container(
                            color: Colors.black.withOpacity(0.4),
                            height: displayHeight(context) * 0.45,
                            width: displayWidth(context),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, top: 12, bottom: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: displayWidth(context) * 0.06,
                                        backgroundColor: Colors.grey[300],
                                        child: Center(
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.settings),
                                              color: Colors.black,
                                              iconSize: displayWidth(context) *
                                                  0.055),
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: displayWidth(context) * 0.06,
                                        backgroundColor: Colors.grey[300],
                                        backgroundImage: AssetImage(
                                            'images/friendsIcon2.png'),
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Welcome,',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: displayWidth(context)*0.05,
                                        ),
                                      ),
                                      Text(
                                        'Subhojeet Sahoo',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.white,
                                          fontSize: displayWidth(context)*0.07,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Divider(),
                                ],
                              ),
                            ),
                          ),
                        )),

                  ],
                ),
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

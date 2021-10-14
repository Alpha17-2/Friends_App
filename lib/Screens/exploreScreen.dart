import 'dart:ui';

import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/material.dart';
class exploreScreen extends StatelessWidget {
  //const exploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
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
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Welcome,',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize:
                              displayWidth(context) * 0.05,
                            ),
                          ),
                          Text(
                            'Subhojeet Sahoo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                displayWidth(context) * 0.07,
                                fontWeight: FontWeight.bold),
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
        Divider(),
        Padding(
          padding: const EdgeInsets.only(left:8.0),
          child: Text('Best Friends',style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: displayWidth(context)*0.045,
          ),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.pink,
            height: displayHeight(context)*0.12,
            width: displayWidth(context),
          ),
        ),

      ],
    );
  }
}

import 'package:firstapp/Helpers/custom_paint.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/material.dart';

class myFriendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      child:Stack(
        alignment: Alignment.center,
        fit:StackFit.loose,
        children: [
          Positioned(child: CustomPaint(
            child: Container(
              height: displayHeight(context) * 0.25,
              width: displayWidth(context),
            ),
            painter: CurvePainter(),
          ),top: 0,),
          Positioned(
            top: displayHeight(context)*0.1,
            child: CircleAvatar(
              radius: displayWidth(context)*0.15,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: displayWidth(context)*0.13,
                backgroundImage: AssetImage('images/friendsIcon2.png'),
              ),
            ),
          ),
        ],
      )
    );
  }
}

import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Widget showMyFriends(BuildContext context, Friend f) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 12,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: displayHeight(context) * 0.02,
            child: CircleAvatar(
              backgroundImage: NetworkImage(f.dp!),
              radius: displayWidth(context) * 0.13,
            ),
          ),
          Positioned(
            top: displayHeight(context) * 0.03,
            right: displayWidth(context) * 0.07,
            child: CircleAvatar(
              backgroundColor: Colors.orange[400],
              radius: displayWidth(context) * 0.038,
              child: Center(
                child: IconButton(
                  icon: Icon(Ionicons.star),
                  onPressed: () {},
                  iconSize: displayWidth(context) * 0.032,
                  color: Colors.yellow,
                ),
              ),
            ),
          ),
          Positioned(
              bottom: displayHeight(context) * 0.01,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    f.title!,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: displayWidth(context) * 0.036),
                  ),
                  Text(
                   f.education!,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: displayWidth(context) * 0.032,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ))
        ],
      ),
    ),
  );
}

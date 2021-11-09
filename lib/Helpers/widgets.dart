import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Screens/friendDetailScreen.dart';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => friendDetailScreen(
                            friend: f,
                          ),
                        ));
                  },
                  child: Hero(
                    tag: f.docId!,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(f.dp!),
                      radius: displayWidth(context) * 0.09,
                    ),
                  ),
                ),
                // Title and education
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: displayHeight(context)*0.03,
                      width: displayWidth(context)*0.25,
                      child: Text(
                        f.title!,
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: displayWidth(context) * 0.0355),
                      ),
                    ),
                    Container(
                      height: displayHeight(context)*0.03,
                      width: displayWidth(context)*0.25,
                      child: Text(
                        f.education!,
                      
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                            color: Colors.black54,
                            fontSize: displayWidth(context) * 0.031,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),

            // Best friend and close friend icons

            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.orange[400]!,
                          Colors.orange[300]!,
                          Colors.orange[200]!
                        ])),
                height: displayHeight(context) * 0.15,
                width: displayWidth(context) * 0.075,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        color: Colors.white,
                        iconSize: displayWidth(context) * 0.035,
                        onPressed: () {},
                        icon: (Icon((f.isBestFriend!)
                            ? Ionicons.heart_circle
                            : Ionicons.heart_circle_outline))),
                    IconButton(
                        color: Colors.white,
                        iconSize: displayWidth(context) * 0.035,
                        onPressed: () {},
                        icon: (Icon((f.isBestFriend!)
                            ? Ionicons.star
                            : Ionicons.star_outline))),
                  ],
                ),
              ),
            )
          ],
        )),
  );
}

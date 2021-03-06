import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:firstapp/Screens/friendDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

connectUsViaMail(String mail) async {
  final String url = 'mailto:$mail';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

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
                    child: (f.dp != null && f.dp != '')
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(f.dp!),
                            radius: displayWidth(context) * 0.09,
                          )
                        : CircleAvatar(
                            backgroundImage: AssetImage((f.gender == 'Male')
                                ? 'images/male.jpg'
                                : 'images/female.jpg'),
                            radius: displayWidth(context) * 0.09,
                          ),
                  ),
                ),
                // Title and education
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: displayHeight(context) * 0.03,
                      width: displayWidth(context) * 0.25,
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
                      height: displayHeight(context) * 0.03,
                      width: displayWidth(context) * 0.25,
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
                height: displayHeight(context) * 0.16,
                width: displayWidth(context) * 0.075,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                          color: Colors.white,
                          iconSize: displayWidth(context) * 0.035,
                          onPressed: () {
                            Provider.of<FriendsManager>(context, listen: false)
                                .updateBestFriend(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    f.docId);
                          },
                          icon: (Icon((f.isBestFriend!)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined))),
                    ),
                    Expanded(
                      child: IconButton(
                          color: Colors.white,
                          iconSize: displayWidth(context) * 0.035,
                          onPressed: () {
                            Provider.of<FriendsManager>(context, listen: false)
                                .updateCloseFriend(
                                    FirebaseAuth.instance.currentUser!.uid,
                                    f.docId);
                          },
                          icon: (Icon((f.isCloseFriend!)
                              ? Ionicons.star
                              : Ionicons.star_outline))),
                    ),
                    Expanded(
                      child: IconButton(
                          color: Colors.white,
                          iconSize: displayWidth(context) * 0.035,
                          onPressed: () async {
                            String friendName = f.title!;

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    'Unfriend',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  content: Text(
                                    'Are you sure you want to unfriend ${friendName} ?',
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No')),
                                    TextButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red[400]),
                                        ),
                                        onPressed: () {
                                          Provider.of<FriendsManager>(context,
                                                  listen: false)
                                              .deleteFriend(
                                                  FirebaseAuth
                                                      .instance.currentUser!.uid
                                                      .toString(),
                                                  f.docId!);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ],
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.delete_forever)),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
  );
}

Future<void> launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String get snapchatUrl {
  return 'https://www.snapchat.com/add/';
}


String get instagramUrl {
  return 'https://www.instagram.com/';
}

String get twitterUrl {
  return 'https://twitter.com/';
}

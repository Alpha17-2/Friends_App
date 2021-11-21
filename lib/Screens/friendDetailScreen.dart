import 'dart:math';
import 'package:firstapp/Helpers/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:firstapp/Screens/editFriendScreen.dart';
import 'package:firstapp/Screens/imageScreen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class friendDetailScreen extends StatefulWidget {
  final Friend? friend;
  friendDetailScreen({this.friend});

  @override
  State<friendDetailScreen> createState() => _friendDetailScreenState();
}

class _friendDetailScreenState extends State<friendDetailScreen> {
  final cardColors = [
    Colors.yellow[50],
    Colors.green[50],
    Colors.pink[50],
    Colors.red[50],
    Colors.blue[50],
    Colors.orange[50],
    Colors.teal[50],
  ];
  bool? isDrawerOpen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDrawerOpen = false;
  }

  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> interests = widget.friend!.interests!;
    DateTime time = DateTime.parse(widget.friend!.dob!);
    int doby = time.year;
    int dobm = time.month;
    int dobd = time.day;
    int age = DateTime.now().year - doby;
    double iconSize = displayWidth(context) * 0.045;
    print(age);
    return Scaffold(
        body: Container(
      height: displayHeight(context),
      width: displayWidth(context),
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            child: Hero(
              tag: widget.friend!.docId!,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
                child: (widget.friend!.dp == '' || widget.friend!.dp!.isEmpty)
                    ? Image.asset(
                        widget.friend!.gender == "Male"
                            ? 'images/male.jpg'
                            : 'images/female.jpg',
                        height: displayHeight(context) * 0.55,
                        width: displayWidth(context),
                        fit: BoxFit.cover,
                      )
                    : Image.network(
                        widget.friend!.dp!,
                        height: displayHeight(context) * 0.55,
                        width: displayWidth(context),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Positioned(
              top: displayHeight(context) * 0.04,
              left: displayWidth(context) * 0.04,
              child: Card(
                color: Colors.white54,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: IconButton(
                    iconSize: displayWidth(context) * 0.04,
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios_new),
                    color: Colors.black54,
                  ),
                ),
              )),
          Positioned(
              top: displayHeight(context) * 0.05,
              right: 0,
              child: SizedBox(
                height: displayHeight(context) * 0.425,
                width: displayWidth(context) * 0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => editFriendScreen(
                                docId: widget.friend!.docId,
                                f: widget.friend,
                              ),
                            ));
                      },
                      child: Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.edit, color: Colors.yellow),
                          )),
                    ),
                    Card(
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Ionicons.heart,
                            color: Colors.pink[600],
                          ),
                        )),
                    Card(
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Ionicons.star,
                            color: Colors.indigo[700],
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => imageScreen(
                                dpImage: widget.friend!.dp,
                                docId: widget.friend!.docId,
                              ),
                            ));
                      },
                      child: Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Ionicons.images,
                              color: Colors.teal,
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.friend!.contactNumber != '')
                          launch(('tel://${widget.friend!.contactNumber}'));
                        else {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: displayHeight(context) * 0.3,
                                width: displayWidth(context),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Error !!',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                              displayWidth(context) * 0.05,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Opacity(opacity: 0.0, child: Divider()),
                                      Text(
                                        'No contact number found',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize:
                                              displayWidth(context) * 0.042,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Ionicons.call,
                              color: Colors.blue,
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.friend!.mail != '')
                          connectUsViaMail(widget.friend!.mail!);
                        else {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                height: displayHeight(context) * 0.3,
                                width: displayWidth(context),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Error !!',
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                              displayWidth(context) * 0.05,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Opacity(opacity: 0.0, child: Divider()),
                                      Text(
                                        'No email address found',
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontSize:
                                              displayWidth(context) * 0.042,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      child: Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.mail,
                              color: Colors.orange,
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        Provider.of<FriendsManager>(context, listen: false)
                            .deleteFriend(
                                FirebaseAuth.instance.currentUser!.uid
                                    .toString(),
                                widget.friend!.docId!)
                            .then((value) {
                          Navigator.pop(context);
                        });
                      },
                      child: Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.delete_forever,
                              color: Colors.red[300],
                            ),
                          )),
                    ),
                  ],
                ),
              )),
          Positioned(
              top: displayHeight(context) * 0.52,
              right: displayWidth(context) * 0.2,
              height: displayHeight(context) * 0.06,
              width: displayWidth(context) * 0.12,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff152238)),
                child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                        elevation: 0,
                        backgroundColor: Colors.transparent.withOpacity(0.0),
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: displayHeight(context) * 0.48,
                            color: Colors.transparent.withOpacity(0.0),
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    right: displayWidth(context) * 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                        color: Color(
                                          (0xff152238),
                                        ),
                                      ),
                                      height: displayHeight(context) * 0.43,
                                      width: displayWidth(context) * 0.12,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              iconSize: iconSize,
                                              onPressed: () {
                                                // Close
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Ionicons.close_circle),
                                              color: Colors.white,
                                            ),
                                            IconButton(
                                              iconSize: iconSize,
                                              onPressed: () {
                                                // Instagram
                                              },
                                              icon:
                                                  Icon(Ionicons.logo_facebook),
                                              color: Colors.white,
                                            ),
                                            IconButton(
                                              iconSize: iconSize,
                                              onPressed: () {
                                                // Instagram
                                              },
                                              icon:
                                                  Icon(Ionicons.logo_instagram),
                                              color: Colors.pink[300],
                                            ),
                                            IconButton(
                                              iconSize: iconSize,
                                              onPressed: () {
                                                // Twitter
                                              },
                                              icon: Icon(Ionicons.logo_twitter),
                                              color: Colors.blue[400],
                                            ),
                                            IconButton(
                                              iconSize: iconSize,
                                              onPressed: () {
                                                // Snapchat
                                              },
                                              icon:
                                                  Icon(Ionicons.logo_snapchat),
                                              color: Colors.yellow[400],
                                            ),
                                            IconButton(
                                              iconSize: iconSize,
                                              onPressed: () {
                                                // LinkedIn
                                              },
                                              icon:
                                                  Icon(Ionicons.logo_linkedin),
                                              color: Colors.white,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Image.asset(
                                                'images/yt.png',
                                                height: displayHeight(context) *
                                                    0.026,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Icon(Ionicons.menu_outline)),
              )),
          Positioned(
              top: displayHeight(context) * 0.55,
              child: Container(
                height: displayHeight(context) * 0.45,
                width: displayWidth(context),
                //color: Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.friend!.title!}, ${age.toString()}',
                              style: TextStyle(
                                  letterSpacing: 0.2,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Zen",
                                  fontSize: displayWidth(context) * 0.048),
                            ),
                            Text(
                              widget.friend!.gender!,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: displayWidth(context) * 0.04),
                            )
                          ],
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.02,
                            )),
                        Text(
                          'Birthday',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.45,
                              fontSize: displayWidth(context) * 0.035),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.003,
                            )),
                        Text(
                          '${dobd.toString()} ${months[dobm - 1]}, ${doby.toString()}',
                          style: TextStyle(
                            color: Colors.grey[500],
                            letterSpacing: 0.45,
                            fontSize: displayWidth(context) * 0.032,
                          ),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.012,
                            )),
                        Text(
                          'School',
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.45,
                              fontSize: displayWidth(context) * 0.035),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.003,
                            )),
                        Text(
                          (widget.friend!.school != null &&
                                  widget.friend!.school != ''
                              ? '${widget.friend!.school}'
                              : 'Not available'),
                          style: TextStyle(
                            color: Colors.grey[500],
                            letterSpacing: 0.45,
                            fontSize: displayWidth(context) * 0.032,
                          ),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.012,
                            )),
                        Text(
                          'College',
                          style: TextStyle(
                              color: Colors.black87,
                              letterSpacing: 0.45,
                              fontWeight: FontWeight.bold,
                              fontSize: displayWidth(context) * 0.035),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.003,
                            )),
                        Text(
                          (widget.friend!.college != null &&
                                  widget.friend!.college != ''
                              ? '${widget.friend!.college}'
                              : 'Not available'),
                          style: TextStyle(
                            color: Colors.grey[500],
                            letterSpacing: 0.45,
                            fontSize: displayWidth(context) * 0.032,
                          ),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.012,
                            )),
                        Text(
                          'Profession',
                          style: TextStyle(
                              color: Colors.black87,
                              letterSpacing: 0.45,
                              fontWeight: FontWeight.bold,
                              fontSize: displayWidth(context) * 0.035),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.003,
                            )),
                        (widget.friend!.profession != null &&
                                widget.friend!.profession != '')
                            ? (widget.friend!.work != null &&
                                    widget.friend!.work != '')
                                ? Text(
                                    '${widget.friend!.profession} at ${widget.friend!.work}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      letterSpacing: 0.45,
                                      fontSize: displayWidth(context) * 0.032,
                                    ),
                                  )
                                : Text(
                                    '${widget.friend!.profession}',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      letterSpacing: 0.45,
                                      fontSize: displayWidth(context) * 0.032,
                                    ),
                                  )
                            : Text(
                                'Not available',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  letterSpacing: 0.45,
                                  fontSize: displayWidth(context) * 0.032,
                                ),
                              ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.012,
                            )),
                        Text(
                          'About',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.45,
                              fontSize: displayWidth(context) * 0.035),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.003,
                            )),
                        Text(
                          widget.friend!.about!,
                          style: TextStyle(
                            color: Colors.grey[500],
                            letterSpacing: 0.45,
                            fontSize: displayWidth(context) * 0.032,
                          ),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: displayHeight(context) * 0.012,
                            )),
                        Text(
                          'Interests',
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 0.45,
                              fontWeight: FontWeight.bold,
                              fontSize: displayWidth(context) * 0.035),
                        ),
                        Opacity(
                            opacity: 0.0,
                            child: Divider(
                              height: 2,
                            )),
                        Container(
                          width: displayWidth(context),
                          height: displayHeight(context) * 0.06,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              Random rd = Random();
                              int value = rd.nextInt(cardColors.length);
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 5,
                                  color: cardColors[value],
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        interests[index],
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: interests.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}

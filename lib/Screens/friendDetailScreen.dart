import 'dart:math';

import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Screens/imageScreen.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

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
  final List<String> months = ['January','February','March','April','May','June','July','August','September','October','November','December'];

  @override
  Widget build(BuildContext context) {
    List<dynamic> interests = widget.friend!.interests!;
    DateTime time = DateTime.parse(widget.friend!.dob!);
    int doby = time.year;
    int dobm = time.month;
    int dobd = time.day;
    int age = doby - DateTime.now().year;

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
                child: Image.network(
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
              right: displayWidth(context) * 0.01,
              child: SizedBox(
                height: displayHeight(context) * 0.32,
                width: displayWidth(context) * 0.18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        )),
                    Card(
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
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
                          padding: const EdgeInsets.all(6.0),
                          child: Icon(
                            Ionicons.star,
                            color: Colors.indigo[700],
                          ),
                        )),
                    GestureDetector(onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => imageScreen(
                        dpImage: widget.friend!.dp,
                        images: [],
                        docId: widget.friend!.docId,
                      ),));
                    },
                      child: Card(
                          color: Colors.white54,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(
                              Ionicons.images,
                              color: Colors.teal,
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
                           elevation:0,
                           backgroundColor: Colors.transparent.withOpacity(0.0),
                           barrierColor: Colors.transparent,
                           context: context, builder: (context) {
                           
                          return Container(
                            height: displayHeight(context)*0.48,
                            color: Colors.transparent.withOpacity(0.0),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 0,
                                    right: displayWidth(context) * 0.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                        color: Color((0xff152238),
                                      ),
                                      ),
                                  height: displayHeight(context)*0.43,
                                  width: displayWidth(context)*0.12,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          IconButton(onPressed: () {
                                            // Close
                                            Navigator.pop(context);
                                          }, icon: Icon(Ionicons.close_circle),
                                            color: Colors.white,
                                          ),
                                          IconButton(onPressed: () {
                                            // Instagram
                                          }, icon: Icon(Ionicons.logo_facebook),
                                            color: Colors.white,
                                          ),
                                          IconButton(onPressed: () {
                                            // Instagram
                                          }, icon: Icon(Ionicons.logo_instagram),
                                            color: Colors.pink[300],
                                          ),
                                          IconButton(onPressed: () {
                                            // Twitter
                                          }, icon: Icon(Ionicons.logo_twitter),
                                            color: Colors.blue[400],
                                          ),
                                          IconButton(onPressed: () {
                                            // Snapchat
                                          }, icon: Icon(Ionicons.logo_snapchat),
                                            color: Colors.yellow[400],
                                          ),
                                          IconButton(onPressed: () {
                                            // LinkedIn
                                          }, icon: Icon(Ionicons.logo_linkedin),
                                            color: Colors.white,
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Image.asset('images/yt.png',height: displayHeight(context)*0.03,fit: BoxFit.cover,),
                                          ),
                                        ],
                                      ),
                                )),
                              ],
                            ),
                          );
                        },);
                      },
                    icon: Icon(Ionicons.menu_outline)),
              )),
          Positioned(
              top: displayHeight(context) * 0.55,
              child: Container(
                height: displayHeight(context) * 0.55,
                width: displayWidth(context),
                //color: Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.friend!.title!}, ${age.toString()}',
                                style: TextStyle(
                                    letterSpacing: 0.2,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Zen",
                                    fontSize: displayWidth(context) * 0.05),
                              ),
                              Opacity(
                                  opacity: 0.0,
                                  child: Divider(
                                    height: 5,
                                  )),
                              Text(
                                '${widget.friend!.profession}, ${widget.friend!.education}',
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: displayWidth(context) * 0.042,
                                ),
                              ),
                            ],
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
                      Opacity(opacity: 0.0, child: Divider()),
                      Text(
                        'Birthday',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: displayWidth(context) * 0.05),
                      ),
                      Opacity(
                          opacity: 0.0,
                          child: Divider(
                            height: 5,
                          )),
                      Text(
                        '${dobd.toString()} ${months[dobm-1]}, ${doby.toString()}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          letterSpacing: 0.45,
                          fontSize: displayWidth(context) * 0.04,
                        ),
                      ),
                      Opacity(opacity: 0.0, child: Divider()),
                      Text(
                        'About',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: displayWidth(context) * 0.05),
                      ),
                      Opacity(
                          opacity: 0.0,
                          child: Divider(
                            height: 2,
                          )),
                      Text(
                        widget.friend!.about!,
                        style: TextStyle(
                          color: Colors.grey[500],
                          letterSpacing: 0.45,
                          fontSize: displayWidth(context) * 0.04,
                        ),
                      ),
                      Opacity(opacity: 0.0, child: Divider()),
                      Text(
                        'Interests',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: displayWidth(context) * 0.05),
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
                                    padding: const EdgeInsets.all(8.0),
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
              )),
        ],
      ),
    ));
  }
}

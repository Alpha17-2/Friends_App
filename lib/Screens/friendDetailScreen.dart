import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class friendDetailScreen extends StatelessWidget {
  friendDetailScreen({this.friend});

  final Friend? friend;

  @override
  Widget build(BuildContext context) {
    int age = 20;
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
              tag: friend!.docId!,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(45),
                ),
                child: Image.network(
                  friend!.dp!,
                  height: displayHeight(context) * 0.45,
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
                height: displayHeight(context) * 0.25,
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
                          padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Ionicons.heart,
                            color: Colors.pink[400],
                          ),
                        )),
                    Card(
                        color: Colors.white54,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Ionicons.star,
                            color: Colors.indigo[700],
                          ),
                        )),
                  ],
                ),
              )),
          Positioned(
              top: displayHeight(context) * 0.45,
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
                      Text(
                        '${friend!.title!}, ${age.toString()}',
                        style: TextStyle(
                            letterSpacing: 0.2,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Zen",
                            fontSize: displayWidth(context) * 0.05),
                      ),
                      Text('${friend!.profession}',style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: displayWidth(context)*0.04,
                      ),),
                      Opacity(opacity: 0.0,child: Divider()),
                      Text('About',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: displayWidth(context)*0.05),),
                      Opacity(opacity: 0.0,child: Divider(height: 2,)),
                      Text(friend!.about!,style: TextStyle(color: Colors.grey[500],
                      letterSpacing: 0.45,
                        fontSize: displayWidth(context)*0.04,),)
                    ],
                  ),
                ),
              )),
        ],
      ),
    ));
  }
}

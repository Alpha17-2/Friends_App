import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/custom_paint.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Helpers/widgets.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class myFriendsScreen extends StatefulWidget {
  @override
  State<myFriendsScreen> createState() => _myFriendsScreenState();
}

class _myFriendsScreenState extends State<myFriendsScreen> {
  bool init = true;
  bool isLoading = true;
  User currentUser;
  @override
  void initState() {
    // TODO: implement initState
    currentUser = FirebaseAuth.instance.currentUser;
    super.initState();
  }
  @override
  void didChangeDependencies() async {
    if(init){
      Provider.of<FriendsManager>(context).setFriends().then((value) {
        isLoading = false;
      });
      init =false;
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    List<Friend> friends = Provider.of<FriendsManager>(context).fetchList;

    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      child:Stack(
        alignment: Alignment.center,
        fit:StackFit.loose,
        children: [
          Positioned(child: CustomPaint(
            child: Container(
              height: displayHeight(context) * 0.2,
              width: displayWidth(context),
            ),
            painter: CurvePainter(),
          ),top: 0,),
          Positioned(
            top: displayHeight(context)*0.08,
            child: CircleAvatar(
              radius: displayWidth(context)*0.15,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: displayWidth(context)*0.13,
                backgroundImage: AssetImage('images/friendsIcon2.png'),
              ),
            ),
          ),
          Positioned(
            top: displayHeight(context)*0.232,
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(currentUser.displayName,style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: displayWidth(context)*0.045
              ),),
              Divider(height: 2,),
              Text('${friends.length.toString()} Friends',style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: displayWidth(context)*0.04
              ),),
            ],
          )),
          Positioned(
            top: displayHeight(context)*0.4,
              child: Container(
            height: displayHeight(context)*0.5,
            width: displayWidth(context),
            color: Colors.pinkAccent,
            child: (isLoading)
                ? Center(child: CircularProgressIndicator())
                :GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5,
              //childAspectRatio: 0.5
            ),
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  return showMyFriends(context,friends[index]);
                },),

          ))
        ],
      )
    );
  }
}

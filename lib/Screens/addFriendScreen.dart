import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/material.dart';
class addFriendScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("My new friend ",style: TextStyle(
            color: Colors.indigo[600],
            fontSize: displayWidth(context)*0.05,
            
          ),),
        ],
      ),
    );
  }
}

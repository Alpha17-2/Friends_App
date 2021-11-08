import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class imageScreen extends StatelessWidget {
  final String? dpImage;
  final String? docId;
  final List<String>? images;

  imageScreen({this.dpImage, this.images,this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right:10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(dpImage!),
              radius: displayWidth(context) * 0.065,
            ),
          ),
        ],
        title: Text(
          'Snapshots',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700,fontSize: displayWidth(context)*0.062),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[300],
        child: Icon(Icons.add,color: Colors.white,),
        onPressed: () {
         
        },
        elevation: 5,
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        color: Colors.white,
      ),
    );
  }
}

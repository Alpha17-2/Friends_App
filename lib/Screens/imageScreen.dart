import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class imageScreen extends StatefulWidget {
  final String? dpImage;
  final String? docId;
  final List<dynamic>? images;

  imageScreen({this.dpImage, this.docId, this.images});

  @override
  State<imageScreen> createState() => _imageScreenState();
}

class _imageScreenState extends State<imageScreen> {
  User? currentUser;
  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser;
    super.initState();
  }

  final picker = ImagePicker();
  File? _imageFile;
  @override
  Widget build(BuildContext context) {
    final List<dynamic>? images =
        Provider.of<FriendsManager>(context).fetchImagesList(widget.docId!);
    Future pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (mounted) {
        setState(() {
          _imageFile = File(pickedFile!.path);
        });
      }
    }

    showImages(int index, BuildContext ctx) {
      return Container(
        //color: Colors.pink,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.network(
            images?[index],
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.dpImage!),
              radius: displayWidth(context) * 0.05,
            ),
          ),
        ],
        title: Text(
          'Snapshots',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
              fontSize: displayWidth(context) * 0.055),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange[300],
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          await pickImage().then((value) async {
            await Future.delayed(Duration(seconds: 1, microseconds: 5000))
                .then((value) {
                  showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: displayHeight(context) * 0.3,
                  color: Colors.white,
                  
                );
              },
            );
                });    
          });
        },
        elevation: 5,
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        color: Colors.white,
        child: (images!.length == 0)
            ? Center(
                child: Image.asset(
                  'images/bb.png',
                  fit: BoxFit.fitHeight,
                  height: displayHeight(context) * 0.3,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12),
                child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    return showImages(index, context);
                  },
                ),
              ),
      ),
    );
  }
}

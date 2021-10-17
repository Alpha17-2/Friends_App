import 'dart:io';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addFriendScreen extends StatefulWidget {
  @override
  State<addFriendScreen> createState() => _addFriendScreenState();
}

class _addFriendScreenState extends State<addFriendScreen> {
  TextEditingController about;
  TextEditingController dob;
  String dp;
  TextEditingController edu;
  TextEditingController gender;
  TextEditingController interest;
  bool isUploading;
  final picker = ImagePicker();
  TextEditingController profession;
  TextEditingController title;
  final _formKey = GlobalKey<FormState>();
  File _imageFile;

  @override
  void dispose() {
    title.dispose();
    about.dispose();
    edu.dispose();
    gender.dispose();
    profession.dispose();
    interest.dispose();
    dob.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = TextEditingController();
    about = TextEditingController();
    dob = TextEditingController();
    edu = TextEditingController();
    gender = TextEditingController();
    profession = TextEditingController();
    interest = TextEditingController();
    isUploading = false;
  }

  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (mounted) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    }

    dpExists() {
      return CircleAvatar(
        backgroundImage: FileImage(_imageFile),
        radius: displayWidth(context) * 0.2,
      );
    }

    dpNotExist() {
      return CircleAvatar(
        backgroundColor: Colors.grey[200],
        child: Icon(
          Icons.person,
          size: displayWidth(context) * 0.2,
          color: Colors.black38,
        ),
        radius: displayWidth(context) * 0.2,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "New Friend ",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.06,
                ),
              ),
            ),
            Opacity(
                opacity: 0,
                child: Divider(
                  height: displayHeight(context) * 0.03,
                )),
            Center(
                child: GestureDetector(
                    onTap: () => pickImage,
                    child: (_imageFile != null) ? dpExists() : dpNotExist())),
            Opacity(
                opacity: 0,
                child: Divider(
                  height: displayHeight(context) * 0.03,
                )),
            Text(
              'Basic Detail',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: displayWidth(context) * 0.045,
              ),
            ),
            Opacity(
                opacity: 0,
                child: Divider(
                  height: displayHeight(context) * 0.02,
                )),
            Text(
              'Full Name',
              style: TextStyle(color: Colors.black),
            ),
            Opacity(
                opacity: 0,
                child: Divider(
                  height: displayHeight(context) * 0.01,
                )),
            Container(
              height: displayHeight(context) * 0.06,
              width: displayWidth(context),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey,width: 1.1)),
              child: Padding(
                padding: const EdgeInsets.only(top:10.0,left: 8.0,right: 8.0,bottom: 4.0),
                child: Center(
                  child: TextFormField(
                    validator: (value) {
                      if(value.isEmpty || value.length==0) return 'Cannot be empty';
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Friend\'s name',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

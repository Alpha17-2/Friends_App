import 'dart:io';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ionicons/ionicons.dart';

class addFriendScreen extends StatefulWidget {
  @override
  State<addFriendScreen> createState() => _addFriendScreenState();
}

class _addFriendScreenState extends State<addFriendScreen> {
  bool isMale = true;
  TextEditingController about;
  TextEditingController dob;
  TextEditingController edu;
  String gender;
  TextEditingController interest;
  TextEditingController instagram;
  TextEditingController linkedin;
  TextEditingController phone;
  TextEditingController facebook;
  TextEditingController email;
  TextEditingController youtube;
  TextEditingController snapchat;
  TextEditingController profession;
  TextEditingController twiiter;

  bool isUploading;
  final picker = ImagePicker();
  TextEditingController title;
  final _formKey = GlobalKey<FormState>();
  File _imageFile;

  @override
  void dispose() {
    twiiter.dispose();
    title.dispose();
    about.dispose();
    edu.dispose();
    profession.dispose();
    interest.dispose();
    dob.dispose();
    phone.dispose();
    email.dispose();
    instagram.dispose();
    snapchat.dispose();
    youtube.dispose();

    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = TextEditingController();
    title = TextEditingController();
    about = TextEditingController();
    dob = TextEditingController();
    edu = TextEditingController();
    instagram = TextEditingController();
    youtube = TextEditingController();
    facebook = TextEditingController();
    snapchat = TextEditingController();
    interest = TextEditingController();
    profession = TextEditingController();
    email = TextEditingController();
    twiiter = TextEditingController();
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
      padding:
          const EdgeInsets.only(top: 12.0, left: 10, right: 10, bottom: 10),
      child: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                          child: (_imageFile != null)
                              ? dpExists()
                              : dpNotExist())),
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: title,
                          validator: (value) {
                            if (value.isEmpty || value.length == 0)
                              return 'Cannot be empty';
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
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Text(
                    'Date of birth',
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: dob,
                          keyboardType: TextInputType.datetime,
                          validator: (value) {
                            if (value.isEmpty || value.length == 0)
                              return 'Cannot be empty';
                            else {
                              bool validDate =
                                  RegExp(r"^(0[1-9]|[12][0-9]|3[01])[- /.]")
                                      .hasMatch(value);
                              if (!validDate) return 'Please fill correct date';
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'dd/mm/yyyy',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Text(
                    'Gender',
                    style: TextStyle(color: Colors.black),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.01,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: displayHeight(context) * 0.06,
                        width: displayWidth(context) * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey[300])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isMale,
                              onChanged: (value) {
                                setState(() {
                                  if (!isMale) {
                                    isMale = !isMale;
                                    gender = "Male";
                                  }
                                });
                              },
                            ),
                            Text(
                              'Male',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: displayHeight(context) * 0.06,
                        width: displayWidth(context) * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey[300])),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: !isMale,
                              onChanged: (value) {
                                setState(() {
                                  if (isMale) {
                                    isMale = !isMale;
                                    gender = "Female";
                                  }
                                });
                              },
                            ),
                            Text(
                              'Female',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Text(
                    'Education',
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: edu,
                          validator: (value) {
                            if (value.isEmpty || value.length == 0)
                              return 'Cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'School or University name',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Text(
                    'Profession',
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: profession,
                          validator: (value) {
                            if (value.isEmpty || value.length == 0)
                              return 'Cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Student , Engineer , Doctor ..',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Text(
                    'About',
                    style: TextStyle(color: Colors.black),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.01,
                      )),
                  Container(
                    height: displayHeight(context) * 0.15,
                    width: displayWidth(context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: TextFormField(
                        controller: about,
                        maxLines: 10,
                        validator: (value) {
                          if (value.isEmpty || value.length == 0)
                            return 'Cannot be empty';
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Tell us about your new friend',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Text(
                    'Interests',
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: interest,
                          validator: (value) {
                            if (value.isEmpty || value.length == 0)
                              return 'Cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Cricket , Dance ... (Separate interests using \',\') ',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: Divider(
                      height: displayHeight(context) * 0.03,
                    ),
                  ),
                  Text(
                    'Contact Detail',
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
                    'Mobile Number',
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.length != 10)
                              return 'Mobile number should contain 10 digits';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter 10 digit number',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Text(
                    'Email Address',
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value.isEmpty ||
                                value == null ||
                                value.length == 0)
                              return 'Cannot be empty';
                            else {
                              bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value);
                              if (!emailValid)
                                return 'Provide valid email';
                              else
                                return null;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'friends@gmail.com',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: Divider(
                      height: displayHeight(context) * 0.03,
                    ),
                  ),
                  Text(
                    'Social Media',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.logo_facebook,
                        color: Colors.blue[700],
                      ),
                      Opacity(
                          child: VerticalDivider(
                            width: displayWidth(context) * 0.02,
                          ),
                          opacity: 0.0),
                      Text(
                        'Facebook',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: facebook,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty || value.length == 0)
                              return 'Cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Facebook ID',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.logo_instagram,
                        color: Colors.pinkAccent,
                      ),
                      Opacity(
                          child: VerticalDivider(
                            width: displayWidth(context) * 0.02,
                          ),
                          opacity: 0.0),
                      Text(
                        'Instagram',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: instagram,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Instagram ID',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.logo_twitter,
                        color: Colors.blue[700],
                      ),
                      Opacity(
                          child: VerticalDivider(
                            width: displayWidth(context) * 0.02,
                          ),
                          opacity: 0.0),
                      Text(
                        'Twitter',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: twiiter,
                          keyboardType: TextInputType.name,

                          decoration: InputDecoration(
                            hintText: 'Twitter ID',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Ionicons.logo_snapchat,
                        color: Colors.yellow[600],
                      ),
                      Opacity(
                          child: VerticalDivider(
                            width: displayWidth(context) * 0.02,
                          ),
                          opacity: 0.0),
                      Text(
                        'Snapchat',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: snapchat,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Twitter ID',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.02,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: displayWidth(context) * 0.033,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('images/yt.png'),
                      ),
                      Opacity(
                          child: VerticalDivider(
                            width: displayWidth(context) * 0.02,
                          ),
                          opacity: 0.0),
                      Text(
                        'Youtube',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
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
                        border: Border.all(color: Colors.grey, width: 1.1)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 14.0, left: 8.0, right: 8.0, bottom: 2.0),
                      child: Center(
                        child: TextFormField(
                          controller: youtube,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Youtube channel',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Opacity(
                      opacity: 0,
                      child: Divider(
                        height: displayHeight(context) * 0.01,
                      )),
                  Center(
                    child: TextButton(

                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.indigo[400])),
                        onPressed: () {

                    }, child: Text('Submit',style: TextStyle(
                      color: Colors.white
                    ),)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addFriendScreen extends StatefulWidget {
  @override
  State<addFriendScreen> createState() => _addFriendScreenState();
}

class _addFriendScreenState extends State<addFriendScreen> {
  bool isMale = true;
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
      padding: const EdgeInsets.only(top: 12.0, left: 10, right: 10, bottom: 10),
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
                          child:
                              (_imageFile != null) ? dpExists() : dpNotExist())),
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
                                  if (!isMale) isMale = !isMale;
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
                                  if (isMale) isMale = !isMale;
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
                        height: displayHeight(context) * 0.03,
                      )),
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
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty || value.length == 0)
                              return 'Cannot be empty';
                            else if (value.length != 10)
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

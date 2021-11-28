import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

class editFriendScreen extends StatefulWidget {
  final Friend? f;
  final String? docId;
  editFriendScreen({this.docId, this.f});
  @override
  State<editFriendScreen> createState() => _editFriendScreenState();
}

class _editFriendScreenState extends State<editFriendScreen> {
  Color? seletedColor = Colors.orange[300];
  Color? unselectedColor = Colors.blue[300];
  User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, String> listOfInterests = {};
  TextEditingController? about;

  TextEditingController? dob;
  TextEditingController? edu;
  TextEditingController? email;
  TextEditingController? facebook;
  String? gender;
  TextEditingController? instagram;
  TextEditingController? interest;
  bool isMale = true;
  String selectedCard = '';
  TextEditingController? school;
  TextEditingController? college;
  TextEditingController? workAt;
  late bool isUploading;
  bool seletedAnyInterestCard = false;
  TextEditingController? linkedin;
  TextEditingController? phone;
  final picker = ImagePicker();
  TextEditingController? profession;
  TextEditingController? snapchat;
  TextEditingController? title;
  TextEditingController? twiiter;
  TextEditingController? youtube;

  final _formKey = GlobalKey<FormState>();
  File? _imageFile;

  @override
  void dispose() {
    twiiter!.dispose();
    title!.dispose();
    about!.dispose();
    edu!.dispose();
    profession!.dispose();
    interest!.dispose();
    dob!.dispose();
    phone!.dispose();
    email!.dispose();
    instagram!.dispose();
    snapchat!.dispose();
    youtube!.dispose();

    super.dispose();
  }

  @override
  void initState() {
    List<dynamic>? initInterest = widget.f!.interests;
    print(initInterest);
    for (int i = 0; i < initInterest!.length; ++i) {
      listOfInterests[initInterest[i]] = initInterest[i];
    }
    isMale = widget.f!.gender == "Male" ? true : false;
    school = TextEditingController(text: widget.f!.school);
    college = TextEditingController(text: widget.f!.college);
    workAt = TextEditingController(text: widget.f!.work);
    interest = TextEditingController();
    phone = TextEditingController(text: widget.f!.contactNumber);
    title = TextEditingController(text: widget.f!.title);
    about = TextEditingController(text: widget.f!.about);
    dob = TextEditingController(text: widget.f!.dob);
    edu = TextEditingController(text: widget.f!.education);
    instagram = TextEditingController(text: widget.f!.instagram);
    youtube = TextEditingController(text: widget.f!.youtube);
    facebook = TextEditingController(text: widget.f!.facebook);
    snapchat = TextEditingController(text: widget.f!.snapchat);
    profession = TextEditingController(text: widget.f!.profession);
    email = TextEditingController(text: widget.f!.mail);
    twiiter = TextEditingController(text: widget.f!.twitter);
    isUploading = false;
    linkedin = TextEditingController(text: widget.f!.linkedin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (mounted) {
        setState(() {
          _imageFile = File(pickedFile!.path);
        });
      }
    }

    dpExists() {
      return CircleAvatar(
        backgroundImage: FileImage(_imageFile!),
        radius: displayWidth(context) * 0.18,
      );
    }

    dpNotExist() {
      return (widget.f!.dp!='')?CircleAvatar(
        backgroundImage: NetworkImage(widget.f!.dp!),
        radius: displayWidth(context) * 0.18,
      ):
      
      
      CircleAvatar(
        backgroundColor: Colors.grey[200],
        backgroundImage:
            AssetImage((isMale ? 'images/male.jpg' : 'images/female.jpg')),
        radius: displayWidth(context) * 0.18,
      );
    }

    Future<void> addInterestInDialogBox() async {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: Text("Add more interests"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('What is your friend interested in ?'),
                  Opacity(
                    child: Divider(),
                    opacity: 0,
                  ),
                  Container(
                    height: displayHeight(context) * 0.06,
                    width: displayWidth(context) * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: interest,
                        toolbarOptions: ToolbarOptions(
                            copy: true,
                            cut: true,
                            selectAll: true,
                            paste: true),
                        autofocus: false,
                        decoration: InputDecoration(
                          hintText: "Dance , Music , etc ...",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        showCursor: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close',
                      style: TextStyle(
                          color: Colors.red[300],
                          fontWeight: FontWeight.bold))),
              TextButton(
                onPressed: () {
                  setState(() {
                    print(interest!.text.toString());
                    listOfInterests[interest!.text.toString()] =
                        interest!.text.toString();
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Done',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(3),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.orange[300])),
              ),
            ],
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          );
        },
      );
    }

    void addThisInterestToList(String itr) {
      print(itr);
      setState(() {
        listOfInterests[itr] = itr;
      });
      print(listOfInterests);
    }

    void removeThisInterstFromList(String itr) {
      setState(() {
        listOfInterests.remove(itr);
      });
      print(listOfInterests);
    }

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          actions: [
            (seletedAnyInterestCard)
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        listOfInterests.remove(selectedCard);
                        selectedCard = '';
                        seletedAnyInterestCard = false;
                      });
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.redAccent)
                : TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isUploading = true;
                        });
                        Provider.of<FriendsManager>(context, listen: false)
                            .editFriendDetail(
                                _imageFile,
                                currentUser!.uid.toString(),
                                widget.f!.docId!,
                                Friend(
                                  college: college!.text.toString(),
                                  school: school!.text.toString(),
                                  work: workAt!.text.toString(),
                                  about: about!.text.toString(),
                                  contactNumber: phone!.text.toString(),
                                  dob: dob!.text.toString(),
                                  docId: '',
                                  dp: widget.f!.dp,
                                  isBestFriend: widget.f!.isBestFriend,
                                  isCloseFriend: widget.f!.isCloseFriend,
                                  education: edu!.text.toString(),
                                  facebook: facebook!.text.toString(),
                                  gender: (isMale) ? "Male" : "Female",
                                  instagram: instagram!.text.toString(),
                                  interests: listOfInterests.keys.toList(),
                                  linkedin: linkedin!.text.toString(),
                                  mail: email!.text.toString(),
                                  profession: profession!.text.toString(),
                                  snapchat: snapchat!.text.toString(),
                                  title: title!.text.toString(),
                                  twitter: twiiter!.text.toString(),
                                  youtube: youtube!.text.toString(),
                                ))
                            .then((value) {
                          setState(() {
                            isUploading = false;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Successfully updated details")));
                          });
                        });
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: Colors.indigoAccent,
                          fontSize: displayWidth(context) * 0.045),
                    )),
          ],
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          title: Text(
            'Edit Friend',
            style: TextStyle(color: Colors.black, letterSpacing: 0.5),
          ),
        ),
        body: Container(
            height: displayHeight(context),
            width: displayWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, left: 10, right: 10, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: (isUploading)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: (_imageFile != null)
                                        ? dpExists()
                                        : dpNotExist()),
                                Opacity(
                                    opacity: 0,
                                    child: Divider(
                                      height: displayHeight(context) * 0.015,
                                    )),
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Display Picture',
                                          style: TextStyle(
                                              color: Colors.indigoAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: displayWidth(context) *
                                                  0.04)),
                                      IconButton(
                                          onPressed: () {
                                            pickImage();
                                          },
                                          icon: Icon(Icons.add_a_photo_outlined,
                                              color: Colors.orange[400])),
                                    ],
                                  ),
                                ),
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
                                    fontSize: displayWidth(context) * 0.04,
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: title,
                                        validator: (value) {
                                          if (value!.isEmpty ||
                                              value.length == 0)
                                            return 'Cannot be empty';
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        readOnly: true,
                                        controller: dob,
                                        onTap: () async {
                                          DateTime? pickedDate =
                                              await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(
                                                      2000), //DateTime.now() - not to allow to choose before today.
                                                  lastDate: DateTime(2101));

                                          if (pickedDate != null) {
                                            print(
                                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                            String formattedDate =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(pickedDate);
                                            print(
                                                formattedDate); //formatted date output using intl package =>  2021-03-16
                                            //you can implement different kind of Date Format here according to your requirement

                                            setState(() {
                                              dob!.text =
                                                  formattedDate; //set output date to TextField value.
                                            });
                                          } else {
                                            print("Date is not selected");
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: displayHeight(context) * 0.05,
                                      width: displayWidth(context) * 0.35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey[300]!)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            style: TextStyle(
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.035,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: displayHeight(context) * 0.05,
                                      width: displayWidth(context) * 0.35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.grey[300]!)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                            style: TextStyle(
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.035,
                                                fontWeight: FontWeight.w600),
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
                                  'School',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Opacity(
                                    opacity: 0,
                                    child: Divider(
                                      height: displayHeight(context) * 0.01,
                                    )),
                                Container(
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: school,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
                                          hintText: 'School\'s name',
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
                                  'College',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Opacity(
                                    opacity: 0,
                                    child: Divider(
                                      height: displayHeight(context) * 0.01,
                                    )),
                                Container(
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: college,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
                                          hintText: 'College name',
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
                                  'Highest Qualification',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Opacity(
                                    opacity: 0,
                                    child: Divider(
                                      height: displayHeight(context) * 0.01,
                                    )),
                                Container(
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: edu,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: profession,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
                                          hintText:
                                              'Student , Engineer , Doctor ..',
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
                                  'Work at',
                                  style: TextStyle(color: Colors.black),
                                ),
                                Opacity(
                                    opacity: 0,
                                    child: Divider(
                                      height: displayHeight(context) * 0.01,
                                    )),
                                Container(
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: workAt,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
                                          hintText:
                                              'Company or organisation name',
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
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextFormField(
                                      controller: about,
                                      maxLines: 10,
                                      validator: (value) {
                                        if (value!.isEmpty || value.length == 0)
                                          return 'Cannot be empty';
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintStyle: TextStyle(
                                            fontSize:
                                                displayWidth(context) * 0.04),
                                        hintText:
                                            'Tell us about your new friend',
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: phone,
                                        keyboardType: TextInputType.phone,
                                        validator: (value) {
                                          if (value!.length == 0)
                                            return null;
                                          else if (value.length != 10)
                                            return 'Mobile number should contain 10 digits';
                                          else
                                            return null;
                                        },
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: email,
                                        validator: (value) {
                                          if (value == '')
                                            return null;
                                          else {
                                            bool emailValid = RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(value!);
                                            if (!emailValid)
                                              return 'Provide valid email';
                                            else
                                              return null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: facebook,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: instagram,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintText: 'Instagram ID',
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: twiiter,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                      Ionicons.logo_linkedin,
                                      color: Colors.blue[600],
                                    ),
                                    Opacity(
                                        child: VerticalDivider(
                                          width: displayWidth(context) * 0.02,
                                        ),
                                        opacity: 0.0),
                                    Text(
                                      'Linkedin',
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: linkedin,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
                                          hintText: 'Linkedin ID',
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
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: snapchat,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                      backgroundImage:
                                          AssetImage('images/yt.png'),
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
                                  ),
                                ),
                                Container(
                                  height: displayHeight(context) * 0.05,
                                  width: displayWidth(context),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 2.0),
                                    child: Center(
                                      child: TextFormField(
                                        controller: youtube,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  displayWidth(context) * 0.04),
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
                                      height: displayHeight(context) * 0.02,
                                    )),
                                Text(
                                  'Interests',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: displayWidth(context) * 0.045,
                                  ),
                                ),
                                Opacity(
                                    opacity: 0,
                                    child: Divider(
                                      height: displayHeight(context) * 0.01,
                                    )),
                                Container(
                                  height: displayHeight(context) * 0.06,
                                  width: displayWidth(context),
                                  // color: Colors.red,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            addInterestInDialogBox();
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          )),
                                      Container(
                                        height: displayHeight(context) * 0.045,
                                        width: displayWidth(context) * 0.72,
                                        //color: Colors.red,
                                        child: Center(
                                          child: (listOfInterests.length != 0)
                                              ? ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: listOfInterests
                                                      .keys
                                                      .toList()
                                                      .length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onLongPress: () {
                                                        setState(() {
                                                          if (!seletedAnyInterestCard) {
                                                            selectedCard =
                                                                listOfInterests
                                                                    .keys
                                                                    .toList()[
                                                                        index]
                                                                    .toString();
                                                            seletedAnyInterestCard =
                                                                true;
                                                          }
                                                        });
                                                      },
                                                      child: Card(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                        color:
                                                            (seletedAnyInterestCard)
                                                                ? Colors
                                                                    .grey[300]
                                                                : Colors
                                                                    .teal[300],
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child: Text(
                                                              listOfInterests
                                                                  .keys
                                                                  .toList()[
                                                                      index]
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: (seletedAnyInterestCard)
                                                                      ? Colors
                                                                          .black
                                                                      : Colors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Text('No interests'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ))));
  }
}

import 'dart:math';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Profile.dart';
import 'package:firstapp/Providers/ProfileProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class homeScreen extends StatefulWidget {
  //const homeScreen({Key? key}) : super(key: key);
  @override
  _homeScreenState createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool isScreenLoading;

  @override
  void initState() {
    isScreenLoading = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await Provider.of<ProfileProvider>(context).fetchAndSetData().then((value) {
      isScreenLoading = false;
    });
    super.didChangeDependencies();
  }

  final _profileFormKey = GlobalKey<FormState>();

  TextEditingController nameControlller = new TextEditingController();

  TextEditingController sexControlller = new TextEditingController();

  TextEditingController ageControlller = new TextEditingController();

  TextEditingController phoneControlller = new TextEditingController();

  TextEditingController eduControlller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    profileBuilder(BuildContext context) {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Form(
                key: _profileFormKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Create a New Profile",
                          style: TextStyle(
                              color: Color(0xfb124568),
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Opacity(opacity: 0, child: Divider()),
                        TextFormField(
                          controller: nameControlller,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This field cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Your name",
                            labelText: "Name",
                          ),
                        ),
                        TextFormField(
                          controller: ageControlller,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This field cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Your age",
                            labelText: "Age",
                          ),
                        ),
                        TextFormField(
                          controller: sexControlller,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This field cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Your sex",
                            labelText: "Sex",
                          ),
                        ),
                        TextFormField(
                          controller: eduControlller,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'This field cannot be empty';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Your education",
                            labelText: "Education",
                          ),
                        ),
                        TextFormField(
                          controller: phoneControlller,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Field cannot be empty';
                            else if (value.length != 10)
                              return 'Phone number should have 10 digits';
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Number",
                            labelText: "Contact Number",
                          ),
                        ),
                        Opacity(opacity: 0, child: Divider()),
                        TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xfb124568))),
                            onPressed: () {
                              Random random = Random();
                              int number = random.nextInt(100000);
                              String id = number.toString();
                              if (_profileFormKey.currentState.validate()) {
                                Provider.of<ProfileProvider>(context,
                                        listen: false)
                                    .addProfile(Profile(
                                  age: ageControlller.text.toString(),
                                  edu: eduControlller.text.toString(),
                                  sex: sexControlller.text.toString(),
                                  name: nameControlller.text.toString(),
                                  phone_number:
                                      phoneControlller.text.toString(),
                                  id: id,
                                ));
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )),
                      ],
                    ),
                  ),
                )),
          );
        },
      );
    }

    List<Profile> displayListOfFriends =
        Provider.of<ProfileProvider>(context).fetchListOfProfiles;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfb124568),
        title: Text(
          'Friends',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.add), onPressed: () => profileBuilder(context)),
          IconButton(
            icon: Icon(Icons.alarm),
            onPressed: () => print('Button Clicked'),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: (isScreenLoading)
        ? Center(
          child: CircularProgressIndicator(),
        )
        : (displayListOfFriends.length == 0)
            ? Center(
                child: Text(
                  'Ooops !! Its seems you are an introvert',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: displayListOfFriends.length,
                itemBuilder: (context, index) {
                  return displayListTileForFriends(
                      context, displayListOfFriends[index]);
                },
              ),
      ),
    );
  }
}

displayListTileForFriends(BuildContext context, Profile profile) {
  return GestureDetector(
    onTap: () {
      Provider.of<ProfileProvider>(context, listen: false)
          .deleteProfile(profile);
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white24, borderRadius: BorderRadius.circular(10)),
          height: displayHeight(context) * 0.1,
          width: displayWidth(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // This widget displays the profile picture (Icons.person if DP not found)
              Positioned(
                  left: displayWidth(context) * 0.04,
                  child: CircleAvatar(
                    radius: displayWidth(context) * 0.06,
                    backgroundColor: Colors.indigo[200],
                    child: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  )),

              // This widget displays the profile name
              Positioned(
                  top: displayHeight(context) * 0.015,
                  child: Text(
                    profile.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: displayWidth(context) * 0.04,
                        fontWeight: FontWeight.bold),
                  )),

              Positioned(
                  left: displayWidth(context) * 0.32,
                  bottom: displayHeight(context) * 0.02,
                  child: Text(
                    '${profile.age} Y/O',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: displayWidth(context) * 0.035,
                        fontWeight: FontWeight.w500),
                  )),
              Positioned(
                  right: displayWidth(context) * 0.32,
                  bottom: displayHeight(context) * 0.02,
                  child: Text(
                    profile.sex,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: displayWidth(context) * 0.035,
                        fontWeight: FontWeight.w500),
                  )),
              Positioned(
                  right: displayWidth(context) * 0.04,
                  //bottom: displayHeight(context)*0.02,
                  child: IconButton(
                    onPressed: () => print('Navigate to detail screen'),
                    icon: Icon(
                      Icons.forward,
                      color: Colors.teal[600],
                      size: displayWidth(context) * 0.1,
                    ),
                  )),
            ],
          ),
        ),
      ),
    ),
  );
}

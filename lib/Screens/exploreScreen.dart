import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/Friend.dart';
import 'package:firstapp/Models/quote.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:firstapp/Providers/QuoteProvider.dart';
import 'package:firstapp/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'friendDetailScreen.dart';

class exploreScreen extends StatefulWidget {
  //const exploreScreen({Key? key}) : super(key: key);
  @override
  State<exploreScreen> createState() => _exploreScreenState();
}

class _exploreScreenState extends State<exploreScreen> {
  Random random = Random();

  final authservice _auth = authservice(FirebaseAuth.instance);

  User? currentUser = FirebaseAuth.instance.currentUser;

  final _keyForm = GlobalKey<FormState>();

  bool isFriedsLoading = true;

  List<Friend> bestFriends = [];

  bool init = true;

  TextEditingController displayNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (init) {
      Provider.of<FriendsManager>(context)
          .setFriends(currentUser!.uid)
          .then((value) {
        isFriedsLoading = false;
      });
      init = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<quoteModel> quotes = QuoteProvider().fetchQuotesList;
    bestFriends = Provider.of<FriendsManager>(context)
        .fetchList
        .where((element) => element.isBestFriend!)
        .toList();
    final randomInddex = random.nextInt(quotes.length);
    displayBestFriends(BuildContext context, Friend f) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => friendDetailScreen(
                      friend: f,
                    ),
                  ));
            },
            child: Hero(
              tag: f.docId!,
              child: (f.dp != '')
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(f.dp!),
                      radius: displayWidth(context) * 0.072,
                    )
                  : CircleAvatar(
                      radius: displayWidth(context) * 0.072,
                      backgroundImage: AssetImage((f.gender == 'Male')
                          ? 'images/male.jpg'
                          : 'images/female.jpg'),
                    ),
            ),
          ),
          Opacity(
            child: Divider(
              height: displayHeight(context)*0.0065,
            ),
            opacity: 0.0,
          ),
          Text(
            f.title!,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black87,
                fontSize: displayWidth(context) * 0.0335,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1),
          ),
        ],
      );
    }

    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                height: displayHeight(context) * 0.5,
                width: displayWidth(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/bg2.jpg'), fit: BoxFit.cover),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    height: displayHeight(context) * 0.5,
                    width: displayWidth(context),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10, top: 45, bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                radius: displayWidth(context) * 0.06,
                                backgroundColor: Colors.grey[300],
                                child: Center(
                                  child: IconButton(
                                      onPressed: () {
                                        _auth.signOut();
                                      },
                                      icon: Icon(Icons.logout_outlined),
                                      color: Colors.black,
                                      iconSize: displayWidth(context) * 0.055),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        elevation: 10,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        title: Text('Change display name'),
                                        content: Form(
                                          key: _keyForm,
                                          child: TextFormField(
                                            controller: displayNameController,
                                            validator: (value) {
                                              if (value!.isEmpty)
                                                return 'Cannot be empty';
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              hintText:
                                                  currentUser!.displayName,
                                              labelText: 'Display name',
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                _auth
                                                    .changeDisplayName(
                                                        displayNameController
                                                            .text
                                                            .toString())
                                                    .then((value) {
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Text('Submit'))
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: CircleAvatar(
                                  radius: displayWidth(context) * 0.06,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage:
                                      AssetImage('images/friendsIcon2.png'),
                                ),
                              )
                            ],
                          ),
                          Opacity(opacity: 0.0, child: Divider()),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Welcome,',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: displayWidth(context) * 0.05,
                                ),
                              ),
                              Text(
                                currentUser!.displayName!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: displayWidth(context) * 0.07,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Opacity(
                            child: Divider(),
                            opacity: 0.0,
                          ),
                          Opacity(
                            child: Divider(),
                            opacity: 0.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            Opacity(opacity: 0.0, child: Divider()),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                'Best Friends',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.055,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: displayHeight(context) * 0.14,
                width: displayWidth(context),
                child: (bestFriends.length == 0)
                    ? Center(
                        child: Text(
                          'No friends to display',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: displayBestFriends(
                                    context, bestFriends[index]),
                              );
                            },
                            itemCount: bestFriends.length,
                            scrollDirection: Axis.horizontal,
                          ),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text(
                quotes[randomInddex].quote!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: 'Kalam',
                  wordSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.058,
                ),
              ),
            ),
            Opacity(opacity: 0.0, child: Divider()),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '- ${quotes[randomInddex].author}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                      fontSize: displayWidth(context) * 0.04,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Models/quote.dart';
import 'package:firstapp/Providers/QuoteProvider.dart';
import 'package:firstapp/Services/auth.dart';
import 'package:flutter/material.dart';

class exploreScreen extends StatelessWidget {
  //const exploreScreen({Key? key}) : super(key: key);
  Random random = Random();
  final authservice _auth = authservice(FirebaseAuth.instance);
  User? currentUser = FirebaseAuth.instance.currentUser;
  final _keyForm = GlobalKey<FormState>();
  TextEditingController displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<quoteModel> quotes = QuoteProvider().fetchQuotesList;

    final randomInddex = random.nextInt(quotes.length);
    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: displayHeight(context) * 0.45,
              width: displayWidth(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/bg2.jpg'), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  height: displayHeight(context) * 0.45,
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
                                            hintText: currentUser!.displayName,
                                            labelText: 'Display name',
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              _auth
                                                  .changeDisplayName(
                                                      displayNameController.text
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
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Best Friends',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: displayWidth(context) * 0.05,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Text(
              quotes[randomInddex].quote!,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Dancing',
                wordSpacing: 2.2,
                fontWeight: FontWeight.w500,
                fontSize: displayWidth(context) * 0.062,
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
    );
  }
}

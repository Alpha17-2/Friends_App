import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/AuthOptions.dart';
import 'package:firstapp/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class authScreen extends StatefulWidget {
  //const authScreen({Key? key}) : super(key: key);

  @override
  State<authScreen> createState() => _authScreenState();
}

class _authScreenState extends State<authScreen> {
  late bool isLoading;

  final _authFormKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController displayName = TextEditingController();

  TextEditingController password = TextEditingController();

  final authservice _auth = authservice(FirebaseAuth.instance);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    bool loginState = Provider.of<AuthOptions>(context).fetchLoginState;
    bool viewPass = Provider.of<AuthOptions>(context).fetchObscureTextInfo;
    Container loginBox() {
      return Container(
        height: displayHeight(context) * 0.158,
        width: displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: displayHeight(context) * 0.062,
              width: displayWidth(context) * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null || value.length == 0)
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

                  controller: email,
                  //autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Email ID",
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

            Opacity(
              opacity: 0.0,
              child: Divider(
                height: displayHeight(context) * 0.02,
              ),
            ),

            // Password box
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: displayHeight(context) * 0.062,
              width: displayWidth(context) * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  toolbarOptions: ToolbarOptions(
                      copy: true, cut: true, selectAll: true, paste: true),
                  controller: password,
                  autofocus: false,
                  obscureText: !viewPass,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewPass ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Provider.of<AuthOptions>(context, listen: false)
                            .viewPassword();
                      },
                    ),
                    hintText: "Password",
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
      );
    }

    Container signUpBox() {
      return Container(
        height: displayHeight(context) * 0.21,
        width: displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: displayHeight(context) * 0.058,
              width: displayWidth(context) * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null || value.length == 0)
                      return 'Cannot be empty';
                    else {
                      return null;
                    }
                  },

                  controller: displayName,
                  //autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Display name",
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
            Opacity(
              opacity: 0.0,
              child: Divider(
                height: displayHeight(context) * 0.015,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: displayHeight(context) * 0.058,
              width: displayWidth(context) * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || value == null || value.length == 0)
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

                  controller: email,
                  //autofocus: false,
                  decoration: InputDecoration(
                    hintText: "Email ID",
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

            Opacity(
              opacity: 0.0,
              child: Divider(
                height: displayHeight(context) * 0.015,
              ),
            ),

            // Password box
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: displayHeight(context) * 0.058,
              width: displayWidth(context) * 0.7,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextFormField(
                  toolbarOptions: ToolbarOptions(
                      copy: true, cut: true, selectAll: true, paste: true),
                  controller: password,
                  autofocus: false,
                  obscureText: !viewPass,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewPass ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Provider.of<AuthOptions>(context, listen: false)
                            .viewPassword();
                      },
                    ),
                    hintText: "Password",
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
      );
    }

    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/auth.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 12,
                  child: Container(
                    height: displayHeight(context) * 0.85,
                    width: displayWidth(context) * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              "Meet my friends",
                              style: TextStyle(
                                color: Colors.teal,
                                fontSize: displayWidth(context) * 0.08,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kaushan',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10.0, left: 4, right: 4),
                            child: Text(
                              'Distance means so little, when someone means so much .',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: displayWidth(context) * 0.04,
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/friends.png',
                            height: displayHeight(context) * 0.25,
                            width: displayWidth(context) * 0.4,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            height: displayHeight(context) * 0.4,
                            width: displayWidth(context) * 0.78,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  width: 2.5,
                                  color: Colors.teal,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Form(
                                key: _authFormKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              if (!loginState) {
                                                Provider.of<AuthOptions>(
                                                        context,
                                                        listen: false)
                                                    .toggle();
                                              }
                                            },
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: loginState
                                                    ? Colors.indigo
                                                    : Colors.black45,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                        SizedBox(
                                          width: displayWidth(context) * 0.08,
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              if (loginState) {
                                                Provider.of<AuthOptions>(
                                                        context,
                                                        listen: false)
                                                    .toggle();
                                              }
                                            },
                                            child: Text(
                                              "Signup",
                                              style: TextStyle(
                                                color: loginState
                                                    ? Colors.black45
                                                    : Colors.indigo,
                                                fontSize:
                                                    displayWidth(context) *
                                                        0.05,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                    ),
                                    Opacity(
                                      child: Divider(
                                        height: displayHeight(context)*0.01,
                                      ),
                                      opacity: 0.0,
                                    ),
                                   loginState?loginBox():signUpBox(),
                                    Opacity(
                                      child: Divider(
                                        height: displayHeight(context) * 0.03,
                                      ),
                                      opacity: 0.0,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        if (loginState) {
                                          // User trying to login !!
                                          dynamic currentUser =
                                              await _auth.signIn(
                                                  email: email.text.toString(),
                                                  password:
                                                      password.text.toString());
                                          print(currentUser.toString());
                                          if (currentUser.toString() !=
                                              'valid') {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      content: Text(currentUser
                                                          .toString()),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                "Try again"))
                                                      ],
                                                    ));
                                          }
                                        } else {
                                          // User trying to sign-up
                                          dynamic currentUser =
                                              await _auth.signUp(
                                                displayName: displayName.text.toString(),
                                                  email: email.text.toString(),
                                                  password:
                                                      password.text.toString());
                                          if (currentUser.toString() !=
                                              'valid') {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      content: Text(currentUser
                                                          .toString()),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                                "Try again"))
                                                      ],
                                                    ));
                                          }
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        height: displayHeight(context) * 0.05,
                                        width: displayWidth(context) * 0.35,
                                        child: isLoading
                                            ? SpinKitHourGlass(
                                                color: Colors.white,
                                                size: displayWidth(context) *
                                                    0.06,
                                              )
                                            : Center(
                                                child: Text(
                                                loginState
                                                    ? "LOGIN"
                                                    : "REGISTER",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.04),
                                              )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

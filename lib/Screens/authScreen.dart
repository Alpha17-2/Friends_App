import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Providers/AuthOptions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class authScreen extends StatelessWidget {
  //const authScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool loginState = Provider.of<AuthOptions>(context).fetchLoginState;
    return Scaffold(
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/auth'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
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
                  height: displayHeight(context) * 0.8,
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
                          height: displayHeight(context) * 0.35,
                          width: displayWidth(context) * 0.7,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                width: 2.5,
                                color: Colors.teal,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          if (!loginState) {
                                            Provider.of<AuthOptions>(context,
                                                    listen: false)
                                                .change();
                                          }
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            color: loginState
                                                ? Colors.indigo
                                                : Colors.black45,
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                    SizedBox(
                                      width: displayWidth(context) * 0.08,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          if (loginState) {
                                            Provider.of<AuthOptions>(context,
                                                    listen: false)
                                                .change();
                                          }
                                        },
                                        child: Text(
                                          "Signup",
                                          style: TextStyle(
                                            color: loginState
                                                ? Colors.black45
                                                : Colors.indigo,
                                            fontSize:
                                                displayWidth(context) * 0.05,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ],
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
    );
  }
}

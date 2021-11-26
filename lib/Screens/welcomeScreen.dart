import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstapp/Helpers/custom_paint.dart';
import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:firstapp/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class welcomeScreen extends StatelessWidget {
  final authservice _auth = authservice(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // title: CircleAvatar(backgroundImage: AssetImage('images/logo.png'),backgroundColor: Colors.white,radius: displayWidth(context)*0.08,),
        elevation: 0,
        backgroundColor: Colors.orange[600],
      ),
      body: Container(
        height: displayHeight(context),
        width: displayWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomPaint(
              child: Container(
                height: displayHeight(context) * 0.08,
                width: displayWidth(context),
              ),
              painter: CurvePainter(),
            ),
            Opacity(opacity: 0.0, child: Divider()),
            Opacity(opacity: 0.0, child: Divider()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'We are elated to have you with us.\nTo make the most out of the benefits of the app, kindly follow the simple steps in their respective order.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.05,
                ),
              ),
            ),
            Opacity(opacity: 0.0, child: Divider()),
            Opacity(opacity: 0.0, child: Divider()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: displayWidth(context) * 0.04,
                    backgroundColor: Colors.indigo,
                    child: Center(
                      child: Text(
                        '1',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.04,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verify your email address',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: displayWidth(context) * 0.04,
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.005,
                        ),
                        Text(
                          'We have sent you an email containing the verifying link.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: displayWidth(context) * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Opacity(opacity: 0.0, child: Divider()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: displayWidth(context) * 0.04,
                    backgroundColor: Colors.indigo,
                    child: Center(
                      child: Text(
                        '2',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: displayWidth(context) * 0.04,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: displayWidth(context) * 0.04,
                          ),
                        ),
                        SizedBox(
                          height: displayHeight(context) * 0.005,
                        ),
                        Text(
                          'Logout and login after following the first step.',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: displayWidth(context) * 0.04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Opacity(opacity: 0.0, child: Divider()),
            Opacity(opacity: 0.0, child: Divider()),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo)),
                onPressed: () => _auth.signOut(),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: displayWidth(context) * 0.045,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

import 'package:firstapp/Helpers/deviceSize.dart';
import 'package:flutter/material.dart';

class authScreen extends StatelessWidget {
  //const authScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              Image.asset(
                'images/friends.png',
                height: displayHeight(context) * 0.3,
                width: displayWidth(context) * 0.6,
                fit: BoxFit.cover,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 12,
                child: Container(
                  height: displayHeight(context) * 0.6,
                  width: displayWidth(context) * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [],
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

import 'package:firstapp/Providers/ProfileProvider.dart';
import 'package:firstapp/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => ProfileProvider(),)
    ],
    child: MaterialApp(
        home: homeScreen(),
      ),
    );
  }
}



import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Providers/AuthOptions.dart';
import 'package:firstapp/Providers/ProfileProvider.dart';
import 'package:firstapp/Screens/authScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => AuthOptions(),),
      ChangeNotifierProvider(create: (context) => ProfileProvider(),)
    ],
    child: MaterialApp(
       debugShowCheckedModeBanner: false,
        home: authScreen(),
      ),
    );
  }
}



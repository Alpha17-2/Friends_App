import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firstapp/Providers/AuthOptions.dart';
import 'package:firstapp/Providers/FriendsManager.dart';
import 'package:firstapp/Providers/screenIndexProvider.dart';
import 'package:firstapp/Screens/authScreen.dart';
import 'package:firstapp/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Services/auth.dart';
import 'Services/auth_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => screenIndexProvider(),),
          ChangeNotifierProvider(
            create: (context) => AuthNotifier(),
          ),
          ChangeNotifierProvider(create :(context) => FriendsManager(),),
          Provider<authservice>(
              create: (_) => authservice(FirebaseAuth.instance)),

          // ignore: missing_required_param
          StreamProvider(
              create: (context) =>
                  context.read<authservice>().austhStateChanges),
          ChangeNotifierProvider(
            create: (context) => AuthOptions(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Consumer<AuthNotifier>(
              builder: (context, notifier, child) {
                return notifier.user != null ? homeScreen() : wrapper();
              },
            )));
  }
}

class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return homeScreen();
    } else
      return authScreen();
  }
}

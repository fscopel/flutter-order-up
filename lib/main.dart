import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_order_up/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;

  runApp(MainApp(auth: auth));
}

class MainApp extends StatelessWidget {
  final FirebaseAuth auth;
  bool isUserSignedin = false;
  MainApp({required this.auth, Key? key}) : super(key: key) {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        isUserSignedin = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red[900]),
      title: 'OrderUp!',
      initialRoute: isUserSignedin ? '/homepage' : '/loginscreen',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/loginscreen': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/homepage': (context) => HomePage(),
      },
    );
  }
}

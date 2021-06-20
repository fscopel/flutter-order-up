import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_order_up/screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isUserSignedIn = false;

  _MainAppState() {
    isUserSignedIn = FirebaseAuth.instance.currentUser != null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.red[900]),
      title: 'OrderUp!',
      initialRoute: isUserSignedIn ? '/homepage' : '/loginscreen',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/loginscreen': (context) => LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/homepage': (context) => HomePage(),
      },
    );
  }
}

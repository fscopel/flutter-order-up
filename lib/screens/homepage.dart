import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_order_up/screens/login.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) return LoginScreen();

    return Scaffold(
        appBar: AppBar(title: Text('Welcome to OrderUp!')),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Welcome to OrderUp! - ${user.displayName}')),
              ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/loginscreen', (Route<dynamic> route) => false);
                  },
                  child: Text('Log out'))
            ],
          ),
        ));
  }
}

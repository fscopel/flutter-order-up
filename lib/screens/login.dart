import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_order_up/models/user.dart' as User;
import 'package:flutter_order_up/services/cloudstore_service.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to OrderUp!')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SignInButton(
              Buttons.Google,
              onPressed: () async {
                // Trigger the authentication flow
                final googleUser = await GoogleSignIn().signIn();

                // Obtain the auth details from the request
                final googleAuth = await googleUser?.authentication;

                // Create a new credential
                final credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth?.accessToken,
                  idToken: googleAuth?.idToken,
                );

                // Once signed in, return the UserCredential
                var uc = await FirebaseAuth.instance
                    .signInWithCredential(credential);

                var uDb = UserDatabase();

                var user = await uDb.getUser(uc.user!.uid);

                if (user.uid == null) {
                  UserDatabase()
                    ..addUser(User.User.fromValues(
                        fullName: uc.user!.displayName ?? '',
                        email: uc.user!.email ?? '',
                        provider: uc.credential!.providerId,
                        photoUrl: uc.user!.photoURL,
                        uid: uc.user!.uid));
                }

                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/homepage', (Route<dynamic> route) => false);
              },
            ),
          ),
          Center(
            child: SignInButton(
              Buttons.Facebook,
              onPressed: () async {
                try {
                  // Trigger the sign-in flow
                  final result = await FacebookAuth.instance.login();

                  if (result.accessToken == null) return;

                  // Create a credential from the access token
                  final facebookAuthCredential =
                      FacebookAuthProvider.credential(
                          result.accessToken!.token);

                  // Once signed in, return the UserCredential
                  await FirebaseAuth.instance
                      .signInWithCredential(facebookAuthCredential);

                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/homepage', (Route<dynamic> route) => false);
                } on FirebaseAuthException catch (e) {
                  final snackBar = SnackBar(content: Text('${e.message}'));

                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

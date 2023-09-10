import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class LoginGooglePage extends StatefulWidget {
  const LoginGooglePage({Key? key}) : super(key: key);

  @override
  _LoginGooglePageState createState() => _LoginGooglePageState();
}

class _LoginGooglePageState extends State<LoginGooglePage> {
  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Show a success message using SnackBar
      final snackBar = SnackBar(content: Text('登入成功！'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Save user data to shared preferences using JSON serialization
      final userData = {
        'id': userCredential.user?.uid,
        'displayName': userCredential.user?.displayName,
        'email': userCredential.user?.email,
        'photoUrl': userCredential.user?.photoURL,
      };
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user_data', jsonEncode(userData));

      // Navigate back to the main page (MyHomePage) and pass the userCredential
      Navigator.pop(context, userCredential);
    } catch (error) {
      // Handle any errors that occurred during the Google Sign In process
      print('Error occurred during Google Sign In: $error');

      if (error is FirebaseAuthException) {
        // Handle FirebaseAuthException
        final snackBar = SnackBar(content: Text('登入失敗：${error.message}'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        // Handle other types of errors
        final snackBar = SnackBar(content: Text('登入失敗！'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Google 登入'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ElevatedButton(
            onPressed: () => _handleGoogleSignIn(context),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(187, 162, 125, 1),
              onPrimary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: Text(
              '使用 Google 登入',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

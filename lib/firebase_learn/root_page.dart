// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_week_4/firebase_learn/authentication.dart';
import 'package:flutter_week_4/firebase_learn/home_screen.dart';
import 'package:flutter_week_4/firebase_learn/login_signup_screen.dart';

class RootPage extends StatefulWidget {
  final BaseAuth? auth;
  const RootPage({super.key, this.auth});

  @override
  State<RootPage> createState() => _RootPageState();
}

  enum AuthStatus {Not_DETERMINED, NOT_LOGGED_IN, LOGGED_IN }

class _RootPageState extends State<RootPage> {

  AuthStatus authStatus = AuthStatus.Not_DETERMINED;
  String userId = "";
  @override
  void initState() {
    //TODO: implement iniState
    super.initState();
    widget.auth?. getCurrentUser().then((user) {
      setState(() {
      if (user != null) {
        userId = user.uid;
      } 
      authStatus =
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN; 
    });
  });
}

void onSignOut() async {
  setState(() {
    authStatus = AuthStatus.NOT_LOGGED_IN;
    userId = "";
  });
}

Widget buildWaittingScreen() {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ),
  );
}

void onLoggedIn() async {
  widget.auth?.getCurrentUser().then((user) {
    setState(() {
      userId = user?.uid ?? "";
    });
  });
  // setState(() {
  //   authStatus = AuthStatus.LOGGED_IN;
  // });
}

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.Not_DETERMINED:
      return buildWaittingScreen();
      case AuthStatus.NOT_LOGGED_IN:
      return LoginSignupPage(
        auth: widget.auth, onLoggedIn: onLoggedIn, onSignOut: onSignOut);
      case AuthStatus.LOGGED_IN:
        if(userId.isNotEmpty && userId != null) {
          return HomePage
          (
            userId: userId, auth: widget.auth, onSignOut: onSignOut);
        } else {
          return buildWaittingScreen();
        }
        // return buildWaittingScreen();

    }
  }
}
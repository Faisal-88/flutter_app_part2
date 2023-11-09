import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_week_4/firebase_learn/authentication.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  final BaseAuth? auth;
  final VoidCallback? onSignOut;
  const HomePage({super.key, this.userId, this.auth, this.onSignOut});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Hello world App",
          style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
    );
  }
}

import 'package:bestengineer/chatApp/chatHome.dart';
import 'package:bestengineer/chatApp/chatLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (_auth.currentUser != null) {
      return ChatHome();
    } else {
      return ChatLogin();
    }
  }
}

import 'package:bestengineer/chatApp/chatLogin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Service {
  Future<User?> createAccount(String name, String email, String pswd) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore=FirebaseFirestore.instance;

    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: pswd))
          .user;
      if (user != null) {
        print("creatwd");
        user.updateDisplayName(name);
        await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
          "name":name,
          "email":email,
          "status":"Unavailable",
          "uid":_auth.currentUser!.uid
        });
        return user;
      } else {
        print("not success");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signin(String email, String pswd) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      User? user =
          (await _auth.signInWithEmailAndPassword(email: email, password: pswd))
              .user;
      if (user != null) {
        print("login success");
        return user;
      } else {
        print("login failed");
        return user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

//////////////////////////////////////////////////
  Future<User?> logout(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut().then((value) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatLogin()),
        );
      });
    } catch (e) {
      print(e);
    }
  }
}

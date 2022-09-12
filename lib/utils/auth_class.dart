import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _profiles = FirebaseFirestore.instance.collection('profile');

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
    try {
      var user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      if (user != null) {
        await FlutterSecureStorage().write(key: 'usrID', value: user.uid);
      }
      ;
    } on FirebaseAuthException catch (e) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text("OK"))
          ],
        ),
      );
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, String userName, String phoneNumber, BuildContext context) async {
    try {
      var user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        await _profiles.doc(user.uid).set({"userName": userName, 'phoneNumber': phoneNumber});
      }
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(title: Text('Error Occured'), content: Text(e.toString()), actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text("OK"))
              ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        print('Email already in use.');
      } else {
        print('Error: $e');
      }
    }
  }

  Future<void> signOut() async {
    await FlutterSecureStorage().deleteAll();
    await _auth.signOut();
  }
}

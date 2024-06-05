import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learn_firebase/university_app/models/student_model.dart';
import 'package:learn_firebase/university_app/models/teacher_model.dart';

import 'data.dart';

@immutable
final class FirebaseService {
  /// auth
  static Future<Roles?> handleSignInWithGoogle(BuildContext context) async {
    UserCredential? userCredential = await _googleSignIn();

    if(userCredential?.user != null){
      // Roles role = userCredential?.user?.email == "diyorbekflutter@gmail.com"
      //     ? Roles.admin
      //     : Roles.student;

      Roles role = Roles.admin;

      userCredential?.user?.updateDisplayName(role.name);
      return role;
    } else {
      return null;
    }
  }

  static Future<UserCredential?> _googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return null;
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> _isStudent(BuildContext context) async {
    bool isStudent = true;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Who are you?"),
              TextButton(
                onPressed: (){
                  isStudent = true;
                  Navigator.pop(context);
                },
                child: const Text("Student"),
              ),
              TextButton(
                onPressed: (){
                  isStudent = false;
                  Navigator.pop(context);
                },
                child: const Text("Teacher"),
              ),
            ],
          ),
        );
      },
    );

    return isStudent;
  }

  /// crud rial time database
  static final db = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> create(String path, Object model) async {
    // if(model is StudentModel){
    //   model.key = db.child(path).key;
    //   await db.child(path).child(model.key!).set(model.toJson);
    // } else if(model is TeacherModel){
    //   model.key = db.child(path).key;
    //   await db.child(path).child(model.key!).set(model.toJson);
    // }

    return db.onChildAdded;
  }

  static Future<List<Map<String, dynamic>>> get(String path) async {
    List<Map<String, dynamic>> result = [];

    Query query = db.child(path);
    DatabaseEvent databaseEvent = await query.once();
    Iterable<DataSnapshot> objects = databaseEvent.snapshot.children;

    for(DataSnapshot item in objects) {
      if(item.value != null) {
        result.add(Map<String, dynamic>.from(item.value as Map));
      }
    }

    return result;
  }

  static Future<Stream<DatabaseEvent>> update(String path, Object model) async {
    // if(model is StudentModel){
    //   await db.child(path).child(model.key!).set(model.toJson);
    // } else if(model is TeacherModel){
    //   await db.child(path).child(model.key!).set(model.toJson);
    // }

    return db.onChildAdded;
  }

  static Future<void> delete(String path, String key) async {
    await db.child(path).child(key).remove();
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FirebaseServices extends StatelessWidget {
  const FirebaseServices({super.key});
  static late DatabaseReference dbref;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  // ignore: non_constant_identifier_names
  static void InitializeDatabase(String databaseName) {
    dbref = FirebaseDatabase.instance.ref().child(databaseName);
  }

  // ignore: non_constant_identifier_names
  static Future<void> SignupAccount(String userName, String email, String user,
      String gender, String phoneNumber, String password) async {
    Map<String, String> schoolmembers = {
      'Username': userName,
      'Email': email,
      'User': user,
      'Gender': gender,
      'Phone': phoneNumber,
      'Password': password
    };
    dbref.push().set(schoolmembers);
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      CreateToast('Successfully Signup');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CreateToast('An account is already exist with that email');
      }
    }
  }

  // ignore: non_constant_identifier_names
  static void CreateToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 12,
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Models/Model.dart';

// ignore: must_be_immutable
class FirebaseServices extends StatelessWidget {
  FirebaseServices({super.key});
  // ignore: non_constant_identifier_names
  static String DatabaseName = "MyAcademicAppointment";
  static late DatabaseReference dbref;
  static late DataSnapshot dsnapshot;
  Model model = Model();

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
    try {
      Map<String, String> schoolmembers = {
        'Username': userName,
        'Email': email,
        'User': user,
        'Gender': gender,
        'Phone': phoneNumber,
        'Password': password
      };
      dbref.push().set(schoolmembers);
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
  static void SigninAccount(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        String uid = userCredential.user!.uid;
        DatabaseReference ref =
            FirebaseDatabase.instance.ref("$DatabaseName/$uid");
        dsnapshot = await ref.get();
        if (dsnapshot.exists) {
          Map<dynamic, dynamic> userData =
              dsnapshot.value as Map<dynamic, dynamic>;
          // model.Name = userData['Username'];
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        CreateToast('email or password maybe wrong');
      }
    }
  }

  // ignore: non_constant_identifier_names
  static void CreateToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.NONE,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 12,
      timeInSecForIosWeb: 2,
    );
  }
}

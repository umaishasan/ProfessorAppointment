import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Models/Model.dart';

// ignore: must_be_immutable
class FirebaseServices extends StatelessWidget {
  const FirebaseServices({super.key});
  // ignore: non_constant_identifier_names
  static String DatabaseName = "MyAcademicAppointment";
  static late DatabaseReference dbref;
  static late DataSnapshot dsnapshot;

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
  static Future<Model?> SigninAccount(String email, String password) async {
    Model model = Model();
    try {
      //login condition check
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //prepare get user data
      String uid = userCredential.user!.uid;
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("MyAcademicAppointment");
      DatabaseEvent event =
          await ref.orderByChild("Email").equalTo(email).once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> users =
            event.snapshot.value as Map<dynamic, dynamic>;
        users.forEach((key, value) {
          print("User found at key: $key, Email: ${value['Email']}");
          model.Name = value['Username'];
          model.Email = value['Email'];
          model.Phone = value['Phone'];
          model.User = value['User'];
          model.Gender = value['Gender'];
        });
      } else {
        print("User not found!");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        CreateToast('email or password maybe wrong');
      }
    }
    return model;
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

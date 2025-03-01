import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Models/Messaging.dart';
import 'package:scholappoinment_934074496/Models/Person.dart';
import 'package:scholappoinment_934074496/Models/Schedule.dart';

// ignore: must_be_immutable
class FirebaseServices extends StatelessWidget {
  const FirebaseServices({super.key});

  // ignore: non_constant_identifier_names
  static String DatabaseName = "MyAcademicAppointment";
  static String FirestoreMsgCollectionName = "Messages";
  static String FirestoreScheduleCollectionName = "Schedule";
  static String FirestoreAppointmentCollectionName = "Appointment";
  static FirebaseAuth Auth = FirebaseAuth.instance;
  static FirebaseFirestore Firestore = FirebaseFirestore.instance;
  static FirebaseMessaging Fmessaging = FirebaseMessaging.instance;
  static late DataSnapshot dsnapshot;
  static Person person = Person();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  // initialize database when load app
  static void InitializeDatabase(String databaseName) {
    FirebaseDatabase.instance.ref().child(databaseName);
  }

  // create/signup account in this app
  static Future<void> SignupAccount(
      String userName,
      String email,
      String user,
      String gender,
      String phoneNumber,
      String password,
      String qualification) async {
    var db = FirebaseDatabase.instance.ref().child(DatabaseName);

    try {
      Map<String, String> schoolmembers = {
        'Id': db.key.toString(),
        'Username': userName,
        'Email': email,
        'User': user,
        'Gender': gender,
        'Phone': phoneNumber,
        'PushToken': "",
        'Qualification': qualification,
        'UserImage': "",
      };
      db.push().set(schoolmembers);
      await Auth.createUserWithEmailAndPassword(
          email: email, password: password);
      CommonComponent.CreateToast('Successfully Signup');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CommonComponent.CreateToast(
            'An account is already exist with that email');
      }
    }
  }

  // login/signin app in this app
  static Future<Person?> SigninAccount(String email, String password) async {
    try {
      //login condition check
      await Auth.signInWithEmailAndPassword(email: email, password: password);
      //await Auth.setSettings(appVerificationDisabledForTesting: true);

      //prepare get user data
      var dbref = FirebaseDatabase.instance.ref(DatabaseName);
      DatabaseEvent event = await dbref.once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> users =
            event.snapshot.value as Map<dynamic, dynamic>;

        users.forEach((key, value) {
          if (value['Email'] == email) {
            person.Id = key.toString();
            person.Name = value['Username'];
            person.Email = value['Email'];
            person.Phone = value['Phone'];
            person.User = value['User'];
            person.Gender = value['Gender'];
            person.Qualification = value['Qualification'];
            person.UserImage = value['UserImage'];
          }
        });
      }

      //create message user data
    } on FirebaseAuthException catch (e) {
      CommonComponent.CreateToast("User not found!");
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        CommonComponent.CreateToast('email or password maybe wrong');
      }
      return null;
    }
    return person;
  }

  //check if login user is exist then he can type message
  static Future<bool> IsAccountExistForMsg() async {
    var docId = (await Firestore.collection(FirestoreMsgCollectionName)
            .doc(Auth.currentUser!.uid)
            .get())
        .exists;
    return docId;
  }

  //check if login user is exist then he can type message
  static Future<bool> IsAccountExistForSche() async {
    var docId = (await Firestore.collection(FirestoreScheduleCollectionName)
            .doc(Auth.currentUser!.uid)
            .get())
        .exists;
    return docId;
  }

  //check if this user not available then create user for message
  static Future<void> CreateMessageUser(String Name) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final messageUser = Messaging(
        Id: Auth.currentUser!.uid,
        Name: Name,
        MesageTime: time,
        Message: "This new member available now!");

    await Firestore.collection(FirestoreMsgCollectionName)
        .doc(Auth.currentUser!.uid)
        .set(messageUser.toJson());
  }

  //check if this user not available then create user for schedule
  static Future<void> CreateScheduleUser(String name, List<String> dateTimes,
      String status, String qualification) async {
    final scheduleUser = Schedule(
        Id: Auth.currentUser!.uid,
        Name: name,
        DateTimes: dateTimes,
        Status: status,
        Qualification: qualification);

    await Firestore.collection(FirestoreScheduleCollectionName)
        .doc(Auth.currentUser!.uid)
        .set(scheduleUser.toJson());
  }

  //get all messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> GetAllMeassages() {
    // print(
    //     "Get message id: ${Firestore.collection('${FirestoreMsgCollectionName}')}");
    return Firestore.collection(FirestoreMsgCollectionName).snapshots();
  }

  //get all schedule
  static Stream<QuerySnapshot<Map<String, dynamic>>> GetAllSchedule() {
    //print(
    //    "Get message id: ${Firestore.collection('${FirestoreMsgCollectionName}')}");
    return Firestore.collection(FirestoreScheduleCollectionName).snapshots();
  }

  //get all appointment
  static Stream<QuerySnapshot<Map<String, dynamic>>> GetAllAppointment() {
    var snap =
        Firestore.collection(FirestoreAppointmentCollectionName).snapshots();

    return snap;
  }

  //get all appointment doc id
  static void GetAllAppointmentDocId() async {
    var snap =
        await Firestore.collection(FirestoreAppointmentCollectionName).get();
    for (var element in snap.docs) {
      print("Is this appointment doc id: $element");
    }
  }

  //get token of push notification of message
  static void GetFirebaseMessagingToken() async {
    await Fmessaging.requestPermission();
    await Fmessaging.getToken().then((t) {
      if (t != null) {
        person.PushToken = t;
        print("messaging push token ${t}");
      }
    });
  }

  //send messages
  static Future<void> SendMessage(
      Messaging userMessing, String messages) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final Messaging msg = Messaging(
        Message: messages,
        Name: userMessing.Name,
        MesageTime: time,
        Id: userMessing.Id);
    final ref = Firestore.collection(FirestoreMsgCollectionName);

    await ref.doc(time).set(msg.toJson());
  }

  //teacher make schedule for student
  static Future<void> SetSchedule(List<String> elements, String status) async {
    DocumentReference docRef =
        Firestore.collection(FirestoreScheduleCollectionName)
            .doc(Auth.currentUser!.uid);
    docRef.update({
      "DatesTimes": FieldValue.arrayUnion(elements),
      "Status": status,
    });
    CommonComponent.CreateToast("Set schedule successfully");
  }

  //student set appointment accoding to time
  static Future<void> SetAppointment(
      String name,
      String user,
      String dateTime,
      bool isAccept,
      String teacherName,
      String teacherId,
      String teacherQualification) async {
    try {
      DocumentReference docRef =
          await Firestore.collection(FirestoreAppointmentCollectionName).add({
        'Name': name,
        'User': user,
        'DateTime': dateTime,
        'Accept': isAccept,
        'TeacherName': teacherName,
        'TeacherId': teacherId,
        'TeaQualif': teacherQualification,
        'Id': Auth.currentUser!.uid,
      });

      await docRef.update({'Id': docRef.id});
      print("Data added successfully!");
      CommonComponent.CreateToast("Set appointment successfully");

      await docRef.update({'DocId': docRef.id});
      print("Data added successfully! ${docRef.id}");
      CommonComponent.CreateToast("Set appointment successfully");
    } catch (e) {
      print("Firestore Error: $e");
      CommonComponent.CreateToast("Not Set");
    }
  }

  //aftr that teacher will accept appointment
  static Future<void> AcceptAppointment(String id, bool isAccept) async {
    DocumentReference docRef =
        Firestore.collection(FirestoreAppointmentCollectionName).doc(id);
    await docRef.update({"Accept": isAccept});
    CommonComponent.CreateToast("Appointment generate successfully");
  }

  static Future<void> forgotPassword(String email) async {
    try {
      await Auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      CommonComponent.CreateToast(
          "Failed to reset password against on email: $e");
    }
  }

  static Future<void> UpdateUserProfile(
    String id,
    String name,
    String qualification,
    String phone,
    String gender,
  ) async {
    try {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.ref().child(DatabaseName).child(id);
      await dbRef.update({
        'Username': name,
        'Gender': gender,
        'Phone': phone,
        'Qualification': qualification
      });
      CommonComponent.CreateToast("Profile update successfully");
    } catch (e) {
      CommonComponent.CreateToast("Profile do not update");
    }
  }

  //teacher and student can cancle appointment
  static Future<void> DeleteAppointment(String docId) async {
    DocumentReference docRef =
        Firestore.collection(FirestoreAppointmentCollectionName).doc(docId);
    print("is this Id: $docId");
    await docRef.delete();
    CommonComponent.CreateToast("Cancle appointment successfully");
  }

  //login user logout from application
  static Future<void> LogoutUser() async {
    await Auth.signOut();
  }

  //aftr that teacher will accept appointment
  static Future<void> UpdateUserImage(String id, String imageUrl) async {
    try {
      DatabaseReference dbRef =
          FirebaseDatabase.instance.ref().child(DatabaseName).child(id);
      await dbRef.update({
        'UserImage': imageUrl,
      });
      DatabaseEvent event = await dbRef.once();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> users =
            event.snapshot.value as Map<dynamic, dynamic>;
        users.forEach((key, value) {
          if (value['Id'] == id) {
            person.UserImage = value['UserImage'];
          }
        });
      }
      print("image update successfully");
    } catch (e) {
      print("Image do not update");
    }
  }
}

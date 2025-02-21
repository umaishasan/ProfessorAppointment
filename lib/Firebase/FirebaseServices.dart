import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  static late DataSnapshot dsnapshot;

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
    try {
      Map<String, String> schoolmembers = {
        'Username': userName,
        'Email': email,
        'User': user,
        'Gender': gender,
        'Phone': phoneNumber,
        'Password': password,
        'Qualification': qualification
      };
      FirebaseDatabase.instance
          .ref()
          .child(DatabaseName)
          .push()
          .set(schoolmembers);
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      CreateToast('Successfully Signup');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        CreateToast('An account is already exist with that email');
      }
    }
  }

  // login/signin app in this app
  static Future<Person?> SigninAccount(String email, String password) async {
    Person person = Person();
    try {
      //login condition check
      await Auth.signInWithEmailAndPassword(email: email, password: password);

      //prepare get user data
      var dbref = FirebaseDatabase.instance.ref(DatabaseName);
      DatabaseEvent event = await dbref.once();

      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> users =
            event.snapshot.value as Map<dynamic, dynamic>;

        users.forEach((key, value) {
          if (value['Email'] == email) {
            person.Name = value['Username'];
            person.Email = value['Email'];
            person.Phone = value['Phone'];
            person.User = value['User'];
            person.Gender = value['Gender'];
            person.Qualification = value['Qualification'];
          }
        });
      }
      //create message user data
    } on FirebaseAuthException catch (e) {
      CreateToast("User not found!");
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        CreateToast('email or password maybe wrong');
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

  // when any warning or any message system related then you can see in bar
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

  //common method for get conversation id
  String GetCoversationId(String id) =>
      Auth.currentUser!.uid.hashCode <= id.hashCode
          ? '${Auth.currentUser!.uid}_$id'
          : '${id}_${Auth.currentUser!.uid}';

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
    //print(
    //    "Get message id: ${Firestore.collection('${FirestoreAppointmentCollectionName}')}");
    return Firestore.collection(FirestoreAppointmentCollectionName).snapshots();
  }

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

  static Future<void> SetSchedule(List<String> elements, String status) async {
    DocumentReference docRef =
        Firestore.collection(FirestoreScheduleCollectionName)
            .doc(Auth.currentUser!.uid);
    docRef.update({
      "DatesTimes": FieldValue.arrayUnion(elements),
      "Status": status,
    });
    CreateToast("Set schedule successfully");
  }

  static Future<void> SetAppointment(
      String name, String user, String dateTime, bool isAccept) async {
    try {
      DocumentReference docRef =
          await Firestore.collection(FirestoreAppointmentCollectionName).add({
        'Name': name,
        'User': user,
        'DateTime': dateTime,
        'Accept': isAccept,
      });
      await docRef.update({'Id': docRef.id});
      print("Data added successfully!");
      CreateToast("Set appointment successfully");
    } catch (e) {
      print("Firestore Error: $e");
      CreateToast("Not Set");
    }
  }

  static Future<void> AcceptAppointment(String id, bool isAccept) async {
    DocumentReference docRef =
        Firestore.collection(FirestoreAppointmentCollectionName).doc(id);
    await docRef.update({"Accept": isAccept});
    CreateToast("Appointment generate successfully");
  }
}

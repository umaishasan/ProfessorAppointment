import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myacademicappointment/AppointmentScreenProf.dart';
import 'package:myacademicappointment/AppointmentScreenStu.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/DiscussionScreen.dart';
import 'package:myacademicappointment/EditProfileScreen.dart';
import 'package:myacademicappointment/Firebase/FirebaseServices.dart';
import 'package:myacademicappointment/LoginScreen.dart';
import 'package:myacademicappointment/Models/Appointment.dart';
import 'package:myacademicappointment/Models/Messaging.dart';
import 'package:myacademicappointment/Models/Person.dart';
import 'package:myacademicappointment/Models/Schedule.dart';
import 'package:myacademicappointment/SetScheduleScreen.dart';

// ignore: must_be_immutable
class Sidebar extends StatefulWidget {
  const Sidebar({
    super.key,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<Messaging> messagesList = [];
  List<Schedule> scheduleList = [];
  List<Appointment> appointmentList = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages();
    _fetchSchedules();
    _fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    var person = Provider.of<Person>(context, listen: false);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context, person.User, person.Name, person.UserImage),
          Expanded(
            child: buildMenuItem(
                context, person.Name, person.Id, person.UserImage),
          ),
          const Divider(
            color: Color.fromARGB(255, 73, 73, 73),
          ),
          buildBottom(context),
        ],
      ),
    );
  }

  //Profile Photo at header
  Widget buildHeader(
      BuildContext context, String role, String name, String imageUrl) {
    return Container(
      height: 230,
      padding: const EdgeInsets.only(top: 50),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0E0E0),
              Color(0xFF2E7D32),
            ]),
      ),
      child: Column(
        children: [
          const SizedBox(height: 35),
          CommonComponent.ImageAvatar(context, imageUrl, 80, 80),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w300,
              color: Color(0xFF080808),
            ),
          ),
          Text(
            role,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w300,
              color: Color(0xFF080808),
            ),
          ),
        ],
      ),
    );
  }

  //All icons buttons after header
  Widget buildBottom(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListTile(
                title: const Text("Logout"),
                leading: const Icon(Icons.logout),
                iconColor: const Color.fromARGB(255, 0, 0, 0),
                textColor: const Color.fromARGB(255, 0, 0, 0),
                onTap: () {
                  LogoutToLogin();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(
      BuildContext context, String name, String id, String userImage) {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.home_filled),
          title: const Text("Home"),
          iconColor: const Color.fromARGB(255, 0, 0, 0),
          textColor: const Color.fromARGB(255, 0, 0, 0),
          onTap: () {
            CommonComponent.BacktoHome(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Profile"),
          iconColor: const Color.fromARGB(255, 0, 0, 0),
          textColor: const Color.fromARGB(255, 0, 0, 0),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.comment),
          title: const Text("Discussion"),
          iconColor: const Color.fromARGB(255, 0, 0, 0),
          textColor: const Color.fromARGB(255, 0, 0, 0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => DiscussionScreen(
                        userMessages: messagesList,
                        messaging: new Messaging(
                            Message: "",
                            Name: name,
                            UserImage: userImage,
                            MesageTime: time,
                            Id: id))));
          },
        ),
        IsScheduleOn(context),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget IsScheduleOn(BuildContext context) {
    String role = Provider.of<Person>(context, listen: false).User;
    if (role == "Teacher") {
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text("Schedule"),
            iconColor: const Color.fromARGB(255, 0, 0, 0),
            textColor: const Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SetScheduleScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_rounded),
            title: const Text("Appointment"),
            iconColor: const Color.fromARGB(255, 0, 0, 0),
            textColor: const Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AppointmentScreenProf(
                          appointmentList: appointmentList)));
            },
          ),
        ],
      );
    } else {
      return Column(
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_month_rounded),
            title: const Text("Appointment"),
            iconColor: const Color.fromARGB(255, 0, 0, 0),
            textColor: const Color.fromARGB(255, 0, 0, 0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => AppointmentScreenStu(
                            scheduleList: scheduleList,
                            appointmentList: appointmentList,
                          )));
            },
          )
        ],
      );
    }
  }

  Future<void> _fetchMessages() async {
    FirebaseServices.GetAllMeassages().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Messaging> fetchedMessages =
            snapshot.docs.map((doc) => Messaging.fromJson(doc.data())).toList();
        setState(() {
          messagesList = fetchedMessages;
        });
        //print("Fetched Messages: ${jsonEncode(messagesList)}");
      }
    });
  }

  Future<void> _fetchSchedules() async {
    FirebaseServices.GetAllSchedule().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Schedule> fetchedSchedule =
            snapshot.docs.map((doc) => Schedule.fromJson(doc.data())).toList();
        setState(() {
          scheduleList = fetchedSchedule;
        });
      }
    });
  }

  Future<void> _fetchAppointments() async {
    FirebaseServices.GetAllAppointment().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Appointment> fetchedAppointment = snapshot.docs
            .map((doc) => Appointment.fromJson(doc.data()))
            .toList();
        setState(() {
          appointmentList = fetchedAppointment;
        });
      }
    });
  }

  Future<void> LogoutToLogin() async {
    await FirebaseServices.LogoutUser().then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
  }
}

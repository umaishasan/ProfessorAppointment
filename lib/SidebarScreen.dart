import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholappoinment_934074496/AppointmentScreenProf.dart';
import 'package:scholappoinment_934074496/AppointmentScreenStu.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/DiscussionScreen.dart';
import 'package:scholappoinment_934074496/EditProfileScreen.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/Models/Messaging.dart';
import 'package:scholappoinment_934074496/Models/Person.dart';
import 'package:scholappoinment_934074496/SetScheduleScreen.dart';

// ignore: must_be_immutable
class Sidebar extends StatefulWidget {
  Sidebar({
    super.key,
  });

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<Messaging> messagesList = [];

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          Expanded(
            child: buildMenuItem(context),
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
  Widget buildHeader(BuildContext context) {
    String role = Provider.of<Person>(context, listen: false).User;
    String name = Provider.of<Person>(context, listen: false).Name;
    return Container(
      color: const Color.fromARGB(180, 101, 188, 71),
      height: 230,
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          const SizedBox(height: 35),
          const CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
                'https://dashboard.codeparrot.ai/api/image/Z6UIYqQDH3ZYFIXW/user-imag.png'),
          ),
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
  Widget buildBottom(BuildContext context) => Container(
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
                    // Handle logout logic here
                  },
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildMenuItem(BuildContext context) => Column(
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
                      builder: (_) =>
                          DiscussionScreen(userMessages: messagesList)));
            },
          ),
          IsScheduleOn(context),
        ],
      );

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
                      builder: (_) => const AppointmentScreenProf()));
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
                      builder: (_) => const AppointmentScreenStu()));
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
        print("Fetched Messages: ${jsonEncode(messagesList)}");
      }
    });
  }

  // void AllMesagesInitialize() {
  //   List<Messaging> messagesList = [];

  //   StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
  //       stream: FirebaseServices.GetAllMeassages(),
  //       builder: (context, snapshots) {
  //         // Checking connection state
  //         if (snapshots.connectionState == ConnectionState.waiting) {
  //           return const Center(child: CircularProgressIndicator());
  //         }

  //         if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
  //           return const Center(child: Text("No messages found"));
  //         }

  //         messagesList = snapshots.data!.docs
  //             .map((doc) => Messaging.fromJson(doc.data()))
  //             .toList();

  //         // Debugging: Print JSON data
  //         print("Get Data: ${jsonEncode(messagesList)}");

  //         // Return list of messages
  //         return ListView.builder(
  //           itemCount: messagesList.length,
  //           itemBuilder: (context, index) {
  //             message = messagesList[index];
  //             return ListTile(
  //               title: Text(message.Name),
  //               subtitle: Text(message.Message),
  //               trailing: Text(
  //                 DateTime.fromMillisecondsSinceEpoch(
  //                         int.tryParse(message.MesageTime) ?? 0)
  //                     .toString(),
  //               ),
  //             );
  //           },
  //         );
  //       });
  // }
}

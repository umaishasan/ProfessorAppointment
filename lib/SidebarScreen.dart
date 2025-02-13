import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholappoinment_934074496/AppointmentScreenProf.dart';
import 'package:scholappoinment_934074496/AppointmentScreenStu.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/DiscussionScreen.dart';
import 'package:scholappoinment_934074496/EditProfileScreen.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/Models/Model.dart';
import 'package:scholappoinment_934074496/SetScheduleScreen.dart';

// ignore: must_be_immutable
class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

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
    String role = Provider.of<Model>(context, listen: false).User;
    String name = Provider.of<Model>(context, listen: false).Name;
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const DiscussionScreen()));
            },
          ),
          IsScheduleOn(context),
        ],
      );

  // ignore: non_constant_identifier_names
  Widget IsScheduleOn(BuildContext context) {
    String role = Provider.of<Model>(context, listen: false).User;
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
}

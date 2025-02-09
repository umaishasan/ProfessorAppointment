import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AppointmentScreenProf.dart';
import 'package:scholappoinment_934074496/AppointmentScreenStu.dart';
import 'package:scholappoinment_934074496/DiscussionScreen.dart';
import 'package:scholappoinment_934074496/EditProfileScreen.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/LoginScreen.dart';
import 'package:scholappoinment_934074496/SetScheduleScreen.dart';

class Sidebar extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final VoidCallback? onHomePressed;
  final VoidCallback? onProfilePressed;
  final VoidCallback? onDiscussionPressed;
  final VoidCallback? onAppointmentPressed;
  final VoidCallback? onLogoutPressed;

  const Sidebar({
    super.key,
    this.name = "Maria Jason",
    this.role = "Student",
    this.imageUrl =
        "https://dashboard.codeparrot.ai/api/image/Z6UKasNJMVoCot_D/user-imag.png",
    this.onHomePressed,
    this.onProfilePressed,
    this.onDiscussionPressed,
    this.onAppointmentPressed,
    this.onLogoutPressed,
  });

  @override
  Widget build(BuildContext context) => Drawer(
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

  //Profile Photo at header
  Widget buildHeader(BuildContext context) => Container(
        color: const Color.fromARGB(180, 101, 188, 71),
        height: 230,
        padding: const EdgeInsets.only(top: 50),
        child: const Column(
          children: [
            SizedBox(height: 35),
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                  'https://dashboard.codeparrot.ai/api/image/Z6UIYqQDH3ZYFIXW/user-imag.png'),
            ),
            SizedBox(height: 5),
            Text(
              'Maria Jason',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w300,
                color: Color(0xFF080808),
              ),
            ),
            Text(
              'Student',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w300,
                color: Color(0xFF080808),
              ),
            ),
          ],
        ),
      );

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
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()));
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
    if (LoginScreen.isStudent == false) {
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

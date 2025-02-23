import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Models/Person.dart';
import 'package:scholappoinment_934074496/SidebarScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Person>(context);
    print("Why data is empty: ${userData.Email} and name: ${userData.Name}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color(0xFF32983E),
      ),
      drawer: Sidebar(),
      body: Stack(
        children: [
          // Background ellipse
          Positioned(
            top: -18,
            left: -660,
            child: Container(
              width: 1027,
              height: 1701,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(73, 100, 188, 71),
              ),
            ),
          ),

          // Profile Card
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              width: 343,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3), // Light shadow
                    spreadRadius: 1,
                    blurRadius: 6,
                    offset: const Offset(0, 4), // Position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(9),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  CommonComponent.ImageAvatar("", 80, 80),
                  const SizedBox(height: 14),
                  Text(
                    userData.User,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF080808),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildInfoRow('Name:', userData.Name),
                  const SizedBox(height: 10),
                  _buildInfoRow('Email:', userData.Email),
                  const SizedBox(height: 10),
                  _buildInfoRow('Phone:', userData.Phone),
                  const SizedBox(height: 10),
                  _buildInfoRow('Gender:', userData.Gender),
                  const SizedBox(height: 10),
                  _checkQualification(userData.User, userData.Qualification)
                  //const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkQualification(String userdata, String qualification) {
    if (userdata == "Teacher") {
      //const SizedBox(height: 16);
      return _buildInfoRow('Qual.:', qualification);
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          SizedBox(
            width: 76,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

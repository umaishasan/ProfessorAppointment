import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/SidebarScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.white,
      ),
      drawer: const Sidebar(),
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
                color: Color(0x4D16442C),
              ),
            ),
          ),

          // Profile Card
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 0),
              width: 343,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 130, 53, 53),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(9),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                        'https://dashboard.codeparrot.ai/api/image/Z6UIYqQDH3ZYFIXW/user-imag.png'),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Student',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF080808),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildInfoRow('Name:', 'Maria Jason'),
                  const SizedBox(height: 10),
                  _buildInfoRow('Email:', 'mariajason@gmail.com'),
                  const SizedBox(height: 10),
                  _buildInfoRow('Phone:', '0123 3456789'),
                  const SizedBox(height: 10),
                  _buildInfoRow('Gender:', 'Female'),
                  //const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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

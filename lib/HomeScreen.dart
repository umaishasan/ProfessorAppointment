import 'package:flutter/material.dart';
//import 'package:scholappoinment_934074496/StuSidebarScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

          Column(
            children: [
              // Header
              Container(
                height: 66,
                color: Colors.white,
                child: Stack(
                  children: [
                    const Center(
                      child: Text(
                        'Home',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: 26,
                      child: Image.network(
                        'https://dashboard.codeparrot.ai/api/image/Z6UIYqQDH3ZYFIXW/navigate.png',
                        width: 32,
                        height: 18,
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  margin: const EdgeInsets.only(top: 143),
                  width: 343,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 45),
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
                      const SizedBox(height: 29),
                      _buildInfoRow('Name:', 'Maria Jason'),
                      const SizedBox(height: 18),
                      _buildInfoRow('Email:', 'mariajason@gmail.com'),
                      const SizedBox(height: 18),
                      _buildInfoRow('Phone:', '0123 3456789'),
                      const SizedBox(height: 18),
                      _buildInfoRow('Gender:', 'Female'),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
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

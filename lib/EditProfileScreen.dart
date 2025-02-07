import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';

class ProfileScreen extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String profileImage;

  const ProfileScreen({
    super.key,
    this.name = "John Doe",
    this.email = "john@example.com",
    this.phone = "+1234567890",
    this.gender = "Male",
    this.profileImage =
        "https://dashboard.codeparrot.ai/api/image/Z6W8o6QDH3ZYFIZf/photo-edi.png",
  });

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

          // Header
          Column(
            children: [
              Container(
                height: 64,
                color: Colors.white,
                child: Stack(
                  children: [
                    Positioned(
                      left: 10,
                      top: 20,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    //Header
                    const Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontFamily: 'Jaro',
                          fontSize: 36,
                          color: Color(0xFF1E1E1E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Profile Card
              const SizedBox(height: 100),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    // Profile Image
                    Container(
                      width: 90,
                      height: 90,
                      child: const CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                            'https://dashboard.codeparrot.ai/api/image/Z6UIYqQDH3ZYFIXW/user-imag.png'),
                      ),
                    ),

                    //Student label
                    const SizedBox(height: 16),
                    const Text(
                      'Student',
                      style: TextStyle(
                        fontFamily: 'Heebo',
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF080808),
                      ),
                    ),

                    //Text fields
                    const SizedBox(height: 24),
                    _buildInfoField('Name:', name),
                    const SizedBox(height: 16),
                    _buildInfoField('Email:', email),
                    const SizedBox(height: 16),
                    _buildInfoField('Phone:', phone),
                    const SizedBox(height: 16),
                    _buildInfoField('Gender:', gender),
                  ],
                ),
              ),

              // Edit Profile Button
              const SizedBox(height: 32),
              SizedBox(
                width: 231,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    editProfile(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF32983E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//Common Widget For TextFields
  Widget _buildInfoField(String label, String value) {
    return Row(
      children: [
        SizedBox(
          width: 76,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Heebo',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 25,
            decoration: BoxDecoration(
              color: const Color(0x9ED9D9D9),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void editProfile(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }
}

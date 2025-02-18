import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Models/Person.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController qualification = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<Person>(context);
    return Scaffold(
      body: Stack(
        children: [
          CommonComponent.AppBarCreator(
              context, "Profile", Icons.arrow_back, () => editProfile(context)),

          // Header
          Column(
            children: [
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
                    const SizedBox(
                      width: 90,
                      height: 90,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                            'https://dashboard.codeparrot.ai/api/image/Z6UIYqQDH3ZYFIXW/user-imag.png'),
                      ),
                    ),

                    //Student label
                    const SizedBox(height: 16),
                    Text(
                      userData.User,
                      style: const TextStyle(
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
                    const SizedBox(height: 16),
                    _checkQualification(userData.User)
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

  Widget _checkQualification(String userdata) {
    if (userdata == "Teacher") {
      //const SizedBox(height: 16);
      return _buildInfoField('Qual.:', qualification);
    } else {
      return SizedBox.shrink();
    }
  }

//Common Widget For TextFields
  Widget _buildInfoField(String label, TextEditingController value) {
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
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0x9ED9D9D9),
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: TextField(
                controller: value,
                decoration: const InputDecoration(border: InputBorder.none),
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
    CommonComponent.BacktoHome(context);
  }
}

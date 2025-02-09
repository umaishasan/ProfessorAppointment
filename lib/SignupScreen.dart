// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/LoginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isStudent = true;
  bool isTeacher = false;
  bool isMale = false;
  bool isFemale = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Column(
                children: [
                  const SizedBox(height: 95),
                  const Text(
                    'SIGNUP',
                    style: TextStyle(
                      fontFamily: 'Jaro',
                      fontSize: 40,
                      color: Color(0xFF1E1E1E),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 49),
                  _buildTextField('Enter Username'),

                  const SizedBox(height: 16),
                  _buildTextField('Enter Email'),

                  const SizedBox(height: 16),
                  _buildToggleButtons(),

                  const SizedBox(height: 16),
                  _buildGenderToggles(),

                  const SizedBox(height: 16),
                  _buildTextField('Enter Phone'),

                  const SizedBox(height: 16),
                  _buildTextField('Enter Password'),

                  const SizedBox(height: 16),
                  _buildTextField('Enter Confirm Password'),

                  //Signup button
                  const SizedBox(height: 41),
                  _buildSignupButton(),

                  //Already have an account? Signin
                  const SizedBox(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Heebo',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        signinMethod();
                      },
                      child: const Text(
                        " Signin",
                        style: TextStyle(
                          fontFamily: 'Heebo',
                          fontSize: 16,
                          color: Color.fromARGB(204, 117, 110, 2),
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Widget _buildTextField(String hint, dynamic _txtController) {
  Widget _buildTextField(String hint) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: const Color(0xFFE7E5E5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        //controller: _txtController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF7D7777),
            fontSize: 20,
            fontFamily: 'Heebo',
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildToggle(
            'Student', isStudent, (val) => setState(() => isStudent = val)),
        const SizedBox(width: 50),
        _buildToggle(
            'Teacher', isTeacher, (val) => setState(() => isTeacher = val)),
      ],
    );
  }

  Widget _buildGenderToggles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildToggle('Male', isMale, (val) => setState(() => isMale = val)),
        const SizedBox(width: 50),
        _buildToggle(
            'Female', isFemale, (val) => setState(() => isFemale = val)),
      ],
    );
  }

  Widget _buildToggle(String text, bool value, Function(bool) onChanged) {
    return GestureDetector(
      //Condition
      onTap: () => onChanged(!value),

      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? const Color(0xFF32983E) : const Color(0xFFD9D9D9),
            ),
          ),

          //Common Design
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontFamily: 'Heebo',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupButton() {
    return SizedBox(
      width: 276,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          signupMethod();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF32983E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
        ),
        child: const Text(
          'Signup',
          style: TextStyle(
            fontFamily: 'Heebo',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  void signupMethod() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  void signinMethod() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}

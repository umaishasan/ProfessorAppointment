import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/LoginScreen.dart';
import 'package:scholappoinment_934074496/Services/FirebaseServices.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cnfrmpasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // ignore: non_constant_identifier_names
  String GenderText = "";

  // ignore: non_constant_identifier_names
  late String UserText = "";

  @override
  void initState() {
    super.initState();
    FirebaseServices.InitializeDatabase(FirebaseServices.DatabaseName);
  }

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
                  _buildTextField('Enter Username', _usernameController, false),

                  const SizedBox(height: 16),
                  _buildTextField('Enter Email', _emailController, false),

                  const SizedBox(height: 16),
                  _buildUserToggles(),

                  const SizedBox(height: 16),
                  _buildGenderToggles(),

                  const SizedBox(height: 16),
                  _buildTextField('Enter Phone', _phoneController, false),

                  const SizedBox(height: 16),
                  _buildTextField('Enter Password', _passwordController, true),

                  const SizedBox(height: 16),
                  _buildTextField(
                      'Enter Confirm Password', _cnfrmpasswordController, true),

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
  Widget _buildTextField(
      String hint, TextEditingController textController, bool isPassword) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
          color: const Color(0xFFE7E5E5),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 1)),
      child: TextField(
        controller: textController,
        obscureText: isPassword,
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

  Widget _buildUserToggles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUserToggleOption("Student"),
            const SizedBox(width: 16),
            _buildUserToggleOption("Teacher"),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderToggles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGenderToggleOption("Male"),
            const SizedBox(width: 16),
            _buildGenderToggleOption("Female"),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderToggleOption(String gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          GenderText = gender;
        });
        print("Selected Gender: ${GenderText}");
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: GenderText == gender ? Colors.green : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
          const SizedBox(width: 8),
          Text(gender, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildUserToggleOption(String user) {
    return GestureDetector(
      onTap: () {
        setState(() {
          UserText = user;
        });
        print("Selected User: ${UserText}");
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: UserText == user ? Colors.green : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
          const SizedBox(width: 8),
          Text(user, style: const TextStyle(fontSize: 16)),
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
    if (_passwordController.text != _cnfrmpasswordController.text) {
      FirebaseServices.CreateToast("Confirm password should match");
    } else if (_passwordController == "" ||
        _cnfrmpasswordController == "" ||
        _emailController == "" ||
        _phoneController == "" ||
        _usernameController == "") {
      FirebaseServices.CreateToast('Any fields can\'t be empty');
    } else {
      FirebaseServices.SignupAccount(
          _usernameController.text,
          _emailController.text,
          UserText,
          GenderText,
          _phoneController.text,
          _passwordController.text);

      FirebaseServices.CreateToast('Signup Successfully');
      Future.delayed(const Duration(seconds: 2));
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  void signinMethod() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}

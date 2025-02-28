import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/LoginScreen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key, required this.email});
  final String email;

  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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
                color: Color.fromARGB(73, 100, 188, 71),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 55.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Heading
                  const SizedBox(height: 90),
                  const Text(
                    'Forget Password',
                    style: TextStyle(
                      fontSize: 37,
                      fontFamily: 'Jaro',
                      color: Color(0xFF1E1E1E),
                    ),
                  ),

                  // New Password TextField
                  const SizedBox(height: 130),
                  Container(
                    //width: 283,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5E5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter New Password',
                        hintStyle: TextStyle(
                          color: Color(0xFF7D7777),
                          fontSize: 20,
                          fontFamily: 'Heebo',
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // Confirm Password TextField
                  const SizedBox(height: 18),
                  Container(
                    //width: 283,
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5E5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Enter Confirm Password',
                        hintStyle: TextStyle(
                          color: Color(0xFF7D7777),
                          fontSize: 20,
                          fontFamily: 'Heebo',
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // Change Password Button
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () {
                      forgetPassword();
                    },
                    child: Container(
                      width: 276,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF32983E),
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: const Center(
                        child: Text(
                          'Change Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Heebo',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //Back to Signin
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          backToSignIn();
                        },
                        child: const Text(
                          'Back to Signin',
                          style: TextStyle(
                            color: Color.fromARGB(204, 117, 110, 2),
                            fontSize: 16,
                            fontFamily: 'Heebo',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void backToSignIn() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void forgetPassword() {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      CommonComponent.CreateToast("Confirm password should be match.");
    } else {
      FirebaseServices.forgotPassword(widget.email);
      CommonComponent.CreateAlert(context, "Reset Password",
          "Check your mail for reset password", GotoLoginPage);
    }
  }

  void GotoLoginPage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginScreen()));
  }
}

import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/ForgetPasswordScreen.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  static var isStudent;

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //static bool isStudent = false;

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
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF1E1E1E),
                      fontFamily: 'Jaro',
                    ),
                  ),

                  // Email TextField
                  const SizedBox(height: 143),
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5E5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        hintText: 'Enter Email',
                        hintStyle: TextStyle(
                          color: Color(0xFF7D7777),
                          fontSize: 20,
                          fontFamily: 'Heebo',
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  // Password TextField
                  const SizedBox(height: 18),
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5E5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(
                          color: Color(0xFF7D7777),
                          fontSize: 20,
                          fontFamily: 'Heebo',
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  //Forget Password
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          forgetPasswordMethod();
                        },
                        child: const Text(
                          'Forget password',
                          style: TextStyle(
                            color: Color.fromARGB(204, 117, 110, 2),
                            fontSize: 16,
                            fontFamily: 'Heebo',
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Login Button
                  const SizedBox(height: 17),
                  SizedBox(
                    width: 276,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        loginMethod();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF32983E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(23),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Heebo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  //Don't have an account?
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Heebo',
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          signupMethod();
                        },
                        child: const Text(
                          " SignUp",
                          style: TextStyle(
                            color: Color.fromARGB(204, 117, 110, 2),
                            fontSize: 16,
                            fontFamily: 'Heebo',
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginMethod() {
    // ignore: unrelated_type_equality_checks
    if (_emailController.text == "abc" && _passwordController.text == "abc") {
      LoginScreen.isStudent = true;
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } else {
      LoginScreen.isStudent = false;
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  void signupMethod() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const SignupScreen()));
  }

  void forgetPasswordMethod() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const ForgetPasswordScreen()));
  }
}

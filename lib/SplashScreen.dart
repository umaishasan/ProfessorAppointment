import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false);
    });

    super.initState();
  }

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

          // Content Column
          Column(
            children: [
              const SizedBox(height: 99),

              // Logo
              Center(
                child: Image.asset(
                  'assets/splash_screen.png',
                ),
              ),

              const SizedBox(height: 37),

              // Make Study Easy Text
              const Text(
                'Make Study Easy',
                style: TextStyle(
                  fontFamily: 'Herr Von Muellerhoff',
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(),

              // Footer Text
              const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Text(
                  'Design & Develop by Your Team',
                  style: TextStyle(
                    fontFamily: 'Heebo',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

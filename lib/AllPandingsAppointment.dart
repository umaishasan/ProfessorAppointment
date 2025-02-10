import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AppointmentPandingScreen.dart';

class AllPandingAppointmentScreen extends StatefulWidget {
  const AllPandingAppointmentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AllPandingAppointmentScreenState createState() =>
      _AllPandingAppointmentScreenState();
}

class _AllPandingAppointmentScreenState
    extends State<AllPandingAppointmentScreen> {
  bool isPending = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Appointment Card
        Container(
          margin: const EdgeInsets.all(9),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://dashboard.codeparrot.ai/api/image/Z6mXXYcVzJUvTtx8/user-imag.png'),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Carlos Shawn',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Student',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Request For Appointment',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  CheckingAppointment(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF32983E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 30),
                ),
                child: const Text(
                  'Check Appointment >',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSwitchTab(String text, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isPending = text == 'Pending';
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isActive ? Colors.black : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Heebo',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void CheckingAppointment(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const PendingScreen()));
  }
}

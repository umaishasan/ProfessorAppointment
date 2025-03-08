import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myacademicappointment/AppointmentPandingScreen.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/Models/Appointment.dart';
import 'package:myacademicappointment/Models/Person.dart';

class AllPandingAppointmentScreen extends StatefulWidget {
  const AllPandingAppointmentScreen({super.key, required this.appointment});
  final Appointment appointment;

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
    var prson = Provider.of<Person>(context);
    return Column(
      children: [
        // Appointment Card
        Container(
          margin: const EdgeInsets.all(9),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Light shadow
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 4), // Position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CommonComponent.ImageAvatar(context, prson.UserImage, 60, 60),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.appointment.Name,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.appointment.User,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
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
                  minimumSize: const Size(double.infinity, 40),
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
        context,
        MaterialPageRoute(
            builder: (_) => PendingScreen(appointment: widget.appointment)));
  }
}

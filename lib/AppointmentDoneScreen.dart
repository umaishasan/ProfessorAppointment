import 'package:flutter/material.dart';

class DoneAppointmentScreen extends StatelessWidget {
  final String doctorName;

  const DoneAppointmentScreen({
    super.key,
    this.doctorName = 'Carlos Shawn',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Appointment status card
        Container(
          margin: const EdgeInsets.only(top: 13, left: 8, right: 8),
          padding: const EdgeInsets.all(8),
          width: 377,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            'Your appointment with $doctorName was \nsuccessful.',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              fontStyle: FontStyle.italic,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

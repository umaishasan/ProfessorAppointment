import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Models/Appointment.dart';

class DoneAppointmentScreen extends StatelessWidget {
  late Appointment appointment;
  DoneAppointmentScreen({
    super.key,
    required this.appointment,
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
            'Your appointment had approved with ${appointment.Name} on ${appointment.DateTimes}.',
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

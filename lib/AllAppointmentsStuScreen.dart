import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholappoinment_934074496/AppointmentBookingScreen.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Models/Person.dart';
import 'package:scholappoinment_934074496/Models/Schedule.dart';

class AllAppointmentStuScreen extends StatefulWidget {
  const AllAppointmentStuScreen({super.key, required this.schedule});
  final Schedule schedule;

  @override
  State<AllAppointmentStuScreen> createState() =>
      _AllAppointmentStuScreenState();
}

class _AllAppointmentStuScreenState extends State<AllAppointmentStuScreen> {
  bool isBooking = true;

  @override
  Widget build(BuildContext context) {
    var prson = Provider.of<Person>(context);
    return Column(
      children: [
        // Appointment Card
        Container(
          margin: const EdgeInsets.all(9),
          padding: const EdgeInsets.all(15),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              CommonComponent.ImageAvatar(context, prson.UserImage, 70, 70),
              const SizedBox(width: 15),

              // Info and Button Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.schedule.Name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.schedule.Qualification,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.schedule.Status,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    ShowButton(widget.schedule.Status)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ShowButton(String status) {
    if (status == "Available") {
      return ElevatedButton(
        onPressed: () {
          GotoAppointmentScreen(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF32983E),
          minimumSize: const Size(266, 30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text(
          'Book Appointment >',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  void GotoAppointmentScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BookingScreen(
                  schedule: widget.schedule,
                )));
  }
}

import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AppointmentBookingScreen.dart';
import 'package:scholappoinment_934074496/Models/Schedule.dart';
import 'package:scholappoinment_934074496/SetScheduleScreen.dart';

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
    return Column(
      children: [
        // Appointment Card
        Container(
          margin: const EdgeInsets.all(9),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://dashboard.codeparrot.ai/api/image/Z6mJ6vrycnbNR_jj/user-imag.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
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
                    ElevatedButton(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void GotoAppointmentScreen(BuildContext context) {
    for (var element in SetScheduleScreen.scheduleDateData) {
      print("Kia data hai list me? ${element}");
    }

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BookingScreen(
                  schedule: widget.schedule,
                )));
  }
}

import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AppointmentScreenStu.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/Models/Schedule.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen(
      {super.key, required this.scheduleList, required this.schedule});
  final List<Schedule> scheduleList;
  final Schedule schedule;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonComponent.AppBarCreator(context, "Booking", Icons.arrow_back,
              () => BackToAppointmentScreen(context)),
          Center(
            child:
                // Main content
                Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Profile card
                      Container(
                        width: 352,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 105, 55, 55),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            const CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(
                                  'https://dashboard.codeparrot.ai/api/image/Z6Xs4qQDH3ZYFIaL/user-imag.png'),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.schedule.Name,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.schedule.Qualification,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Appointment info
                            Container(
                              width: 284,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Appointment',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Information',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Any query you can ask at that time,\nand share do document which is related to your topics.',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Schedule
                            Container(
                              width: 284,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Schedule',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Select Time & Date',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.arrow_back_ios,
                                            size: 12),
                                        onPressed: selectPrevious,
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            widget.schedule
                                                .DateTimes[currentIndex]
                                                .split(
                                                    ' at ')[1], // Extract time
                                            style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 13),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            widget.schedule
                                                .DateTimes[currentIndex]
                                                .split(
                                                    ' at ')[0], // Extract date
                                            style: const TextStyle(
                                                fontFamily: 'Inter',
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12),
                                        onPressed: selectNext,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Confirm button
                      ElevatedButton(
                        onPressed: () {
                          BookedAppointment(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF32983E),
                          minimumSize: const Size(276, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Heebo',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void selectPrevious() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      }
    });
  }

  void selectNext() {
    setState(() {
      if (currentIndex < widget.schedule.DateTimes.length - 1) {
        currentIndex++;
      }
    });
  }

  // ignore: non_constant_identifier_names
  void BookedAppointment(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  // ignore: non_constant_identifier_names
  void BackToAppointmentScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                AppointmentScreenStu(scheduleList: widget.scheduleList)));
  }
}

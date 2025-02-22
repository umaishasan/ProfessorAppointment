import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AppointmentScreenStu.dart';
import 'package:scholappoinment_934074496/Models/Appointment.dart';

class BookedScreen extends StatelessWidget {
  BookedScreen({super.key, required this.appointment});
  late Appointment appointment;

  @override
  Widget build(BuildContext context) {
    String checkAppointStatus =
        appointment.Accept == true ? "Booked" : "Panding";
    return Column(
      children: [
        // Appointment Card
        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://dashboard.codeparrot.ai/api/image/Z6XuIqQDH3ZYFIaM/user-imag.png'),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointment.TeacherName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        appointment.TeacherQualification,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 15),
                  const SizedBox(width: 3),
                  Text(
                    appointment.DateTimes,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD0D0D0),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        checkAppointStatus,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  //cancle button
                  GestureDetector(
                    onTap: () {
                      //Navigator.pop(context, 0);
                      //CancleToGoBack(context);
                    },
                    child: Container(
                      width: 150,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFF32983E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // void CancleToGoBack(BuildContext context) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (_) => const AppointmentScreenStu()));
  // }
}

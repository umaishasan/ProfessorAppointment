import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/Models/Appointment.dart';
import 'package:scholappoinment_934074496/Models/Person.dart';

class BookedScreen extends StatelessWidget {
  BookedScreen({super.key, required this.appointment});
  late Appointment appointment;

  @override
  Widget build(BuildContext context) {
    var prson = Provider.of<Person>(context);
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
              //Profile Info
              Row(
                children: [
                  CommonComponent.ImageAvatar(context, prson.UserImage, 60, 60),
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

              //Time info
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

              //button booked/panding

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
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
                  ),

                  //cancle button
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.pop(context, 0);
                        CancleToGoBack(context, appointment.DocId);
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
                            ),
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

  void CancleToGoBack(BuildContext context, String docId) {
    FirebaseServices.DeleteAppointment(docId).then((_) {
      Navigator.pop(context, 1);
    });
  }
}

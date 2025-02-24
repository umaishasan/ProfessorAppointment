import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AppointmentScreenProf.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/Models/Appointment.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key, required this.appointment});
  final Appointment appointment;

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CommonComponent.AppBarCreator(context, "Panding", Icons.arrow_back,
              () => BackToAppointmentPage(context)),
          Column(
            children: [
              const SizedBox(height: 41),

              // Main content card
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                  children: [
                    const SizedBox(height: 23),
                    // Profile image
                    CommonComponent.ImageAvatar("", 70, 70),
                    const SizedBox(height: 12),
                    Text(
                      widget.appointment.Name,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.appointment.User,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Appointment details
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          SizedBox(height: 17),
                          Text(
                            'Information',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            'I have some questions and I want to meet you. Can I meet you at that time?',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Schedule
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Time & Date',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time, size: 15),
                                    const SizedBox(width: 8),
                                    Text(
                                      widget.appointment.DateTimes,
                                      style: const TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              //both button action & cancle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Action buttons
                    ElevatedButton(
                      onPressed: () {
                        AcceptAppointment(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF32983E),
                        minimumSize: const Size(150, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),

                    //cancla button
                    ElevatedButton(
                      onPressed: () {
                        CancleAppointment(context, widget.appointment.DocId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF32983E),
                        minimumSize: const Size(150, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
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
          ),
        ],
      ),
    );
  }

  //Navigate to the AppointmentPage
  void BackToAppointmentPage(BuildContext context) {
    Navigator.pop(context, 1);
  }

  //when click to accept button then it will accept appointment
  void AcceptAppointment(BuildContext context) {
    FirebaseServices.AcceptAppointment(widget.appointment.Id, true);
    print(
        "Before => Id: ${widget.appointment.Id}, Accpr: ${widget.appointment.Accept}");

    Navigator.pop(context, 2);
  }

  // ignore: non_constant_identifier_names
  void CancleAppointment(BuildContext context, String docId) {
    FirebaseServices.DeleteAppointment(docId).then((_) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AppointmentScreenProf(
                  appointmentList: AppointmentScreenProf.tempStoreAppoint)));
    });
  }
}

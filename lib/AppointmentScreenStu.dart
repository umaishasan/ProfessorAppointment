import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AllAppointmentsStuScreen.dart';
import 'package:scholappoinment_934074496/AppointmentBookedScreen.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/Models/Appointment.dart';
import 'package:scholappoinment_934074496/Models/Schedule.dart';

class AppointmentScreenStu extends StatefulWidget {
  AppointmentScreenStu(
      {super.key, required this.scheduleList, required this.appointmentList});
  final List<Schedule> scheduleList;
  late List<Appointment> appointmentList;

  @override
  State<AppointmentScreenStu> createState() => AppointmentScreenStuState();
}

class AppointmentScreenStuState extends State<AppointmentScreenStu>
    with SingleTickerProviderStateMixin {
  bool isBooking = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background design ellipse
          Positioned(
            top: -18,
            left: -660,
            child: Container(
              width: 1027,
              height: 1701,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(73, 100, 188, 71),
              ),
            ),
          ),

          //Tabbar view
          TabBarView(controller: _tabController, children: [
            Center(
              child: AllAppointments(),
            ),
            Center(
              child: AllBookedAppointments(),
            )
          ])
        ],
      ),

      //App bar and its tab view
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => GotoHome(context),
            icon: const Icon(Icons.arrow_back)),
        title: const Text("Appointment"),
        bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            indicatorWeight: 2.0,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            dividerColor: Colors.grey,
            tabs: const [
              Tab(text: "Booking"),
              Tab(
                text: "Booked",
              )
            ]),
      ),
    );
  }

  //back button to go home
  void GotoHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  Widget AllAppointments() {
    setState(() {
      CommonComponent.scheduleList = widget.scheduleList;
    });
    return ListView.builder(
      itemCount: widget.scheduleList.length,
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var schedule = widget.scheduleList[index];
        return AllAppointmentStuScreen(schedule: schedule);
      },
    );
  }

  Widget AllBookedAppointments() {
    // print("how amny appointment? ${widget.appointmentList.length}");
    // print(
    //     "Fetched Appointments: ${widget.appointmentList.map((e) => e.Id).toList()}");
    return ListView.builder(
      itemCount: widget.appointmentList.length,
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var appointment = widget.appointmentList[index];
        if (FirebaseServices.Auth.currentUser!.uid == appointment.Id) {
          return BookedScreen(appointment: appointment);
        }
        return SizedBox.shrink();
      },
    );
  }
}

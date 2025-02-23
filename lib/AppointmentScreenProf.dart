import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AllPandingsAppointment.dart';
import 'package:scholappoinment_934074496/AppointmentDoneScreen.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/Models/Appointment.dart';

class AppointmentScreenProf extends StatefulWidget {
  const AppointmentScreenProf({super.key, required this.appointmentList});
  final List<Appointment> appointmentList;
  static late List<Appointment> tempStoreAppoint;

  @override
  State<AppointmentScreenProf> createState() => AppointmentScreenProfState();
}

class AppointmentScreenProfState extends State<AppointmentScreenProf>
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
              child: AllPandingAppointments(),
            ),
            Center(
              child: AllDoneAppointments(),
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
              Tab(text: "Panding"),
              Tab(
                text: "Done",
              )
            ]),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void GotoHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  Widget AllPandingAppointments() {
    //AppointmentScreenProf.tempStoreAppoint = widget.appointmentList;
    //print("how amny appointment? ${widget.appointmentList.length}");
    //print(
    //   "Fetched Appointments: ${widget.appointmentList.map((e) => e.Id).toList()}");
    return ListView.builder(
      itemCount: widget.appointmentList.length,
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var appointment = widget.appointmentList[index];
        if (FirebaseServices.Auth.currentUser!.uid == appointment.TeacherId) {
          if (appointment.Accept == true) {
            return SizedBox.shrink();
          } else {
            return AllPandingAppointmentScreen(appointment: appointment);
          }
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget AllDoneAppointments() {
    //AppointmentScreenProf.tempStoreAppoint = widget.appointmentList;
    return ListView.builder(
      itemCount: widget.appointmentList.length,
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var appointment = widget.appointmentList[index];
        if (FirebaseServices.Auth.currentUser!.uid == appointment.TeacherId) {
          if (appointment.Accept == true) {
            return DoneAppointmentScreen(appointment: appointment);
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}

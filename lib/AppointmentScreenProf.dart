import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/AllPandingsAppointment.dart';
import 'package:scholappoinment_934074496/AppointmentDoneScreen.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';

class AppointmentScreenProf extends StatefulWidget {
  const AppointmentScreenProf({super.key});

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
          TabBarView(controller: _tabController, children: const [
            Center(
              child: AllPandingAppointmentScreen(),
            ),
            Center(
              child: DoneAppointmentScreen(),
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
}

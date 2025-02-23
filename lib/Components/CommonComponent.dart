import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/Models/Appointment.dart';
import 'package:scholappoinment_934074496/Models/Messaging.dart';
import 'package:scholappoinment_934074496/Models/Schedule.dart';

class CommonComponent extends StatelessWidget {
  const CommonComponent({super.key});

  static late Schedule schedule;
  static late Appointment appointment;
  static late Messaging messaging;

  static late List<Messaging> messagesList;
  static late List<Schedule> scheduleList;
  static late List<Appointment> appointmentList;

  // ignore: non_constant_identifier_names
  static Widget AppBarCreator(BuildContext context, String appBarTitle,
      IconData iconName, VoidCallback onPressed) {
    return Scaffold(
      body: Stack(
        children: [
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
        ],
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: onPressed, icon: Icon(iconName)),
        title: Text(appBarTitle),
      ),
    );
  }

  static void BacktoHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  static String FetchTiming(BuildContext context, String time) {
    final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    var timeFormat = TimeOfDay.fromDateTime(date).format(context);
    return timeFormat;
  }

  static Widget ImageAvatar(String imageUrl, double width, double height) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => const CircleAvatar(
        child: Icon(CupertinoIcons.person),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

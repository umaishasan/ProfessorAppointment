import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';

class CommonComponent extends StatelessWidget {
  const CommonComponent({super.key});

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

  // when any warning or any message system related then you can see in bar
  static void CreateToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.NONE,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 12,
      timeInSecForIosWeb: 2,
    );
  }

  static void CreateAlert(BuildContext context, String titleAlert,
      String content, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(titleAlert),
          contentPadding: EdgeInsets.all(20.0),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

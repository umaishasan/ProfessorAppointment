import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Components/DateComponent.dart';
import 'package:scholappoinment_934074496/Components/TimeComponent.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/main.dart';

class SetScheduleScreen extends StatefulWidget {
  const SetScheduleScreen({
    super.key,
  });
  static List<String> scheduleDateData = [];

  @override
  State<SetScheduleScreen> createState() => _SetScheduleScreenState();
}

class _SetScheduleScreenState extends State<SetScheduleScreen> {
  String completeDateTime = '';
  String AvailableText = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    screenSizeCommon = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        CommonComponent.AppBarCreator(context, "Set Schedule", Icons.arrow_back,
            () => CommonComponent.BacktoHome(context)),

        Card(
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 110, bottom: 250),
          color: Colors.white,
          elevation: 3,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSizeCommon.width * 0.01,
                vertical: screenSizeCommon.height * 0.01),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _checkAvailablityToShowDatetime(),
                  _buildAvailableToggles(),
                ],
              ),
            ),
          ),
        ),
        ShowSchedule(),
        // both Button
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 540),
          child: Center(
            child: Column(
              children: [
                showButton(),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget showButton() {
    List<Widget> buttons = [];

    if (AvailableText == "Available") {
      // Add schedule Button
      buttons.add(createButton("Add Schedule", () => _addSchedule()));
      // Set schedule Button
      buttons.add(createButton("Set Schedule", () => setSchedule()));
    } else {
      // Set schedule Button
      buttons.add(createButton("Set Schedule", () => setSchedule()));
    }

    return Column(
      children: buttons,
    );
  }

  Widget createButton(String buttonName, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF32983E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23),
        ),
      ),
      child: Text(
        buttonName,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontFamily: 'Heebo',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _addSchedule() {
    String time = SetTimeComponent.scheduleTime;
    String date = SetDateComponent.scheduleDate;
    completeDateTime = "$date at $time";

    setState(() {
      SetScheduleScreen.scheduleDateData.add(completeDateTime);
    });
  }

  Widget ShowSchedule() {
    if (AvailableText == "Available") {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(left: 40, top: 670, right: 40),
          color: Colors.white,
          width: 400,
          height: 200,
          child: ShowDateOfSchedules(SetScheduleScreen.scheduleDateData),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget ShowDateOfSchedules(List<String> datesTimes) {
    return ListView.builder(
      itemCount: datesTimes.length,
      padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5, left: 5),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var showDate = datesTimes[index];
        //print(showDate);
        return Text(showDate);
      },
    );
  }

  Widget _buildAvailableToggles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAvailabilityToggleOption("Available"),
            const SizedBox(width: 16),
            _buildAvailabilityToggleOption("Not Available"),
          ],
        ),
      ],
    );
  }

  Widget _checkAvailablityToShowDatetime() {
    if (AvailableText == "Available") {
      return SetTimeComponent();
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildAvailabilityToggleOption(String available) {
    return GestureDetector(
      onTap: () {
        setState(() {
          AvailableText = available;
        });
        //print("Selected Availability: $AvailableText");
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color:
                  AvailableText == available ? Colors.green : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
          const SizedBox(width: 8),
          Text(available, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void setSchedule() {
    if (AvailableText == "Not Available") {
      SetScheduleScreen.scheduleDateData = [];
      FirebaseServices.SetSchedule([], AvailableText)
          .then((_) => CommonComponent.BacktoHome(context));
    } else {
      FirebaseServices.SetSchedule(
              SetScheduleScreen.scheduleDateData, AvailableText)
          .then((_) => CommonComponent.BacktoHome(context));
    }
  }
}

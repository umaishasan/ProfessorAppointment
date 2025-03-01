import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Components/DateComponent.dart';
import 'package:scholappoinment_934074496/Components/TimeComponent.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
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
            margin: const EdgeInsets.only(
                left: 10, right: 10, top: 100, bottom: 250),
            color: Colors.white,
            elevation: 3,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSizeCommon.width * 0.01,
                    vertical: screenSizeCommon.height * 0.01),
                child: SingleChildScrollView(
                  child: Column(children: [
                    _checkAvailablityToShowDatetime(),
                    _buildAvailableToggles(),
                  ]),
                ))),

        // both Button
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 340),
            child: Center(
                child: Row(
              children: [
                // Set schedule Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setSchedule();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF32983E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    child: const Text(
                      'Set Schedule',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Heebo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                //Add schedule button
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _addSchedule();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF32983E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    child: const Text(
                      'Add Schedule',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Heebo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            )))
      ]),
    );
  }

  void _addSchedule() {
    String time = SetTimeComponent.scheduleTime;
    String date = SetDateComponent.scheduleDate;
    completeDateTime = "$date at $time";
    SetScheduleScreen.scheduleDateData.add(completeDateTime);

    for (var element in SetScheduleScreen.scheduleDateData) {
      print(element);
    }
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
    FirebaseServices.SetSchedule(
            SetScheduleScreen.scheduleDateData, AvailableText)
        .then((_) => CommonComponent.BacktoHome(context));
  }
}

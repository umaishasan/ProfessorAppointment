import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Components/TimeComponent.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/main.dart';

class SetScheduleScreen extends StatefulWidget {
  final bool initialAvailability;

  const SetScheduleScreen({
    super.key,
    this.initialAvailability = false,
  });

  @override
  State<SetScheduleScreen> createState() => _SetScheduleScreenState();
}

class _SetScheduleScreenState extends State<SetScheduleScreen> {
  late bool _isAvailable;
  String AvailableText = "";

  @override
  void initState() {
    super.initState();
    _isAvailable = widget.initialAvailability;
  }

  void _toggleAvailability(bool isTrue) {
    //setState(() {
    _isAvailable = isTrue;
    //});
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
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenSizeCommon.width * 0.01,
                    vertical: screenSizeCommon.height * 0.01),
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SetTimeComponent(),
                    _buildAvailableToggles(),
                    //AvailbilityToggle(_isAvailable),
                  ]),
                ))),

        // Set schedule Button
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 340),
            child: Center(
              child: SizedBox(
                width: 276,
                height: 50,
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
                    'Setschedule',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Heebo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ))
      ]),
    );
  }

  // ignore: non_constant_identifier_names
  // Widget AvailbilityToggle(bool isAvailable) {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 10, right: 10, top: 50),
  //     child: Center(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           GestureDetector(
  //             onTap: () => _toggleAvailability(true),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   width: 20,
  //                   height: 20,
  //                   decoration: BoxDecoration(
  //                     color: isAvailable
  //                         ? const Color(0xFF32983E)
  //                         : const Color(0xFFD9D9D9),
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 5),
  //                 const Text(
  //                   'Available',
  //                   style: TextStyle(
  //                     fontFamily: 'Heebo',
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.w400,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const SizedBox(width: 38),
  //           GestureDetector(
  //             onTap: () => _toggleAvailability(false),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   width: 20,
  //                   height: 20,
  //                   decoration: BoxDecoration(
  //                     color: !isAvailable
  //                         ? const Color(0xFF32983E)
  //                         : const Color(0xFFD9D9D9),
  //                     borderRadius: BorderRadius.circular(4),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 5),
  //                 const Text(
  //                   'Not Available',
  //                   style: TextStyle(
  //                     fontFamily: 'Heebo',
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.w400,
  //                     color: Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAvailableToggles() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGenderToggleOption("Available"),
            const SizedBox(width: 16),
            _buildGenderToggleOption("Not Available"),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderToggleOption(String gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          AvailableText = gender;
        });
        print("Selected Gender: $AvailableText");
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AvailableText == gender ? Colors.green : Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
          const SizedBox(width: 8),
          Text(gender, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void setSchedule() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }
}

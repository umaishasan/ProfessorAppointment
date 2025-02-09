import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/TimeComponent.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';

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
    return Scaffold(
      // Background ellipse
      body: Stack(children: [
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

        // Header
        Container(
          height: 66,
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                left: 11,
                top: 23,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 22),
                ),
              ),
              const Center(
                child: Text(
                  'Set Schedule',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1E1E1E),
                  ),
                ),
              ),
            ],
          ),
        ),

        Card(
            margin: const EdgeInsets.only(
                left: 10, right: 10, top: 80, bottom: 250),
            color: Colors.white,
            child: Column(children: [
              const SetTimeComponent(),
              AvailbilityToggle(_isAvailable),
            ])),

        // Set schedule Button
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 540),
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
  Widget AvailbilityToggle(bool isAvailable) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _toggleAvailability(true),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? const Color(0xFF32983E)
                          : const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Available',
                    style: TextStyle(
                      fontFamily: 'Heebo',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 38),
            GestureDetector(
              onTap: () => _toggleAvailability(false),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: !isAvailable
                          ? const Color(0xFF32983E)
                          : const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Not Available',
                    style: TextStyle(
                      fontFamily: 'Heebo',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setSchedule() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }
}

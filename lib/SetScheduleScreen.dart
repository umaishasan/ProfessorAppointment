import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/TimeComponent.dart';

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
              color: Color(0x4D16442C),
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

        //Time
        const SetTimeComponent(),

        //AvailbilityToggle(_isAvailable)
      ]),
    );
  }

  Widget AvailbilityToggle(bool _isAvailable) {
    //return LayoutBuilder(
    //builder: (context, constraints) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Status',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _toggleAvailability(true),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: _isAvailable
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
                        color: !_isAvailable
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
        ],
      ),
    );
    //},
    //);
  }
}

// ignore: non_constant_identifier_names

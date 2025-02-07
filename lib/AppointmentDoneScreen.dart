import 'package:flutter/material.dart';

class DoneAppointmentScreen extends StatelessWidget {
  final String doctorName;

  const DoneAppointmentScreen({
    Key? key,
    this.doctorName = 'Carlos Shawn',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background ellipse
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

          // Main content
          Column(
            children: [
              // Header
              Container(
                height: 64,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.network(
                        'https://dashboard.codeparrot.ai/api/image/Z6Xu0cNJMVoCouCq/vector.png',
                        width: 22,
                        height: 21,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            fontFamily: 'Jaro',
                            fontSize: 36,
                            color: Color(0xFF1E1E1E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Appointment status card
              Container(
                margin: const EdgeInsets.only(top: 13, left: 8, right: 8),
                padding: const EdgeInsets.all(8),
                width: 377,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Your appointment with $doctorName was \nsuccessful.',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

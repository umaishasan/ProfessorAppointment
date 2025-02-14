import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/DiscussionScreen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.only(top: 65, left: 10, right: 10),
        children: const [
          // Incoming message
          IncomingMessage(
            senderName: 'Maria Jason',
            message: 'Hey! How are you?\nAre you Fine?',
            time: '09:00 AM',
            imageUrl:
                'https://dashboard.codeparrot.ai/api/image/Z68w_-epongUSRix/user-imag.png',
          ),

          // Outgoing message
          SizedBox(height: 16),
          OutgoingMessage(
            senderName: 'Carlos Shawn',
            message: 'Hey! yeah yeah I\'m fine.\nyou tell me how are you?',
            time: '09:00 AM',
            imageUrl:
                'https://dashboard.codeparrot.ai/api/image/Z68w_-epongUSRix/user-imag-2.png',
          ),
        ],
      ),
    );
  }
}

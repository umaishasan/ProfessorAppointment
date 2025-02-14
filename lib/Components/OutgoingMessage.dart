import 'package:flutter/material.dart';

class OutgoingMessage extends StatelessWidget {
  final String senderName;
  final String message;
  final String time;
  final String imageUrl;

  const OutgoingMessage({
    super.key,
    this.senderName = 'Carlos Shawn',
    this.message = 'Hey! yeah yeah I\'m fine.\nyou tell me how are you?',
    this.time = '09:00 AM',
    this.imageUrl =
        'https://dashboard.codeparrot.ai/api/image/Z68w_-epongUSRix/user-imag-2.png',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFEBEDF0),
            borderRadius: BorderRadius.circular(11),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                senderName,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w100,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 22.5,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ],
    );
  }
}

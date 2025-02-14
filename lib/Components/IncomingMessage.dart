import 'package:flutter/material.dart';

class IncomingMessage extends StatelessWidget {
  final String senderName;
  final String message;
  final String time;
  final String imageUrl;

  const IncomingMessage({
    super.key,
    this.senderName = 'Maria Jason',
    this.message = 'Hey! How are you?\nAre you Fine?',
    this.time = '09:00 AM',
    this.imageUrl =
        'https://dashboard.codeparrot.ai/api/image/Z68w_-epongUSRix/user-imag.png',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22.5,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF34C759),
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
                const SizedBox(height: 2),
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
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/Components/Messages.dart';
import 'package:scholappoinment_934074496/main.dart';

class DiscussionScreen extends StatelessWidget {
  const DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    screenSizeCommon = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          //App bar and background design
          CommonComponent.AppBarCreator(
              context, "Discussion", Icons.arrow_back, () => GotoHome(context)),

          Column(
            children: [
              //show all messages
              const Expanded(
                child: Row(
                  children: [
                    MessageScreen(),
                  ],
                ),
              ),

              // Message input
              ChatInput(),
            ],
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void GotoHome(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  // ignore: non_constant_identifier_names
  Widget ChatInput() {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenSizeCommon.width * 0.01,
            vertical: screenSizeCommon.height * 0.01),
        child: Row(
          children: [
            //Input type message
            Expanded(
              child: Card(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //send message button
            IconButton(
              padding: const EdgeInsets.all(5),
              icon: const Icon(Icons.send),
              onPressed: () {},
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ));
  }
}

class IncomingMessage extends StatelessWidget {
  final String senderName;
  final String message;
  final String time;
  final String imageUrl;

  const IncomingMessage({
    super.key,
    required this.senderName,
    required this.message,
    required this.time,
    required this.imageUrl,
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
        Container(
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
              const SizedBox(height: 4),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
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
      ],
    );
  }
}

class OutgoingMessage extends StatelessWidget {
  final String senderName;
  final String message;
  final String time;
  final String imageUrl;

  const OutgoingMessage({
    super.key,
    required this.senderName,
    required this.message,
    required this.time,
    required this.imageUrl,
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
              const SizedBox(height: 4),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
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

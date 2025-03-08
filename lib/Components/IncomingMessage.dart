import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/Models/Person.dart';

class IncomingMessage extends StatelessWidget {
  late String senderName;
  late String messageUser;
  late String messageTime;
  final String imageUrl;

  IncomingMessage(
      {super.key,
      required this.senderName,
      required this.messageUser,
      required this.messageTime,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var prson = Provider.of<Person>(context);
    return Card(
      color: const Color.fromARGB(0, 0, 0, 0),
      elevation: 0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonComponent.ImageAvatar(context, prson.UserImage, 50, 50),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 200),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF34C759),
                borderRadius: BorderRadius.circular(11),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey
                        .withOpacity(0.5), // Shadow color with opacity
                    spreadRadius: 2, // Spread of the shadow
                    blurRadius: 5, // Blur effect
                    offset: const Offset(2, 4), // Shadow position (x, y)
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Sender Name
                  Text(
                    senderName,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  //messages
                  const SizedBox(height: 2),
                  Text(
                    messageUser,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                    ),
                  ),

                  //message time
                  const SizedBox(height: 2),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      messageTime,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w100,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/Components/IncomingMessage.dart';
import 'package:myacademicappointment/Components/OutgoingMessage.dart';
import 'package:myacademicappointment/Firebase/FirebaseServices.dart';
import 'package:myacademicappointment/Models/Messaging.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({super.key, required this.messaging});

  late Messaging messaging;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return FirebaseServices.Auth.currentUser!.uid == widget.messaging.Id
        ? YoursMessages()
        : OthersMessages();
  }

  Widget OthersMessages() {
    // print(
    //     "Message Screen => Their name: ${widget.messaging.Name}, Their image: ${widget.messaging.UserImage}");
    String url = widget.messaging.UserImage;
    return IncomingMessage(
        senderName: widget.messaging.Name,
        messageUser: widget.messaging.Message,
        imageUrl: url,
        messageTime:
            CommonComponent.FetchTiming(context, widget.messaging.MesageTime));
  }

  Widget YoursMessages() {
    // print(
    //     "Message screen => Your name: ${widget.messaging.Name}, Your image: ${widget.messaging.UserImage}");
    return OutgoingMessage(
        yourName: widget.messaging.Name,
        messageUser: widget.messaging.Message,
        imageUrl: widget.messaging.UserImage,
        messageTime:
            CommonComponent.FetchTiming(context, widget.messaging.MesageTime));
  }
}

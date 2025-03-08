import 'package:flutter/material.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/Components/IncomingMessage.dart';
import 'package:myacademicappointment/Components/OutgoingMessage.dart';
import 'package:myacademicappointment/Firebase/FirebaseServices.dart';
import 'package:myacademicappointment/Models/Messaging.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key, required this.messaging});

  final Messaging messaging;

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
    return IncomingMessage(
        senderName: widget.messaging.Name,
        messageUser: widget.messaging.Message,
        imageUrl: widget.messaging.UserImage,
        messageTime:
            CommonComponent.FetchTiming(context, widget.messaging.MesageTime));
  }

  Widget YoursMessages() {
    return OutgoingMessage(
        yourName: widget.messaging.Name,
        messageUser: widget.messaging.Message,
        imageUrl: widget.messaging.UserImage,
        messageTime:
            CommonComponent.FetchTiming(context, widget.messaging.MesageTime));
  }
}

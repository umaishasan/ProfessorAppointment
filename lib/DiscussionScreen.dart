import 'package:flutter/material.dart';
import 'package:myacademicappointment/Components/CommonComponent.dart';
import 'package:myacademicappointment/Components/Messages.dart';
import 'package:myacademicappointment/Firebase/FirebaseServices.dart';
import 'package:myacademicappointment/Models/Messaging.dart';
import 'package:myacademicappointment/main.dart';

// ignore: must_be_immutable
class DiscussionScreen extends StatefulWidget {
  List<Messaging> userMessages;
  final Messaging messaging;
  DiscussionScreen(
      {super.key, required this.userMessages, required this.messaging});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  final TextEditingController _tyoeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenSizeCommon = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            //App bar and background design
            CommonComponent.AppBarCreator(context, "Discussion",
                Icons.arrow_back, () => GotoHome(context)),

            // Expanded(
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top * 2),
              child: Column(children: [
                //show all messages
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: AllMesages(),
                  ),
                ),
                ChatInput(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  //Back to home
  void GotoHome(BuildContext context) {
    CommonComponent.BacktoHome(context);
  }

  //write message
  Widget ChatInput() {
    return Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top * 0.03, bottom: 2.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //Input type message
            Expanded(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: _tyoeController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      //contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ),
            ),

            //send message button
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  SendMessage(widget.messaging, _tyoeController,
                      widget.messaging.UserImage);
                },
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            )
          ],
        ));
  }

  //show all messaging
  Widget AllMesages() {
    return ListView.builder(
      itemCount: widget.userMessages.length,
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        var messageUser = widget.userMessages[index];
        return MessageScreen(messaging: messageUser);
      },
    );
  }

  void SendMessage(
      Messaging messaging, TextEditingController type, String imageUrl) {
    if (type.text.isNotEmpty) {
      FirebaseServices.SendMessage(messaging, type.text, imageUrl);
      type.text = '';
      _fetchMessages();
    }
  }

  Future<void> _fetchMessages() async {
    FirebaseServices.GetAllMeassages().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Messaging> fetchedMessages =
            snapshot.docs.map((doc) => Messaging.fromJson(doc.data())).toList();
        setState(() {
          widget.userMessages = fetchedMessages;
          FirebaseServices.GetFirebaseMessagingToken();
        });
        //print("Fetched Messages: ${jsonEncode(messagesList)}");
      }
    });
  }
}

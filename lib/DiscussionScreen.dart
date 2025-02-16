import 'package:flutter/material.dart';
import 'package:scholappoinment_934074496/Components/CommonComponent.dart';
import 'package:scholappoinment_934074496/Components/Messages.dart';
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';
import 'package:scholappoinment_934074496/Models/Messaging.dart';
import 'package:scholappoinment_934074496/main.dart';

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

    return Scaffold(
      body: Stack(
        children: [
          //App bar and background design
          CommonComponent.AppBarCreator(
              context, "Discussion", Icons.arrow_back, () => GotoHome(context)),

          Column(
            children: [
              //show all messages
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 45, bottom: 10),
                child: AllMesages(),
              )),

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
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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
                        controller: _tyoeController,
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
              onPressed: () {
                SendMessage(widget.messaging, _tyoeController);
              },
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ],
        ));
  }

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

  void SendMessage(Messaging messaging, TextEditingController type) {
    if (type.text.isNotEmpty) {
      FirebaseServices.SendMessage(messaging, type.text);
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
        });
        //print("Fetched Messages: ${jsonEncode(messagesList)}");
      }
    });
  }
}

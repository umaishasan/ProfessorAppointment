import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:scholappoinment_934074496/Firebase/FirebaseServices.dart';
import 'package:scholappoinment_934074496/HomeScreen.dart';

class CommonComponent extends StatelessWidget {
  const CommonComponent({super.key});
  static File? userImage;
  static String? userImageUrl;
  static XFile? pickedFile;

  // ignore: non_constant_identifier_names
  static Widget AppBarCreator(BuildContext context, String appBarTitle,
      IconData iconName, VoidCallback onPressed) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -18,
            left: -660,
            child: Container(
              width: 1027,
              height: 1701,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(73, 100, 188, 71),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        leading: IconButton(onPressed: onPressed, icon: Icon(iconName)),
        title: Text(appBarTitle),
      ),
    );
  }

  static void BacktoHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  static String FetchTiming(BuildContext context, String time) {
    final date = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    var timeFormat = TimeOfDay.fromDateTime(date).format(context);
    return timeFormat;
  }

  static void CreateToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.NONE,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 12,
      timeInSecForIosWeb: 2,
    );
  }

  static void CreateAlert(BuildContext context, String titleAlert,
      String content, VoidCallback onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          title: Text(titleAlert),
          contentPadding: const EdgeInsets.all(20.0),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: onPressed,
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  static Widget ImageAvatar(
      BuildContext context, String imageUrls, double width, double height) {
    var mq = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(mq.height * 0.3),
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUrls,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const CircleAvatar(
          child: Icon(CupertinoIcons.person),
        ),
      ),
    );
  }

  static Future<void> PickImage() async {
    ImagePicker imagePick = ImagePicker();
    pickedFile = await imagePick.pickImage(source: ImageSource.gallery);
  }

  static Future<void> uploadImage(String id, String userNameImg) async {
    const String apiKey = "19b1963fdd29471fd33aec06974f5b19";
    const httpPath = "https://api.imgbb.com/1/upload?&key=$apiKey";
    final Uri uriPath = Uri.parse(httpPath);
    if (pickedFile != null) {
      final bytes = await pickedFile?.readAsBytes();
      print("Image picked successfully, byte size: ${bytes?.length}");
      var request = http.MultipartRequest('POST', uriPath);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        bytes as List<int>,
        filename: "$userNameImg.jpg",
      ));
      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          var responseJson = jsonDecode(value);
          String imageUrl = responseJson['data']['url'];
          FirebaseServices.UpdateUserImage(id, imageUrl);
          print("image url: ${userImageUrl}");
        });
      } else {
        print("Image failed to upload");
      }
    }
  }

  static String userImageLoad() {
    String imageUrl = userImageUrl!;
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

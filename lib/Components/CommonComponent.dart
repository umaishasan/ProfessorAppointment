import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:scholappoinment_934074496/HomeScreen.dart';

class CommonComponent extends StatelessWidget {
  CommonComponent({super.key});
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

  static Widget ImageAvatar(String imageUrl, double width, double height) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => const CircleAvatar(
        child: Icon(CupertinoIcons.person),
      ),
    );
  }

  static Future<void> PickImage() async {
    ImagePicker imagePick = ImagePicker();
    pickedFile = await imagePick.pickImage(source: ImageSource.gallery);
  }

  static Future<void> uploadImage(String userNameImg) async {
    final String apiKey = "19b1963fdd29471fd33aec06974f5b19";
    final httpPath =
        "https://api.imgbb.com/1/upload?expiration=1000&key=$apiKey";
    final Uri uriPath = Uri.parse(httpPath);
    if (pickedFile != null) {
      final bytes = await pickedFile?.readAsBytes();
      print("Image picked successfully, byte size: ${bytes?.length}");
      var request = http.MultipartRequest('POST', uriPath);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        bytes as List<int>,
        filename: "${userNameImg}.jpg",
      ));
      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          var responseJson = jsonDecode(value);
          String imageUrl = responseJson['data']['url'];
          userImageUrl = imageUrl;
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

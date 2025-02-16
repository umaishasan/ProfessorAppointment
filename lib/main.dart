import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scholappoinment_934074496/Models/Person.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scholappoinment_934074496/SplashScreen.dart';
import 'Firebase/firebase_options.dart';

//This variable use for screen size
late Size screenSizeCommon;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _InitializeFirebase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Person()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Academic Appointment',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 20,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            backgroundColor: Color(0xFF32983E),
            toolbarTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15)),
      ),
      home: const SplashScreen(),
    );
  }
}

//Initialize firebase method for integrating
_InitializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

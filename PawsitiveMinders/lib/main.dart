// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase/login/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: const Splashscreen(),
      home: const  Splashscreen (),
      
      debugShowCheckedModeBanner: false,
        title: 'Petcare',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 144, 255, 148),),
          useMaterial3: true, fontFamily: 'Poppins',
      )
    );
  }
}


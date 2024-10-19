// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pawsitiveminder/login/registeredlogin.dart';
import 'package:pawsitiveminder/login/signup.dart';
import 'package:pawsitiveminder/login/splashscreen.dart';

import 'login/login.dart';
import 'page/home.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
        title: 'Petcare',
        theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 144, 255, 148)),
          useMaterial3: true, fontFamily: 'Poppins'
      ),
      initialRoute: '/splashscreen',
      routes: {
        '/login': (context) => const login(),
        '/home': (context) => const home(),
        '/signup': (context) => const Signup(),
        '/register': (context) =>const register(),
        '/splashscreen': (context) =>const Splashscreen(),
      },
    );
  }
}


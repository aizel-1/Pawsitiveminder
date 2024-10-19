import 'package:firebase/login/login.dart';
import 'package:firebase/models/PetProfilePage.dart';
import 'package:firebase/models/ProfilePage.dart';
import 'package:firebase/models/appointmentpagemain.dart';
import 'package:firebase/page/homepage.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/home',
      routes: {

        '/profile': (context) =>   const ProfilePage(),
        '/home': (context) =>  const HomePage(appointments: [],),
        '/appointments': (context) =>  const AppointmentScreen(),
        '/login': (context) => const login(),
        '/petprofile': (context) =>    const Petprofilepage(name: '', imagePath: '', birthday: '', age: '',),
        
      },
    );
  }
}




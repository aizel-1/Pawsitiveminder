import 'package:flutter/material.dart';
import 'package:pawsitiveminder/login/login.dart';
import 'package:pawsitiveminder/models/PetProfilePage.dart';
import 'package:pawsitiveminder/models/ProfilePage.dart';
import 'package:pawsitiveminder/models/appointmentpagemain.dart';
import 'package:pawsitiveminder/page/homepage.dart';

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




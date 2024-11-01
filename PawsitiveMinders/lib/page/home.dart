import 'package:firebase/login/login.dart';
import 'package:firebase/models/appointmentpagemain.dart';
import 'package:firebase/page/homepage.dart';
import 'package:firebase/profile/PetProfilePage.dart';
import 'package:firebase/profile/profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          initialRoute: '/home',
          routes: <String, WidgetBuilder>{
        
            '/profile': (context) =>   const profilepage(),
            '/home': (context) =>  const HomePage(appointments: [],),
            '/appointments': (context) =>  const AppointmentScreen(),
            '/login': (context) =>  const login(),
            '/petprofile': (context) =>    const Petprofilepage(name: '', imagePath: '', birthday: '', age: '',),
            
          },
        );
        
        }else{
          return const login();
        }
      }
    );
  }
}




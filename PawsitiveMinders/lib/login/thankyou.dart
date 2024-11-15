import 'package:firebase/login/login.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Thankyou extends StatefulWidget {
  const Thankyou({super.key});

  @override
  _ThankyouState createState() => _ThankyouState();
}

class _ThankyouState extends State<Thankyou> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Dog and bell image
              const CircleAvatar(radius: 50,
                  backgroundImage:
                      AssetImage('images/logo.png'),
              ),
              const SizedBox(height: 20),

              // "Thank you for registering" text
              const Text(
                'Thank you for registering',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // "Back to log in" button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: const login()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFFD4B094), // Button color (beige)
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Back to log in',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
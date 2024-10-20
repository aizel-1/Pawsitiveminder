import 'package:firebase/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {

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
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/icons/logo.svg', // Replace with the path to your logo
                  height: 200,
                ), // Your dog and bell image
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

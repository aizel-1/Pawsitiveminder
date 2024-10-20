

import 'package:firebase/login/login.dart';
import 'package:firebase/login/signup.dart';
import 'package:flutter/material.dart';

class Authpage extends StatefulWidget {
  const Authpage({Key?key}) :  super (key: key);

  @override
  State<Authpage> createState() => _AuthpageState();
}

class _AuthpageState extends State<Authpage> {

  bool showLogin = true;

  void toggleScreens (){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin){
      return const login();
    }else {
      return const Signup();
    }
  }
}
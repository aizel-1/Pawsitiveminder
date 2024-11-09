import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const  Center(
        child: Text('Settings', style: TextStyle(fontSize: 15),),
      )),
      body: const Text(''),
    );
  }
}
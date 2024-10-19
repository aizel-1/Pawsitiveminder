import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pawsitiveminder/login/login.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> 
with SingleTickerProviderStateMixin{
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder:(_) => const login(),
        ));
    });
    
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays:SystemUiOverlay.values);
    super.dispose();
  }



  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors:[Color.fromRGBO(166, 110, 56, 1), Color.fromRGBO(255, 173, 96, 1)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft
          )
        ),
        child:const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('images/logo.png'), // Add your cat image here
                ),
            SizedBox(height: 20),
            Text('PawisitiveMinders', style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize:32,
            ),
            )
          ],
        ),

      ),
    );
  }
}
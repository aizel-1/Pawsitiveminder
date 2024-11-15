import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotpasswordpageState();
}

class _ForgotpasswordpageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
            showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text('password reset link sent! Check your email'),
            );
          },
          );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Forgot Password', style: TextStyle(fontWeight: FontWeight.bold))),
        actions: const [
          Opacity(opacity: 0.0,
          child: Row(
            children: [Icon(Icons.pets),
            Icon(Icons.pets)],
          ),)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding:  const EdgeInsets.all(15),
              child:  CircleAvatar(
                radius: 70,
                backgroundColor: Colors.transparent,
                child:  ClipOval(child: Image.asset('images/WhiteCat.jpg')),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                  'Enter Your Email and we will send you a password reset link.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center),
            ),
            const SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'email',
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              onPressed: passwordReset,
              color: Colors.brown,
              child: const Text('Reset Password'),
            ),
            
          ],
        ),
      ),
    );
  }
}

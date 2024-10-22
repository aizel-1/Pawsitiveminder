import 'package:firebase/login/ForgotPasswordPage.dart';
import 'package:firebase/login/signup.dart';
import 'package:firebase/page/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({
    Key? key,
  }) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSecurePassword = true;

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$ ');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (email!.isEmpty) {
      return "Enter Email";
    } else if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  Future signIn(BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim())
        .then((signIn) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => const home()));
    }
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(
          255, 255, 255, 255), // Brown color for background
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Cat Image
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('images/logo.png'), // Add your cat image here
                ),
                const SizedBox(height: 20),
                // Username Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isSecurePassword,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      suffixIcon: togglePassword()),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'password is required';
                    } else if (_passwordController.text.length < 6) {
                      return 'Password Length Should not be less than 6';
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'forgot password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Login Button
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      formKey.currentState!.validate();
                      signIn(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                          child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signup()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isSecurePassword = !_isSecurePassword;
        });
      },
      icon: _isSecurePassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }
}

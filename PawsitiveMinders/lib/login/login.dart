import 'package:firebase/login/ForgotPasswordPage.dart';
import 'package:firebase/login/signup.dart';
import 'package:firebase/page/mainpage.dart';
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
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (email!.isEmpty) {
      return "Enter Email";
    } else if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }
  // route() {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   var kk = FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       if (documentSnapshot.get('role') == "Vets") {
  //         Navigator.pushReplacement(context,
  //             MaterialPageRoute(builder: (context) => const Vetinterface()));
  //       }
  //       else { Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const Mainpage(),
  //         ),
  //       );}
  //     }
  //   });
  // }
  // void signIn(String email,String password)async{
  //   if (formKey.currentState!.validate()){
  //     try {
  //       UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithEmailAndPassword(
  //         email: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       );
  //       route();
  //     }on FirebaseAuthException catch(e){
  //       if(e.code == 'user-not-found'){
  //         print('No user found for that email.');
  //       }else if (e.code == 'wrong password'){
  //         print('Wrong password provided for that user.');
  //       }
  //     }
  //   }
  // }

  final formKey = GlobalKey<FormState>();

  void signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Mainpage()));
      //         .then((signIn) {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (BuildContext context) => const Mainpage()));
      // });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('error:${e.toString()}'),
        backgroundColor: Colors.red,
      ));
    }
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
                const Text('Log In',
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                // const CircleAvatar(
                //   radius: 50,
                //   backgroundImage:
                //       AssetImage('images/logo.png'), // Add your cat image here
                // ),
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
                  validator: (val) =>
                      val!.length < 6 ? 'Required at least 6 chars' : null,

                  //       validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Password is Required';
                  //   } else if (value.length < 6) {
                  //     return 'Password Length Should not be less than 6';
                  //   } else {
                  //     return null; // Password is valid
                  //   }
                  // }

                  // validator: (value) {
                  //   if (_passwordController.text.isEmpty) {
                  //     return 'Password is Required';
                  //   } else if (_passwordController.text.length < 6) {
                  //     return 'Password Length Should not be less than 6';
                  //   } else if (_passwordController.text.isNotEmpty){
                  //     return null;
                  //   }else {
                  //     return 'Incorrect Password';
                  //   }
                  //   //   return 'Password';
                  //   // }
                  // },
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
                      signIn(_emailController.text, _passwordController.text);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                          child: Text(
                        'Log In',
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

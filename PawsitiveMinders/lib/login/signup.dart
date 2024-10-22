import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/login/login.dart';
import 'package:firebase/login/verify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({
    Key? key,
  }) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String selectedRole;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  Future Signup() async {
    if (passwordConfimred()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((Signup) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const VerifyScreen()));
      });
      addUserDetails(_firstNameController.text.trim(),
          _lastNameController.text.trim(), _emailController.text.trim());
    }
  }

  Future addUserDetails(
    String firstName,
    String lastname,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastname,
      'email': email,
      'role': selectedRole,
    });
  }

  bool passwordConfimred() {
    if (_confirmpasswordController.text.trim() ==
        _confirmpasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Circle Avatar with Cat Illustration
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey[200],
                  child: Image.asset(
                    'images/logo.png', // Add your cat icon image to the assets folder
                  ),
                ),
                const SizedBox(height: 20),

                // Dropdown for selecting user type (Vet/PetOwner)
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: ['Vet', 'PetOwner']
                      .map((label) => DropdownMenuItem(
                            value: label,
                            child: Text(label),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!; // Store selected value
                    });
                  },
                  hint: const Text('Vet/PetOwner'),
                ),
                const SizedBox(height: 20),
                // firstname Field
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'firstname',
                  ),
                ),
                const SizedBox(height: 20),

                //lastname Field
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'lastname',
                  ),
                ),
                const SizedBox(height: 20),

                // Username Field
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'email',
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Create password',
                  ),
                ),
                const SizedBox(height: 20),

                // Confirm Password Field
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: 'Confirm password',
                  ),
                ),
                const SizedBox(height: 20),

                // Sign Up Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: Signup,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Already have account Text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "already have an account?",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const login()));
                      },
                      child: const Text(
                        "Login now",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

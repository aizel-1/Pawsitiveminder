import 'package:flutter/material.dart';

import 'login.dart';


class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                onChanged: (value) {},
                hint: const Text('Vet/PetOwner'),
              ),
              const SizedBox(height: 20),

              // Username Field
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Enter username',
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              TextField(
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
              SizedBox(
                width: double.infinity, // Makes button full width
                child: ElevatedButton(
                  onPressed: () {
                    // Implement sign-up logic
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: const Color(0xFFd4b28c), // Light brownish color
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Already have account Text
              GestureDetector(
                onTap: () {
                  // Navigate to login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=> const login()));
                },
                child: const Text(
                  'Already have account?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

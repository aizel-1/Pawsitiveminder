import 'dart:io';

import 'package:flutter/material.dart';
class Petprofilepage extends StatelessWidget {
  final String name;
  final String? imagePath;
  final String birthday;
  final String age;

  const Petprofilepage({super.key,
    required this.name,
    required this.imagePath,
    required this.birthday,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          TextButton(
            onPressed: () {
              // Implement edit functionality if needed
            },
            child: const Text('edit', style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: imagePath != null ? FileImage(File(imagePath!)) : const AssetImage('assets/default_pet.png'),
            ),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text('Dog • Female', style: TextStyle(fontSize: 16)), // Placeholder for gender, you can change it dynamically
            const SizedBox(height: 10),
            Text('Birthday: $birthday', style: const TextStyle(fontSize: 16)),
            Text('Age: $age', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text('Medical History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  Container(height: 100, color: Colors.grey[300]), // Placeholder for medical history
                  const SizedBox(height: 10),
                  Container(height: 100, color: Colors.grey[300]), // Another placeholder
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PetCard for displaying each pet
class PetCard extends StatelessWidget {
  final ImageProvider imagePath;
  final String name;
  final String birthday;
  final String age;

  const PetCard({super.key, 
    required this.imagePath,
    required this.name,
    required this.birthday,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Petprofilepage(
              name: name,
              imagePath: imagePath is FileImage ? (imagePath as FileImage).file.path : null,
              birthday: birthday,
              age: age,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(name, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

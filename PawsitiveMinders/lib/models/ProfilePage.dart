// ignore_for_file: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  List<Map<String, String?>> pets = []; // Use String? for both fields

  final ImagePicker _picker = ImagePicker();


  // Add profile picture
  Future<void> _pickProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Add pet
  void _addPet(String? imagePath, String petName) {
    setState(() {
      pets.add({'imagePath': imagePath, 'name': petName});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pawsitive'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Upper Plus Button for Profile Picture
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[300],
                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                child: _profileImage == null
                    ? const Icon(Icons.add, size: 40, color: Colors.blue)
                    : null,
              ),
            ),
            const SizedBox(height: 10),
            // User profile details
            const Text("marko D. Mamangan", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text("marko@gmail.com", style: TextStyle(fontSize: 16)),
            const Text("0909090909", style: TextStyle(fontSize: 16)),
            const Text("satabitabi", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Handle profile editing functionality
              },
              child: const Text('edit profile', style: TextStyle(color: Colors.blue)),
            ),
            const SizedBox(height: 20),
            // Pet List Section
            const Text(
              'MY PETS',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Expanded to prevent overflow with pet cards
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  ...pets.map((pet) => PetCard(
                        imagePath: pet['imagePath'] != null
                            ? FileImage(File(pet['imagePath']!)) // Ensure null safety
                            : const AssetImage('assets/default_pet.png'), // Use a default image if none is available
                        name: pet['name'] ?? 'Unknown',
                      )),
                  AddPetCard(onPetAdded: _addPet),
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

  const PetCard({super.key, required this.imagePath, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
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
    );
  }
}

// AddPetCard for the lower plus button to add pet details
class AddPetCard extends StatelessWidget {
  final Function(String?, String) onPetAdded;

  const AddPetCard({super.key, required this.onPetAdded});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => AddPetDialog(onPetAdded: onPetAdded),
        );
      },
      child: Container(
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.grey[300],
        ),
        child: const Center(
          child: Icon(Icons.add, size: 40, color: Colors.blue),
        ),
      ),
    );
  }
}

// Dialog for adding a new pet
class AddPetDialog extends StatefulWidget {
  final Function(String?, String) onPetAdded;

  const AddPetDialog({super.key, required this.onPetAdded});

  @override
  // ignore: library_private_types_in_public_api
  _AddPetDialogState createState() => _AddPetDialogState();
}

class _AddPetDialogState extends State<AddPetDialog> {
  File? _petImage;
  final TextEditingController _petNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickPetImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _petImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _pickPetImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: _petImage != null ? FileImage(_petImage!) : null,
                  child: _petImage == null
                      ? const Icon(Icons.add_a_photo, size: 40, color: Colors.blue)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _petNameController,
                decoration: const InputDecoration(
                  labelText: 'Pet Name',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_petNameController.text.isNotEmpty) {
                        widget.onPetAdded(
                            _petImage?.path, _petNameController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

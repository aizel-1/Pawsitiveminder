import 'package:firebase/profile/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Updateprofilescreen extends StatefulWidget {
  const Updateprofilescreen({Key? key}) : super(key: key);

  @override
  State<Updateprofilescreen> createState() => _UpdateprofilescreenState();
}

class _UpdateprofilescreenState extends State<Updateprofilescreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSecurePassword = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(profilepage.tEditProfile),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: const Image(
                          image: AssetImage('images/logo.png'),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        // ignore: deprecated_member_use
                        color: Colors.brown.withOpacity(0.1),
                      ),
                      child: const Icon(LineAwesomeIcons.camera_solid,
                          size: 18, color: Color.fromARGB(255, 29, 24, 24)),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Form(child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon (Icons.person),
                      labelText: "Full Name",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        
                      ),
                    ),
                  ),
                  const SizedBox(height:15),

                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon (Icons.email),
                      labelText: "Email",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        
                      ),
                    ),
                  ),
                  const SizedBox(height:15),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isSecurePassword,
                    decoration: InputDecoration(
                      prefixIcon: Icon (Icons.password),
                      labelText: "Password",
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    suffixIcon: togglePassword()),
                  ),
                  const SizedBox(height:15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const Updateprofilescreen()),
                      style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(239, 236, 177, 120), side: BorderSide.none, shape: const StadiumBorder()),
                      child: const Text(profilepage.tEditProfile, style: TextStyle(color: Colors.black),),
                  ),
                  ),
                  const SizedBox(height:20),
                  const Row(
                    children: [
                      Text.rich(TextSpan(text: profilepage.tJoined, style: TextStyle(fontSize: 15),
                      children: [
                        TextSpan(text: profilepage.tJoinedAt, style: TextStyle(fontWeight: FontWeight.bold))
                      ]
                      ),
                      ),
                      
                    ],
                  ),
                ],
              ),
              ),
            ],
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

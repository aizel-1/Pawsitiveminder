import 'package:firebase/vetsinterface/vetsHomePage.dart';
import 'package:firebase/vetsinterface/vetsprofile.dart';
import 'package:flutter/material.dart';

class Vetinterface extends StatefulWidget {
  const Vetinterface({super.key});

  @override
  State<Vetinterface> createState() => _VetinterfaceState();
}

class _VetinterfaceState extends State<Vetinterface> {
int _currentIndex = 1;
  List<Widget> _pages = [];
  @override
  
void initState() {
    super.initState();
    _pages = [
      const Vetsprofile(),
      const Vetshomepage(),
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Pawsitive')),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.brown,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },

          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home',),
            ]),
    );
  }
}

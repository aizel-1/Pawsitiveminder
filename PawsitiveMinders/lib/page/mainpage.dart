import 'package:firebase/login/login.dart';
import 'package:firebase/models/appointmentpagemain.dart';
import 'package:firebase/page/homepage.dart';
import 'package:firebase/page/settings.dart';
import 'package:firebase/page/user.dart';
import 'package:firebase/profile/PetProfilePage.dart';
import 'package:firebase/profile/profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isSwitched = false;
  int _currentIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(
        appointments: [],
      ),
      const AppointmentScreen(),
      const profilepage(),
    ];
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user?.displayName ?? 'no name',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            accountEmail: Text(user?.email ?? 'No Email',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(child: Image.asset('images/logo.png')),
            ),
            decoration: const BoxDecoration(
                color: Colors.brown,
                image: DecorationImage(
                    image: AssetImage('images/cat-dog.png'),
                    fit: BoxFit.cover)),
          ),
          //   ListTile(
          //   leading:const Icon(Icons.account_circle),
          //   title: const Text('Profile'),
          //   onTap: () {
          //   Navigator.pushNamed(context, '/profile');
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.pets_rounded),
            title: const Text('Pet Profile'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Petprofilepage(
                        name: '',
                        imagePath: '',
                        birthday: '',
                        age: '',
                      )));
            },
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            value: isSwitched,
            onChanged: (bool newValue) {
              setState(() {
                isSwitched = newValue;
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Settings()));
            },
          ),
          const SizedBox(
            height: 350,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.redAccent,
            ),
            title: const Text('Sign out',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
            onTap: () {
              _auth.signOut();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => const login()));
              // Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // routes;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Pawsitive',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [
          Opacity(
          opacity: 0.0,
          child: Row(
          children: [Icon(Icons.pets),
          Icon(Icons.person)],
          )
          )
          ],
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.brown,
            unselectedItemColor: Colors.black87,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: 'Appointment'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Profile'),
            ]),
      ),
    );
  }
}

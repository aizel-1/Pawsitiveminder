import 'package:firebase/login/login.dart';
import 'package:firebase/page/settings.dart';
import 'package:firebase/page/user.dart';
import 'package:firebase/vetsinterface/vetsHomePage.dart';
import 'package:firebase/vetsinterface/vetsprofile.dart';
import 'package:flutter/material.dart';

class Vetinterface extends StatefulWidget {
  const Vetinterface({super.key});

  @override
  State<Vetinterface> createState() => _VetinterfaceState();
}

class _VetinterfaceState extends State<Vetinterface> {
  bool isSwitched = false;
  int _currentIndex = 0;
  List<Widget> _pages = [];
  @override
  void initState() {
    super.initState();
    _pages = [
      const Vetshomepage(),
      const Vetsprofile(),
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
            height: 400,
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
                children: [Icon(Icons.pets), Icon(Icons.person)],
              ))
        ],
      ),
      drawer: _buildDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.brown,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}

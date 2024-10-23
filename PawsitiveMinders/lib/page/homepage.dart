import 'package:firebase/models/AppointmentDetailPage.dart';
import 'package:firebase/page/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required List appointments});


  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _HomePageState createState() => _HomePageState(appointments: []);
}

class _HomePageState extends State<HomePage> {
Future<void> updateDisplayName(String name) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (User != true){
    await user?.updateDisplayName(null);
    await user?.reload();
    user = FirebaseAuth.instance.currentUser;
  }
}
  
    final List<Map<String,String>>appointments;
    _HomePageState({required this.appointments});
  int _selectedIndex = 0;

  // Handle bottom navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.pushNamed(context, '/home');
    } else if (index == 0) {
          Navigator.pushNamed(context, '/profile');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/appointments');
    }
  }

  // Drawer Widget
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
          accountName: Text(user?.displayName ?? 'no name' ,style: const TextStyle(color: Colors.white,fontSize: 16),),
          accountEmail:  Text(user?.email ?? 'No Email', style: const TextStyle(color: Colors.white,fontSize: 16)),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(child: Image.asset('images/logo.png')),
          ),
          decoration: const BoxDecoration(
            color: Colors.brown,
            image: DecorationImage(image: AssetImage('images/cat-dog.png'), fit: BoxFit.cover)
          ),
        ),
          ListTile(
          leading:const Icon(Icons.account_circle),
          title: const Text('Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
                  ListTile(
          leading:const Icon(Icons.pets_rounded),
          title: const Text('Pet Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/petprofile');
          },
        ),
          // ListTile(
          //   leading: const Icon(Icons.home),
          //   title: const Text('Home'),
          //   onTap: () {
          //     Navigator.pushNamed(context, '/home');
          //   },
          // ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
            const SizedBox(
                  height: 280,
                ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: () {
            Navigator.pushNamed(context, '/login');
            
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
      ),
      drawer: _buildDrawer(), // Adding the Drawer (sidebar)
            body: appointments.isEmpty
          ? const Center(
              child: Text('No appointments booked.'),
            )
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AppointmentDetailPage(appointment: appointment),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Vet: ${appointment['vet']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Service: ${appointment['service']}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('Pet: ${appointment['petType']}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('Day: ${appointment['day']}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('Time: ${appointment['time']}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointments',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 188, 130, 73),
        unselectedItemColor: const Color.fromARGB(255, 45, 44, 44),
        onTap: _onItemTapped,
      ),
      
    );
  }
}

 @override
  Widget build(BuildContext context, dynamic appointments) {
    return appointments.isEmpty
        ? const Center(
            child: Text('No appointments booked.'),
          )
        : ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AppointmentDetailPage(appointment: appointment),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Vet: ${appointment['vet']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Service: ${appointment['service']}', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('Pet: ${appointment['petType']}', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('Day: ${appointment['day']}', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('Time: ${appointment['time']}', style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              );
            },
          );
  }


import 'package:firebase/models/AppointmentDetailPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required List appointments});


  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _HomePageState createState() => _HomePageState(appointments: []);
}

class _HomePageState extends State<HomePage> {
    final List<Map<String,String>>appointments;
    _HomePageState({required this.appointments});
  int _selectedIndex = 0;

  // Handle bottom navigation bar tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushNamed(context, '/profile');
    } else if (index == 1) {
          Navigator.pushNamed(context, '/home');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/appointments');
    }else if (index == 3) {
      Navigator.pushNamed(context, '/appointents');
    }
  }

  // Drawer Widget
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
          accountName: const Text('si mama mo' ,style: TextStyle(color: Color.fromARGB(255, 45, 3, 0))),
          accountEmail: const Text('mama mo @gmail.com', style: TextStyle(color: Color.fromARGB(255, 45, 3, 0))),
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
          title: const Text('View Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          },
        ),
                  ListTile(
          leading:const Icon(Icons.pets_rounded),
          title: const Text('View Pet Profile'),
          onTap: () {
            Navigator.pushNamed(context, '/petprofile');
          },
        ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('notifications'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('settings'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
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
        selectedItemColor: const Color.fromARGB(255, 97, 75, 53),
        unselectedItemColor: Colors.grey,
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


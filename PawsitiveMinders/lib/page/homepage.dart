import 'package:firebase/models/AppointmentDetailPage.dart';
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
  // int _selectedIndex = 0;

  // Handle bottom navigation bar tap
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });

  //   if (index == 0) {
  //     Navigator.pushNamed(context, '/profile');
  //   } else if (index == 1) {
  //         Navigator.pushNamed(context, '/home');
  //   } else if (index == 2) {
  //     Navigator.pushNamed(context, '/appointments');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            AppointmentDetailPage(appointments: appointment),
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
            
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_today),
      //       label: 'Appointments',
      //     ),
      //   ],
      //   selectedItemColor: const Color.fromARGB(255, 188, 130, 73),
      //   unselectedItemColor: const Color.fromARGB(255, 45, 44, 44),
      //   onTap: _onItemTapped,
      // ),
      
    );
  }
}

@override
  Widget build(BuildContext context, dynamic appointments) {
    return appointments.isEmpty
        ? const SingleChildScrollView(
          child: Center(
              child: Text('No appointments booked.'),
            ),
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
                          AppointmentDetailPage(appointments: appointment),
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


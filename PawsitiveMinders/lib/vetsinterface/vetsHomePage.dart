// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Vetshomepage extends StatefulWidget {
//   const Vetshomepage({super.key, required this.vetName});

//   @override
//   State<Vetshomepage> createState() => _VetshomepageState();
// }

// class _VetshomepageState extends State<Vetshomepage> {
  
//   List<Map<String, dynamic>> vetAppointments = [];

//   Future<void> _fetchAppointmentsForVet(String vetName) async {
//   try {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('appointments')
//         .where('vetId', isEqualTo: vetName) // Match the vet's name or ID
//         .get();

//     List<Map<String, dynamic>> appointments = snapshot.docs.map((doc) {
//       return {
//         'service': doc['service'],
//         'petType': doc['petType'],
//         'date': doc['date'],
//         'userId': doc['userId'],
//         'status': doc['status'],
//       };
//     }).toList();
// @override
// void initState() {
//   super.initState();
//   _fetchAppointmentsForVet(vetName);  // Call this when the screen initializes
// }
//     // Update the state or UI with the fetched appointments
//     setState(() {
//       appointments = appointments;
//     });
//   } catch (e) {
//     print('Error fetching appointments: $e');
//   }
// }

// DateTime selectedDate = DateTime.now();
//   final DateTime firstDate = DateTime(2020);
//   final DateTime lastDate = DateTime(2030);

//   void _showAppointmentForm() {
//     showModalBottomSheet(
//         isScrollControlled: true,
//         context: context,
//         builder: (BuildContext context) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom,
//                 top: 16,
//                 left: 16,
//                 right: 16,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Center(child: Text('Reschedule', style: TextStyle(fontWeight: FontWeight.bold,
//                   fontSize: 16),)),
//                   const SizedBox(
//                     height: 16,
//                   ),
//                   CalendarDatePicker(initialDate: selectedDate , firstDate: firstDate, lastDate: lastDate, onDateChanged: (DateTime value) {  },)
//                 ],
//               ),
//               ),
//           );
//         });
//   }
//   @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     floatingActionButton: FloatingActionButton(onPressed: _showAppointmentForm),
//     body: ListView.builder(
//       itemCount: vetAppointments.length,
//       itemBuilder: (context, index) {
//         final appointment = vetAppointments[index];
//         return ListTile(
//           title: Text('Service: ${appointment['service']}'),
//           subtitle: Text('Pet Type: ${appointment['petType']}, Date: ${appointment['date']}'),
//           trailing: Text('Status: ${appointment['status']}'),
//         );
//       },
//     ),
//   );
// }
// // Update the status of the appointment
// void _updateAppointmentStatus(String appointmentId, String newStatus) async {
//   try {
//     await FirebaseFirestore.instance
//         .collection('appointments')
//         .doc(appointmentId)
//         .update({
//       'status': newStatus,
//     });

//     print('Appointment status updated to $newStatus');
//   } catch (e) {
//     print('Error updating status: $e');
//   }
// }

//   }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Vetshomepage extends StatefulWidget {
  @override
  _VetshomepageState createState() => _VetshomepageState();
}

class _VetshomepageState extends State<Vetshomepage> {
  List<Map<String, dynamic>> vetAppointments = [];
  String? currentVetId;

  @override
  void initState() {
    super.initState();
    // Fetch the logged-in vet's ID from Firebase Auth
    User? currentUser = FirebaseAuth.instance.currentUser;
    currentVetId = currentUser?.uid;

    if (currentVetId != null) {
      _fetchVetNameAndAppointments(currentVetId!);
    }
  }

  Future<void> _fetchVetNameAndAppointments(String vetUid) async {
    try {
      // Fetch vet's name from 'users' collection using vet UID
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(vetUid)
          .get();

      if (userDoc.exists) {
        String vetName = userDoc['firstName'] + ' ' + userDoc['lastName']; // Assuming the name fields are stored separately
        print('Logged in vet name: $vetName'); // Debug print

        // Fetch appointments using vet's name
        _fetchAppointmentsForVet(vetName);
      } else {
        print('Vet document not found for UID: $vetUid');
      }
    } catch (e) {
      print('Error fetching vet name: $e');
    }
  }

  Future<void> _fetchAppointmentsForVet(String vetName) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('vetId', isEqualTo: vetName) // Filter by vet name
          .get();

      if (snapshot.docs.isEmpty) {
        print('No appointments found for vet: $vetName');
      } else {
        print('Appointments found: ${snapshot.docs.length}');
      }

      // Include the document ID in each appointment
      List<Map<String, dynamic>> appointments = snapshot.docs.map((doc) {
        return {
          'id': doc.id, // Add the document ID here
          'service': doc['service'],
          'petType': doc['petType'],
          'date': doc['date'],
          'userId': doc['userId'],
          'status': doc['status'],
        };
      }).toList();

      setState(() {
        vetAppointments = appointments;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

  // Method to update the appointment status
  void _updateAppointmentStatus(String appointmentId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('appointments')
          .doc(appointmentId)
          .update({'status': newStatus});

      print('Appointment status updated to $newStatus');
      _fetchVetNameAndAppointments(currentVetId!); // Refresh the list after status update
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Appointments'),
      ),
      body: ListView.builder(
        itemCount: vetAppointments.length,
        itemBuilder: (context, index) {
          final appointment = vetAppointments[index];

          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Service: ${appointment['service']}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('Pet Type: ${appointment['petType']}'),
                Text('Date: ${appointment['date']}'),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status: ${appointment['status']}',
                      style: TextStyle(
                        color: appointment['status'] == 'accepted'
                            ? Colors.green
                            : appointment['status'] == 'cancelled'
                                ? Colors.red
                                : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.check, color: Colors.green),
                          onPressed: () {
                            _updateAppointmentStatus(appointment['id'], 'accepted'); // Accept the appointment
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {
                            _updateAppointmentStatus(appointment['id'], 'cancelled'); // Cancel the appointment
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.calendar_today, color: Colors.blue),
                          onPressed: () {
                            // Reschedule logic here
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

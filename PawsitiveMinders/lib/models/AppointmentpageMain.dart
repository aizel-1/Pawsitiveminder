// // ignore_for_file: use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase/models/AppointmentpageSub.dart';
// import 'package:flutter/material.dart';

// class AppointmentScreen extends StatefulWidget {
//   const AppointmentScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AppointmentScreenState createState() => _AppointmentScreenState();
// }

// class _AppointmentScreenState extends State<AppointmentScreen> {
//   final TextEditingController _dateController = TextEditingController();


//   // Future<void> _selecDate() async {
//   //   DateTime? picked = await showDatePicker(
//   //       context: context,
//   //       initialDate: DateTime.now(),
//   //       firstDate: DateTime(2000),
//   //       lastDate: DateTime(2100));
//   //   if (picked != null) {
//   //     setState(() {
//   //       _dateController.text = picked.toString().split(" ")[0];
//   //     }
//   //   );
//   //   }
//   // }


//   Future<void> _selecDate() async {
//   DateTime? pickedDate = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100),
//   );
  
//   if (pickedDate != null) {
//     // Select Time after the Date
//     TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );

//     if (pickedTime != null) {
//       // Combine Date and Time into a DateTime object
//       DateTime combinedDateTime = DateTime(
//         pickedDate.year,
//         pickedDate.month,
//         pickedDate.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
      
//       // Format the combined DateTime object
//       String formattedDateTime = "${combinedDateTime.toLocal()}".split('.')[0];

//       // Set the text in the controller to the formatted date and time
//       setState(() {
//         _dateController.text = formattedDateTime;
//       });
//     }
//   }
// }
//   List<String> veterinarians = [];
//   String? selectedVet;
//   String? selectedService;
//   String? selectedPetType;
//   String? selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     _fetchVeterinarians();
//   }
// // Save the appointment to Firestore
// void _saveAppointment() async {
//   try {
//     await FirebaseFirestore.instance.collection('appointments').add({
//       'vetId': selectedVet, // The vet selected in the form
//       'service': selectedService,
//       'petType': selectedPetType,
//       'date': _dateController.text,
//       'userId': 'currentUserId', // Replace with the current user's ID
//       'status': 'pending', // Set an initial status like 'pending' or 'confirmed'
//       'timestamp': FieldValue.serverTimestamp(), // Store the time when the booking was made
//     });

//     print('Appointment booked successfully!');
//   } catch (e) {
//     print('Error booking appointment: $e');
//   }
// }


  
// Future<void> _fetchVeterinarians() async {
//   try {
//     // Query Firestore to get users where role is 'Veterinarian'
//     QuerySnapshot snapshot = await FirebaseFirestore.instance
//         .collection('users') // Collection name
//         .where('role', isEqualTo: 'Veterinarian') // Filtering by 'Veterinarian' role
//         .get();

//     // Extract the names of veterinarians from the query result
//     List<String> vets = snapshot.docs.map((doc) {
//       String firstName = doc['firstName'];
//       String lastName = doc['lastName'];
//       return '$firstName $lastName'; // Combine first and last name
//     }).toList();

//     // Update the state with the fetched list of veterinarians
//     setState(() {
//       veterinarians = vets;
//     });
//   } catch (e) {
//     print('Error fetching veterinarians: $e');
//   }
// }
//   // List<String> availableTimes = ['7-9 am', '9-11 am', '1-3 pm'];

//   // Shared List to store appointments
//   List<Map<String, String>> appointments = [];

//   void _showAppointmentForm() {
//     showModalBottomSheet(
//       isScrollControlled: true,
//       context: context,
//       builder: (BuildContext context) {
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//               top: 16,
//               left: 16,
//               right: 16,
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'Book an Appointment',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(
//                     labelText: 'Vets name',
//                     border: OutlineInputBorder(),
//                   ),
//                   value: selectedVet,
//                   items:veterinarians.map((vet) {
//                     return DropdownMenuItem<String>(
//                       value: vet,
//                       child: Text(vet),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedVet = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(
//                     labelText: 'Services',
//                     border: OutlineInputBorder(),
//                   ),
//                   value: selectedService,
//                   items: ['Grooming', 'Vaccination', 'Check-up'].map((service) {
//                     return DropdownMenuItem<String>(
//                       value: service,
//                       child: Text(service),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedService = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(
//                     labelText: 'CAT / DOG',
//                     border: OutlineInputBorder(),
//                   ),
//                   value: selectedPetType,
//                   items: ['Cat', 'Dog'].map((petType) {
//                     return DropdownMenuItem<String>(
//                       value: petType,
//                       child: Text(petType),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedPetType = value;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 TextField(
//                   controller: _dateController,
//                   decoration: const InputDecoration(
//                       labelText: 'chose date and time',
//                       filled: true,
//                       prefixIcon: Icon(Icons.calendar_today),
//                       enabledBorder:
//                           OutlineInputBorder(borderSide: BorderSide.none),
//                       focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: Colors.green))),
//                   readOnly: true,
//                   onTap: () {
//                     _selecDate();
//                   },
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
//                   onPressed: () {
//                     _saveAppointment();
//                     // Save the appointment details
//                     setState(() {
//                       appointments.add({
//                         'vet': selectedVet ?? '',
//                         'service': selectedService ?? '',
//                         'petType': selectedPetType ?? '',
//                         'date': _dateController.text,
//                       });

//                       // Clear the form fields after booking
//                       selectedVet = null;
//                       selectedService = null;
//                       selectedPetType = null;
//                       selectedDate = null;
//                       _dateController.clear();
//                     });
//                     Navigator.pop(context); // Close the bottom sheet
//                   },
//                   child: const Text('Book Now', style: TextStyle(color: Colors.white),),
//                 ),
//                 const SizedBox(height: 30)
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AppointmentPage(appointments: appointments),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(10),
//         child: FloatingActionButton(
//           onPressed: _showAppointmentForm,
//           backgroundColor: Colors.brown,
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//           child: const Icon(Icons.add),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final TextEditingController _dateController = TextEditingController();
  List<Map<String, String>> appointments = [];
  List<String> veterinarians = [];
  String? selectedVet;
  String? selectedService;
  String? selectedPetType;

  @override
  void initState() {
    super.initState();
    _fetchVeterinarians();
    _fetchAppointments(); // Fetch saved appointments
  }

  // Fetch saved appointments from Firestore
  Future<void> _fetchAppointments() async {
    try {
      String currentUserId = "currentUserId"; // Replace with your logic to get the user ID
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('userId', isEqualTo: currentUserId)
          .get();

      List<Map<String, String>> fetchedAppointments = snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Explicit casting
        return {
          'vet': data['vetId']?.toString() ?? '',
          'service': data['service']?.toString() ?? '',
          'petType': data['petType']?.toString() ?? '',
          'date': data['date']?.toString() ?? '',
        };
      }).toList();

      setState(() {
        appointments = fetchedAppointments;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

  Future<void> _fetchVeterinarians() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Veterinarian')
          .get();

      List<String> vets = snapshot.docs.map((doc) {
        String firstName = doc['firstName'];
        String lastName = doc['lastName'];
        return '$firstName $lastName';
      }).toList();

      setState(() {
        veterinarians = vets;
      });
    } catch (e) {
      print('Error fetching veterinarians: $e');
    }
  }

  Future<void> _selecDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDateTime = "${combinedDateTime.toLocal()}".split('.')[0];
        setState(() {
          _dateController.text = formattedDateTime;
        });
      }
    }
  }

  void _saveAppointment() async {
    try {
      String currentUserId = "currentUserId"; // Replace with the current user's ID
      await FirebaseFirestore.instance.collection('appointments').add({
        'vetId': selectedVet,
        'service': selectedService,
        'petType': selectedPetType,
        'date': _dateController.text,
        'userId': currentUserId,
        'status': 'pending',
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Add locally for immediate update
      setState(() {
        appointments.add({
          'vet': selectedVet ?? '',
          'service': selectedService ?? '',
          'petType': selectedPetType ?? '',
          'date': _dateController.text,
        });
      });

      print('Appointment booked successfully!');
    } catch (e) {
      print('Error booking appointment: $e');
    }
  }

  void _showAppointmentForm() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 16,
              left: 16,
              right: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Book an Appointment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Vet Name',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedVet,
                  items: veterinarians.map((vet) {
                    return DropdownMenuItem<String>(
                      value: vet,
                      child: Text(vet),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVet = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Service',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedService,
                  items: ['Grooming', 'Vaccination', 'Check-up'].map((service) {
                    return DropdownMenuItem<String>(
                      value: service,
                      child: Text(service),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedService = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Pet Type',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedPetType,
                  items: ['Cat', 'Dog'].map((petType) {
                    return DropdownMenuItem<String>(
                      value: petType,
                      child: Text(petType),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPetType = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _dateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Choose Date and Time',
                    border: OutlineInputBorder(),
                  ),
                  onTap: _selecDate,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
                  onPressed: () {
                    _saveAppointment();
                    Navigator.pop(context);
                  },
                  child: const Text('Book Now'),
                ),
                const SizedBox(height: 40)
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, String> appointment) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vet: ${appointment['vet'] ?? 'Unknown'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Service: ${appointment['service'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pet Type: ${appointment['petType'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${appointment['date'] ?? 'N/A'}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return _buildAppointmentCard(appointment);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAppointmentForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}

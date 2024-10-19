import 'package:flutter/material.dart';
import 'package:pawsitiveminder/models/AppointmentpageSub.dart';


class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String? selectedVet;
  String? selectedService;
  String? selectedPetType;
  String? selectedDay;
  String? selectedTime;

  List<String> availableDays = ['monday', 'wednesday', 'friday'];
  List<String> availableTimes = ['7-9 am', '9-11 am', '1-3 pm'];

  // Shared List to store appointments
  List<Map<String, String>> appointments = [];

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Book an Appointment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Vets name',
                    border: OutlineInputBorder(),
                  ),
                  value: selectedVet,
                  items: ['Vet 1', 'Vet 2', 'Vet 3'].map((vet) {
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
                    labelText: 'Services',
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
                    labelText: 'CAT / DOG',
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
                const Text(
                  'Available days',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: availableDays.map((day) {
                    return ChoiceChip(
                      label: Text(day),
                      selected: selectedDay == day,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedDay = selected ? day : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Available time',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: availableTimes.map((time) {
                    return ChoiceChip(
                      label: Text(time),
                      selected: selectedTime == time,
                      onSelected: (bool selected) {
                        setState(() {
                          selectedTime = selected ? time : null;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Save the appointment details
                    setState(() {
                      appointments.add({
                        'vet': selectedVet ?? '',
                        'service': selectedService ?? '',
                        'petType': selectedPetType ?? '',
                        'day': selectedDay ?? '',
                        'time': selectedTime ?? '',
                      });

                      // Clear the form fields after booking
                      selectedVet = null;
                      selectedService = null;
                      selectedPetType = null;
                      selectedDay = null;
                      selectedTime = null;
                    });
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: const Text('Book Now'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _onItemTapped(int index) {
    setState(() {
    });
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
      body: AppointmentPage(appointments: appointments),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAppointmentForm,
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
    );
      
  }
}

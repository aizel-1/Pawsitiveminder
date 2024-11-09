import 'package:firebase/models/AppointmentpageSub.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  TextEditingController _dateController = TextEditingController();

  Future<void> _selecDate() async {
  DateTime? _picked = await showDatePicker(
    context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100)
      );
      if (_picked != null){
        setState(() {
          _dateController.text = _picked.toString().split(" ")[0];
        }
        );
      }
}

  String? selectedVet;
  String? selectedService;
  String? selectedPetType;
  String? selectedDate;
  String? selectedTime;

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
                // const Text(
                //   'Available days',
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 8),
                // Wrap(
                //   spacing: 8,
                //   children: availableDays.map((day) {
                //     return ChoiceChip(
                //       label: Text(day),
                //       selected: selectedDay == day,
                //       selectedColor: Colors.brown,
                //       onSelected: (bool selected) {
                //         setState(() {
                //           selectedDay = selected ? day : null;
                //         });
                //       },
                //     );
                //   }).toList(),
                // ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                      labelText: 'chose date',
                      filled: true,
                      prefixIcon: Icon(Icons.calendar_today),
                      enabledBorder:
                          OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  readOnly: true,
                  onTap: (){
                    _selecDate();
                  },
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
                      selectedColor: Colors.brown,
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
                        'date': _dateController.text,
                        'time': selectedTime ?? '',
                      });

                      // Clear the form fields after booking
                      selectedVet = null;
                      selectedService = null;
                      selectedPetType = null;
                      selectedDate = null;
                      selectedTime = null;
                      _dateController.clear();
                    });
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: const Text('Book Now'),
                ),
                const  SizedBox(height: 30)
              ],
            ),
          ),
        );
      },
    );
  }

  // void _onItemTapped(int index) {
  //   setState(() {
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //     appBar: AppBar(
      // title: const Center(
      //         child: Text(
      //           'Pawsitive',
      //           style: TextStyle(
      //             color: Colors.black,
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //       actions: const [
      //         Icon(Icons.pets)

      //       ],
      //     ),
      body: AppointmentPage(appointments: appointments),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10),
        child: FloatingActionButton(
          onPressed: _showAppointmentForm,
          backgroundColor: Colors.brown,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class Vetshomepage extends StatefulWidget {
  const Vetshomepage({super.key});

  @override
  State<Vetshomepage> createState() => _VetshomepageState();
}

class _VetshomepageState extends State<Vetshomepage> {

DateTime selectedDate = DateTime.now();
  final DateTime firstDate = DateTime(2020);
  final DateTime lastDate = DateTime(2030);

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
                  const Center(child: Text('Reschedule', style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 16),)),
                  const SizedBox(
                    height: 16,
                  ),
                  CalendarDatePicker(initialDate: selectedDate , firstDate: firstDate, lastDate: lastDate, onDateChanged: (DateTime value) {  },)
                ],
              ),
              ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _showAppointmentForm,
        backgroundColor: Colors.brown,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
                  )
                ]),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('appointment'),
              SizedBox(height: 10,
              )],
            ),
          ),
        ),
      ),
    );
  }
}

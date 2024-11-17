import 'package:firebase/models/AppointmentDetailPage.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  final List<Map<String, String>> appointments;

  const AppointmentPage({super.key, required this.appointments});

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
                        Text('veterinarian: ${appointment['vet']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Service: ${appointment['service']}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('Pet: ${appointment['petType']}', style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('Day: ${appointment['date']}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
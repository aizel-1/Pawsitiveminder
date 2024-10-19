import "package:flutter/material.dart";

class AppointmentDetailPage extends StatelessWidget {
  final Map<String, String> appointment;

  const AppointmentDetailPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Vet: ${appointment['vet']}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Service: ${appointment['service']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Pet: ${appointment['petType']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Day: ${appointment['day']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Time: ${appointment['time']}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

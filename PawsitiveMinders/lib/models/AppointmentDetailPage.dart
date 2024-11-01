import "package:flutter/material.dart";

class AppointmentDetailPage extends StatelessWidget {
  final Map<String, String> appointments;

  const AppointmentDetailPage({super.key, required this.appointments});

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
            Text('Vet: ${appointments['vet']}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text('Service: ${appointments['service']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Pet: ${appointments['petType']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Day: ${appointments['day']}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text('Time: ${appointments['time']}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}

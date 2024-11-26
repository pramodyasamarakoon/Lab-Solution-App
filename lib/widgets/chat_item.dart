import 'package:flutter/material.dart';
import '../models/patient.dart';

class ChatItem extends StatelessWidget {
  final Patient patient;

  const ChatItem({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    print("ChatItem for: ${patient.name}"); // Add this to debug
    return Padding(
      padding: const EdgeInsets.only(top: 2.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(patient.image),
        ),
        title: Text(
          patient.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${patient.age} years, ${patient.gender}',
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              patient.time,
              style: const TextStyle(fontSize: 12, color: Colors.green),
            ),
            const SizedBox(height: 4),
            CircleAvatar(
              backgroundColor: Colors.green,
              radius: 14,
              child: Text(
                patient.labTests.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

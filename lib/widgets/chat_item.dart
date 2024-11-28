import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../pages/chat_page.dart';

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
        trailing: Container(
          width: 100, // Fixed width to prevent trailing elements from shifting
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.end, // Align everything to the right
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                patient.time,
                style: const TextStyle(fontSize: 12, color: Colors.green),
              ),
              const SizedBox(height: 4),
              // Only show the lab test count if the status is not 'Results Entered'
              patient.status == 'Results Entered'
                  ? const SizedBox(
                      height: 12) // Empty space to maintain position
                  : CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 12,
                      child: Text(
                        patient.labTests.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
            ],
          ),
        ),
        onTap: () {
          // Navigate to the chat screen with the patient data
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(patient: patient),
            ),
          );
        },
      ),
    );
  }
}

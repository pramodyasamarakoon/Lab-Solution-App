// lib/pages/mlt_home_page.dart

import 'package:flutter/material.dart';
import 'package:first_flutter_app/models/patient.dart'; // Import the Patient model
import 'package:first_flutter_app/services/patient_service.dart'; // Import the PatientService
import '../widgets/filter_button.dart';

class MLTHomePage extends StatefulWidget {
  const MLTHomePage({super.key});

  @override
  _MLTHomePageState createState() => _MLTHomePageState();
}

class _MLTHomePageState extends State<MLTHomePage> {
  String activeButton = 'All'; // Default active button

  void _onFilterButtonPressed(String buttonText) {
    setState(() {
      activeButton = buttonText; // Update active button state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'eLab Connect',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              print('Search tapped');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {
              print('Three dots tapped');
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Filter buttons row
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling
              child: Row(
                children: [
                  FilterButton(
                    text: 'All',
                    isActive:
                        activeButton == 'All', // Set active based on button
                    onPressed: () =>
                        _onFilterButtonPressed('All'), // Update active button
                  ),
                  FilterButton(
                    text: 'Sample to be collected',
                    isActive: activeButton == 'Sample to be collected',
                    onPressed: () =>
                        _onFilterButtonPressed('Sample to be collected'),
                  ),
                  FilterButton(
                    text: 'Sample Collected',
                    isActive: activeButton == 'Sample Collected',
                    onPressed: () => _onFilterButtonPressed('Sample Collected'),
                  ),
                  FilterButton(
                    text: 'Sample Collected Done',
                    isActive: activeButton == 'Sample Collected Done',
                    onPressed: () =>
                        _onFilterButtonPressed('Sample Collected Done'),
                  ),
                ],
              ),
            ),
          ),
          // Patient List
          Expanded(
            child: FutureBuilder<List<Patient>>(
              future: PatientService.loadPatients(), // Load patient data
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No patients found.'));
                }

                // List of patients loaded successfully
                List<Patient> patients = snapshot.data!;

                return ListView.builder(
                  itemCount: patients.length,
                  itemBuilder: (context, index) {
                    Patient patient = patients[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: patient.image.isNotEmpty
                            ? AssetImage(
                                patient.image) // Use the image from the JSON
                            : AssetImage(
                                'assets/images/default.jpg'), // Placeholder image
                      ),
                      title: Text(patient.name),
                      subtitle: Row(
                        children: [
                          Text('${patient.age} years, ${patient.gender}'),
                          const SizedBox(width: 8),
                          Text(patient.time),
                        ],
                      ),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 14,
                        child: Text(
                          patient.labTests.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// lib/pages/mlt_home_page.dart

import 'package:flutter/material.dart';
import 'package:first_flutter_app/models/patient.dart'; // Import the Patient model
import 'package:first_flutter_app/services/patient_service.dart'; // Import the PatientService
import '../widgets/filter_button.dart';
import '../widgets/chat_item.dart';

class MLTHomePage extends StatefulWidget {
  const MLTHomePage({super.key});

  @override
  _MLTHomePageState createState() => _MLTHomePageState();
}

class _MLTHomePageState extends State<MLTHomePage> {
  String activeButton = 'All'; // Default active button
  List<Patient> patientList = []; // To hold the list of patients

  @override
  void initState() {
    super.initState();
    print("Calling loadPatientData...");
    loadPatientData();
  }

  Future<void> loadPatientData() async {
    print('Loading patient data...');
    List<Patient> patients = await PatientService.loadPatients();
    setState(() {
      patientList = patients;
    });
  }

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
          // Patient list (chat list) under filter buttons
          Expanded(
            child: RefreshIndicator(
              onRefresh: loadPatientData, // Trigger refresh on pull down
              child: patientList.isEmpty
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator
                  : ListView.builder(
                      itemCount: patientList.length,
                      itemBuilder: (context, index) {
                        Patient patient = patientList[index];
                        return ChatItem(patient: patient);
                      },
                    ),
            ),
          )
        ],
      ),
    );
  }
}

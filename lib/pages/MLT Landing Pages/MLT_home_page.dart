import 'package:flutter/material.dart';
import 'package:first_flutter_app/models/patient.dart'; // Import the Patient model
import 'package:first_flutter_app/services/patient_service.dart'; // Import the PatientService
import '../../widgets/filter_button.dart';
import '../../widgets/chat_item.dart';
import '../Login Pages/sign_in_page.dart';
import '../MLT Landing Pages/patient_registration.dart'; // Import the patient registration screen
import '../../widgets/floating_action_button.dart'; // Import the custom FAB widget

class MLTHomePage extends StatefulWidget {
  const MLTHomePage({super.key});

  @override
  _MLTHomePageState createState() => _MLTHomePageState();
}

class _MLTHomePageState extends State<MLTHomePage> {
  String activeButton = 'All'; // Default active button
  List<Patient> patientList = []; // To hold the full list of patients
  List<Patient> filteredPatientList = []; // To hold the filtered patient list
  bool isLoading = false; // To track the loading state

  @override
  void initState() {
    super.initState();
    loadPatientData();
  }

  Future<void> loadPatientData() async {
    setState(() {
      isLoading = true; // Start loading
    });
    List<Patient> patients = await PatientService.loadPatients();
    setState(() {
      patientList = patients;
      activeButton = 'All'; // Reset active button to 'All'
      filteredPatientList = patients; // Reset to show all patients
      isLoading = false; // Stop loading
    });
  }

  // Filter the patient list based on the selected status
  void _onFilterButtonPressed(String buttonText) {
    setState(() {
      activeButton = buttonText; // Update active button state
      isLoading = true; // Start loading while filtering

      if (buttonText == 'All') {
        filteredPatientList = patientList; // Show all patients
      } else {
        // Filter by status while safely checking for null
        filteredPatientList = patientList
            .where((patient) =>
                patient.status != null && patient.status == buttonText)
            .toList(); // Filter by status
      }

      // Stop the loading after filtering
      isLoading = false;
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              );
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
                    isActive: activeButton == 'All',
                    onPressed: () => _onFilterButtonPressed('All'),
                  ),
                  FilterButton(
                    text: 'Sample to be collected',
                    isActive: activeButton == 'Sample to be collected',
                    onPressed: () =>
                        _onFilterButtonPressed('Sample to be collected'),
                  ),
                  FilterButton(
                    text: 'Results to be entered',
                    isActive: activeButton == 'Results to be entered',
                    onPressed: () =>
                        _onFilterButtonPressed('Results to be entered'),
                  ),
                  FilterButton(
                    text: 'Results Entered',
                    isActive: activeButton == 'Results Entered',
                    onPressed: () => _onFilterButtonPressed('Results Entered'),
                  ),
                ],
              ),
            ),
          ),
          // Patient List
          Expanded(
            child: RefreshIndicator(
              onRefresh: loadPatientData,
              child: isLoading // Show loading indicator when filtering
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : filteredPatientList.isEmpty
                      ? const Center(
                          child: Text('No patients found for this status'),
                        )
                      : ListView.builder(
                          itemCount: filteredPatientList.length,
                          itemBuilder: (context, index) {
                            Patient patient = filteredPatientList[index];
                            return ChatItem(patient: patient);
                          },
                        ),
            ),
          ),
        ],
      ),
      // Use the custom FAB widget and pass the target screen (PatientRegistrationPage) to it
      floatingActionButton: CustomFloatingActionButton(
        targetScreen: const PatientRegistrationPage(), // Pass the screen here
      ),
    );
  }
}

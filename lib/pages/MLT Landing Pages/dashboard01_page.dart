import 'package:flutter/material.dart';
import '../../models/patient_list_model.dart'; // Import PatientList model
import '../../services/patient_list_service.dart'; // Import PatientListService

class Dashboard01Page extends StatefulWidget {
  const Dashboard01Page({super.key});

  @override
  _Dashboard01PageState createState() => _Dashboard01PageState();
}

class _Dashboard01PageState extends State<Dashboard01Page> {
  // To hold patients fetched from the JSON file
  List<PatientList> patientList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Load the patient data when the page is initialized
    _loadPatientData();
  }

  Future<void> _loadPatientData() async {
    setState(() {
      isLoading = true;
    });
    List<PatientList> patients = await PatientListService.loadPatients();
    setState(() {
      patientList = patients;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Patient List'),
          backgroundColor: Colors.white,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: patientList.length,
                      itemBuilder: (context, index) {
                        final patient = patientList[index];
                        return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text('PHN: ${patient.id}'),
                              subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Full Name: ${patient.fullName}'),
                                    Text('Gender: ${patient.gender}'),
                                    Text('Date of birth: ${patient.birthday}'),
                                    Text('Age: ${patient.age}'),
                                    Text('Email: ${patient.email}'),
                                    Text('Mobile: ${patient.mobile}'),
                                    Text('NIC: ${patient.nic}'),
                                  ]),
                            ));
                      },
                    ))
                  ],
                )));
  }
}

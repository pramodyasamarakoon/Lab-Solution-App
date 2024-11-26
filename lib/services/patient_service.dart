// lib/services/patient_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';  // For rootBundle to load assets
import 'package:first_flutter_app/models/patient.dart'; // Import the Patient model

class PatientService {
  // This function will load the patient data from the JSON file
  static Future<List<Patient>> loadPatients() async {
    // Load the JSON string from assets using rootBundle
    String data = await rootBundle.loadString('assets/data/mock_data.json');

    // Decode the JSON string into a list of dynamic data
    List<dynamic> jsonData = json.decode(data);

    // Convert the decoded JSON data into a list of Patient objects
    return jsonData.map((json) => Patient.fromJson(json)).toList();
  }
}

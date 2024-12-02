import 'dart:convert';
import 'patient_list_model.dart';

class PatientListResponse {
  List<PatientList> patients;

  PatientListResponse({required this.patients});

  // Factory method to create a PatientListResponse from JSON
  factory PatientListResponse.fromJson(String jsonString) {
    final jsonData = jsonDecode(jsonString);
    return PatientListResponse(
      patients: List<PatientList>.from(
        jsonData['patients'].map((patient) => PatientList.fromJson(patient)),
      ),
    );
  }

  // Method to convert PatientListResponse to JSON
  String toJson() {
    final jsonData = {
      'patients': patients.map((patient) => patient.toJson()).toList(),
    };
    return jsonEncode(jsonData);
  }

  // Convert a list of patients from JSON Map
  static List<PatientList> fromJsonList(String jsonString) {
    final jsonData = jsonDecode(jsonString);
    return List<PatientList>.from(
      jsonData['patients'].map((patient) => PatientList.fromJson(patient)),
    );
  }
}

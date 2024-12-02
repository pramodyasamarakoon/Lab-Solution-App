import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/patient_list_model.dart';
import '../models/patient_list_response.dart';

class PatientListService {
  // Function to get the file path for the JSON file
  static Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/patients.json';
  }

  // Function to load the list of patients from the JSON file
  static Future<List<PatientList>> loadPatients() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);

      if (await file.exists()) {
        final contents = await file.readAsString();
        final patientList = PatientListResponse.fromJson(contents);
        return patientList.patients;
      } else {
        return []; // If file doesn't exist, return an empty list
      }
    } catch (e) {
      print("Error loading patients: $e");
      return [];
    }
  }

  // Function to save a new patient to the JSON file
  static Future<void> savePatient(PatientList patient) async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);

      // Load existing patients
      List<PatientList> patients = await loadPatients();

      // Add the new patient
      patients.add(patient);

      // Convert the list to JSON and write it to the file
      String jsonString = PatientListResponse(patients: patients).toJson();
      await file.writeAsString(jsonString);
      print("Patient saved successfully.");
    } catch (e) {
      print("Error saving patient: $e");
    }
  }

  // Function to save a new patient with auto-generated password and ID
  static Future<void> savePatientWithGeneratedPassword(
      PatientList patient) async {
    try {
      final generatedPassword = PatientList.generateRandomPassword();
      final uniqueId = PatientList.generateUniqueId();

      final newPatient = PatientList(
        id: uniqueId, // Use the generated unique ID
        fullName: patient.fullName,
        email: patient.email,
        mobile: patient.mobile,
        nic: patient.nic,
        password: generatedPassword, // Save the generated password
      );

      // Save the new patient with the generated password
      await savePatient(newPatient);
      print(
          'Patient saved with ID: $uniqueId and password: $generatedPassword');
    } catch (e) {
      print('Error saving patient with generated password: $e');
    }
  }

  // ---- NIC Calculations ----//

  // Calculate Birthday from NIC
  static DateTime calculateBirthday(String nic) {
    // Determine if the NIC is 10 or 12 digits long
    if (nic.length == 10) {
      return calculateBirthdayFrom10DigitNic(nic);
    } else if (nic.length == 12) {
      return calculateBirthdayFrom12DigitNic(nic);
    }
    throw Exception('Invalid NIC format');
  }

  // Calculate gender from NIC
  static String calculateGender(String nic) {
    if (nic.length == 10) {
      return calculateGenderFrom10DigitNic(nic);
    } else if (nic.length == 12) {
      return calculateGenderFrom12DigitNic(nic);
    }
    throw Exception('Invalid NIC format');
  }

  // Calculate age based on birthdate
  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;

    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  // 10 Digit NIC - Birthday Calculation (NIC before 2016)
  static DateTime calculateBirthdayFrom10DigitNic(String nic) {
    String yearPart = nic.substring(0, 2);
    String dayPart = nic.substring(2, 5);

    // Extract the year of birth (1900s)
    int year = 1900 + int.parse(yearPart);
    int dayOfYear = int.parse(dayPart);

    // For women, subtract 500 from the day number
    if (dayOfYear >= 500) {
      dayOfYear -= 500;
    }

    return DateTime(year).add(Duration(days: dayOfYear - 1));
  }

// 12 Digit NIC - Birthday Calculation (NIC from 2016 onwards)
  static DateTime calculateBirthdayFrom12DigitNic(String nic) {
    String yearPart = nic.substring(0, 4);
    String dayOfYearPart = nic.substring(4, 7);

    int year = int.parse(yearPart);
    int dayOfYear = int.parse(dayOfYearPart);

    // For women, subtract 500 from the day number
    if (dayOfYear >= 500) {
      dayOfYear -= 500;
    }

    return DateTime(year).add(Duration(days: dayOfYear - 1));
  }

  // 10 Digit NIC - Gender Calculation (NIC before 2016)
  static String calculateGenderFrom10DigitNic(String nic) {
    int genderPart = int.parse(nic.substring(2, 5));
    return genderPart < 500 ? 'Male' : 'Female';
  }

  // 12 Digit NIC - Gender Calculation (NIC from 2016 onwards)
  static String calculateGenderFrom12DigitNic(String nic) {
    int genderPart =
        int.parse(nic.substring(4, 7)); // First 3 digits of day number
    return genderPart < 500 ? 'Male' : 'Female';
  }
}

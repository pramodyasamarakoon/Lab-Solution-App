import 'dart:convert';
import 'dart:math';
import '../services/patient_list_service.dart';

class PatientList {
  final String id; // Unique ID
  final String fullName;
  final String email;
  final String mobile;
  final String nic;
  final String password; // New field for password

  // Constructor
  PatientList({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.nic,
    required this.password, // Include password in constructor
  });

  // Getters for gender, birthday, and age
  String get gender => PatientListService.calculateGender(nic);
  DateTime get birthday => PatientListService.calculateBirthday(nic);
  int get age => PatientListService.calculateAge(birthday);

  // Convert a Patient object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
      'nic': nic,
      'password': password, // Store password in the map
    };
  }

  // Convert a Map to a Patient object
  factory PatientList.fromMap(Map<String, dynamic> map) {
    return PatientList(
      id: map['id'],
      fullName: map['fullName'],
      email: map['email'],
      mobile: map['mobile'],
      nic: map['nic'],
      password: map['password'], // Retrieve password from map
    );
  }

  // Convert a Patient object to a JSON string
  String toJson() => json.encode(toMap());

  // Create a Patient object from a JSON string
  factory PatientList.fromJson(String source) =>
      PatientList.fromMap(json.decode(source));

  // Helper method to generate a random password
  static String generateRandomPassword([int length = 8]) {
    const charset =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random.secure();
    return List.generate(
        length, (index) => charset[random.nextInt(charset.length)]).join();
  }

  // Helper method to generate a unique ID for each patient
  static String generateUniqueId() {
    const charset =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    Random random = Random.secure();
    return List.generate(10, (index) => charset[random.nextInt(charset.length)])
        .join();
  }
}

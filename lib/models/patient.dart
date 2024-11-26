// lib/models/patient.dart

class Patient {
  final String name;
  final int age;
  final String gender;
  final String time;
  final int labTests;
  final String image;

  Patient({
    required this.name,
    required this.age,
    required this.gender,
    required this.time,
    required this.labTests,
    required this.image,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      name: json['name'] ?? 'Unknown',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? 'Unknown',
      time: json['time'] ?? 'Unknown',
      labTests: json['labTests'] ?? 0,
      image: json['image'] ?? '', // Default empty string if missing
    );
  }
}

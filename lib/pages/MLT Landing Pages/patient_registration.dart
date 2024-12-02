import 'package:flutter/material.dart';
import '../../services/patient_list_service.dart';
import '../../models/patient_list_model.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';

class PatientRegistrationPage extends StatefulWidget {
  const PatientRegistrationPage({super.key});

  @override
  _PatientRegistrationPageState createState() =>
      _PatientRegistrationPageState();
}

class _PatientRegistrationPageState extends State<PatientRegistrationPage> {
  final _formKey = GlobalKey<FormState>(); // For form validation
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _nicController = TextEditingController();
  bool _isLoading = false;

 void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    // Collect the patient data into a Patient object
    PatientList newPatient = PatientList(
      id: '', // Initially empty, will be generated
      fullName: _nameController.text,
      email: _emailController.text,
      mobile: _mobileController.text,
      nic: _nicController.text,
      password: '', // Initially empty, will be generated
    );

    // Calculate birthday, gender, and age
    DateTime birthday = PatientListService.calculateBirthday(newPatient.nic);
    String gender = PatientListService.calculateGender(newPatient.nic);
    int age = PatientListService.calculateAge(birthday);

    // Log or display calculated details (optional)
    print('Patient Birthday: $birthday');
    print('Patient Gender: $gender');
    print('Patient Age: $age');

    // Save the patient data using the service (with generated password and ID)
    await PatientListService.savePatientWithGeneratedPassword(newPatient);

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Patient successfully registered!')),
    );

    // Navigate back to the previous screen (or home screen)
    Navigator.pop(context);
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Patient Registration'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Full Name Input
              CustomInput(
                hintText: 'Enter Full Name',
                controller: _nameController,
                validator: Validators.validateFullName,
              ),
              const SizedBox(height: 16),

              // Email Input
              CustomInput(
                hintText: 'Enter Email Address',
                controller: _emailController,
                validator: Validators.validateEmail,
              ),
              const SizedBox(height: 16),

              // Mobile Number Input
              CustomInput(
                hintText: 'Enter Mobile Number',
                controller: _mobileController,
                validator: Validators.validateMobile,
              ),
              const SizedBox(height: 16),

              // NIC Input
              CustomInput(
                hintText: 'Enter NIC',
                controller: _nicController,
                validator: Validators.validateNIC,
              ),
              const SizedBox(height: 32),

              // Register Button
              CustomButton(
                text: 'Register Patient',
                isLoading: _isLoading,
                onPressed: _submitForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

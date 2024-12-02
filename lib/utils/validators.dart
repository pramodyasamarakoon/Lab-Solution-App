class Validators {
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full Name is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required.';
    }
    final regex = RegExp(r'^[0-9]{10}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit mobile number.';
    }
    return null;
  }

  static String? validateNIC(String? value) {
    if (value == null || value.isEmpty) {
      return 'NIC is required.';
    }

    // Check for the NIC format (9 digits + V/v at the end OR 12 digits)
    final regex = RegExp(r'^\d{9}[Vv]$|^\d{12}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid NIC (e.g., 123456789V, 123456789v or 123456789012).';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }
}

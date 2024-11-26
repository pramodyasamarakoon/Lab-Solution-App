import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final FocusNode? nextFocusNode;
  final FocusNode? previousFocusNode;

  const OTPInput({
    super.key,
    required this.controller,
    required this.focusNode,
    this.nextFocusNode,
    this.previousFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Allow digits only
        ],
        onChanged: (value) {
          if (value.isNotEmpty) {
            // If user types a value, move focus to the next field
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          } else if (value.isEmpty) {
            // If the field is cleared (backspace), move focus to the previous field
            if (previousFocusNode != null) {
              FocusScope.of(context).requestFocus(previousFocusNode);
            }
          }
        },
        onTap: () {
          // Focus this field when tapped
          FocusScope.of(context).requestFocus(focusNode);
        },
      ),
    );
  }
}

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
            if (nextFocusNode != null) {
              FocusScope.of(context)
                  .requestFocus(nextFocusNode); // Move to the next field
            }
          }
        },
        onFieldSubmitted: (_) {
          if (nextFocusNode != null) {
            FocusScope.of(context).requestFocus(nextFocusNode);
          }
        },
        // onKey: (event) {
        //   if (event.logicalKey == LogicalKeyboardKey.backspace &&
        //       controller.text.isEmpty) {
        //     // Move focus to the previous field on backspace if current field is empty
        //     if (previousFocusNode != null) {
        //       FocusScope.of(context).requestFocus(previousFocusNode);
        //     }
        //   }
        // },
      ),
    );
  }
}

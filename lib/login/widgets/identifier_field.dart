import 'package:flutter/material.dart';

// Identifier field widget to be used in login form widget

class IdentifierField extends StatelessWidget {
  final TextEditingController controller;

  const IdentifierField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'Identifier',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.person_outline),
      ),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your identifier';
        }
        return null;
      },
    );
  }
}

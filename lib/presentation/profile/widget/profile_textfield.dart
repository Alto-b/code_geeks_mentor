
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final bool readonly;
  final maxlines;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.readonly,
    this.validator,
    this.maxlines

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        readOnly: readonly,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        validator: validator,
        maxLines: maxlines,
      ),
    );
  }
}

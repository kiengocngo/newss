import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final String text;
  final TextInputType type;
  final Icon prefixIcon;
  final TextEditingController controller;

  const TextInputField({
    Key? key,
    required this.text,
    required this.type,
    required this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        keyboardType: type,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        enableInteractiveSelection: false,
        obscureText: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey,
          prefixIcon: prefixIcon,
          contentPadding: const EdgeInsets.only(left: 4),
          hintText: text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }
}

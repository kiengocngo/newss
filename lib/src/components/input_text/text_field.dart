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
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      keyboardType: type,
      textInputAction: TextInputAction.next,
      controller: controller,
      textAlignVertical: TextAlignVertical.center,
      textAlign: TextAlign.start,
      enableInteractiveSelection: false,
      obscureText: false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.only(left: 4),
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}

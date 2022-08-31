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
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: TextFormField(
          keyboardType: type,
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.start,
          enableInteractiveSelection: false,
          obscureText: false,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            contentPadding: const EdgeInsets.only(left: 4),
            hintText: text,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}

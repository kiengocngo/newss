import 'package:flutter/material.dart';

class PassWordField extends StatefulWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController passwordController;
  const PassWordField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<PassWordField> createState() => _PassWordFieldState();
}

class _PassWordFieldState extends State<PassWordField> {
  bool isVisible = true;
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
          controller: widget.passwordController,
          textAlignVertical: TextAlignVertical.center,
          enableInteractiveSelection: false,
          obscureText: isVisible,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 4),
              hintText: widget.hintText,
              border: InputBorder.none,
              prefixIcon: widget.prefixIcon,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: isVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off),
              )),
        ),
      ),
    );
  }
}

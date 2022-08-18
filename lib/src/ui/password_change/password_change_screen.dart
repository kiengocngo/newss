import 'package:flutter/material.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Password Change',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(children: [
          TextFormField(
            obscureText: _isObscure,
            controller: currentPasswordController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                hintText: 'Input Current Password',
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                label: const Text(
                  'Current Password',
                  style: TextStyle(fontSize: 20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: _isObscure1,
            controller: newPasswordController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure1 = !_isObscure1;
                    });
                  },
                  icon: Icon(
                    _isObscure1 ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                hintText: 'Input New Password',
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                label: const Text(
                  'New Password',
                  style: TextStyle(fontSize: 20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: _isObscure2,
            controller: confirmPasswordController,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure2 = !_isObscure2;
                    });
                  },
                  icon: Icon(
                    _isObscure2 ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
                hintText: 'Confirm New Password',
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                label: const Text(
                  'Confirm Password',
                  style: TextStyle(fontSize: 20),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {},
            child: Center(
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(16)),
                child: const Center(
                  child: Text(
                    'Submit Change',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/src/components/input_text/password_field.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class SignUpAvatar extends InheritedWidget {
  // ignore: use_key_in_widget_constructors
  SignUpAvatar({required Widget child, required this.file})
      : super(
          child: child,
        );
  File? file;

  static SignUpAvatar? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SignUpAvatar>();
  }

  @override
  bool updateShouldNotify(SignUpAvatar oldWidget) {
    return file != oldWidget.file;
  }
}

class SignUpScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        centerTitle: true,
      ),
      body: SignUpAvatar(
          file: null,
          child: Column(
            children: <Widget>[
              // ignore: prefer_const_constructors
              AvatarPicker(),
              TextInputField(
                  text: "Enter your name",
                  type: TextInputType.phone,
                  prefixIcon: const Icon(Icons.text_fields),
                  controller: _nameController),
              TextInputField(
                  text: "Enter your email",
                  type: TextInputType.name,
                  prefixIcon: const Icon(Icons.email),
                  controller: _emailController),
              PassWordField(
                  hintText: "Enter your password",
                  prefixIcon: const Icon(Icons.lock),
                  passwordController: _passwordController),
              PassWordField(
                  hintText: "Re Enter your password",
                  prefixIcon: const Icon(Icons.lock),
                  passwordController: _reEnterPasswordController),
              TextInputField(
                  text: "Enter your phone number",
                  type: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  controller: _phoneController),
              InkWell(
                onTap: () {},
                child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF3366FF),
                            Color(0xFF00CCFF),
                          ],
                          begin: FractionalOffset(0.0, 0.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 16),
                      )),
                    )),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text("Already have an account? Log in")),
            ],
          )),
    );
  }
}

class AvatarPicker extends StatefulWidget {
  const AvatarPicker({Key? key}) : super(key: key);

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  _getFromGallery() async {
    if (Platform.isAndroid) {
      PermissionStatus permissions = await Permission.storage.request();
      if (permissions.isGranted) {
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        // ignore: use_build_context_synchronously,

        setState(() {
          SignUpAvatar.of(context)!.file = File(imagePicker!.path);
        });
      } else if (permissions.isDenied) {
      } else if (permissions.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      PermissionStatus permissions = await Permission.photos.request();
      if (permissions.isGranted) {
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        // ignore: use_build_context_synchronously

        setState(() {
          SignUpAvatar.of(context)!.file = File(imagePicker!.path);
        });
      } else {
        openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Center(
            child: CircleAvatar(
              radius: 50, // Image radius
              backgroundImage: SignUpAvatar.of(context)?.file != null
                  ? FileImage(
                      File(SignUpAvatar.of(context)!.file!.path),
                    ) as ImageProvider
                  : const AssetImage("assets/images/tom.jpg"),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: _getFromGallery,
            child: Container(
                height: size.height * 0.05,
                width: size.width * 0.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                      colors: [
                        Color(0xFF3366FF),
                        Color(0xFF00CCFF),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: const Center(
                    child: Text(
                  "Choose your image",
                  style: TextStyle(fontSize: 16),
                ))),
          ),
        ),
      ],
    );
  }
}

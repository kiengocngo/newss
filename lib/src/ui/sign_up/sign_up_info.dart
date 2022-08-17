import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/blocs/info_changes_bloc/info_changes_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:news_app/src/components/input_text/text_field.dart';

//Inherited Widget de truyen data
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

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  late Map<String, String> args;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  SignUpScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<LogInBloc, LogInState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        switch (state.logInStatus) {
          case LogInStatus.loading:
            {
              return const Scaffold(
                body: Center(
                  child: Text("Loading"),
                ),
              );
            }
          case LogInStatus.loaded:
            {
              return Scaffold(
                appBar: AppBar(
                  title: const Text("Sign up"),
                  centerTitle: true,
                ),
                body: SignUpAvatar(
                    file: null,
                    child: SingleChildScrollView(
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
                              text: "Enter your Address",
                              type: TextInputType.name,
                              prefixIcon: const Icon(Icons.email),
                              controller: _addressController),
                          TextInputField(
                              text: "Enter your phone number",
                              type: TextInputType.phone,
                              prefixIcon: const Icon(Icons.phone),
                              controller: _phoneController),
                          BlocListener<InfoChangesBloc, InfoChangesState>(
                            listener: (context, state) {
                              if (state.changesStage == ChangesStage.success) {
                                Navigator.pushNamed(
                                  context,
                                  '/details',
                                );
                              }
                            },
                            child: InkWell(
                              onTap: () {
                                log("a");
                                final bytes = SignUpAvatar.of(context)!
                                    .file!
                                    .readAsBytesSync();
                                log("bytes" + "${bytes == null}");
                                context.read<InfoChangesBloc>().add(
                                    InfoAddNewUserEvent(
                                        uid: state.message,
                                        name: _nameController.text,
                                        email: args["email"]!,
                                        password: args["password"]!,
                                        phoneNumber: _phoneController.text,
                                        address: _addressController.text,
                                        base64Image: base64.encode(
                                            bytes != null ? bytes : [1, 2, 3])));
                              },
                              child: Container(
                                  height: size.height * 0.05,
                                  width: size.width * 0.4,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
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
                          ),
                          TextButton(
                              onPressed: () {},
                              child:
                                  const Text("Already have an account? Log in")),
                        ],
                      ),
                    )),
              );
            }
          default:
            {
              return const Scaffold(
                body: Icon(
                  Icons.error,
                  size: 150,
                ),
              );
            }
        }
      },
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
    // check Platform
    if (Platform.isAndroid) {
      PermissionStatus permissions = await Permission.storage.request();
      if (permissions.isGranted) {
        //lay anh tu android gallery
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        // ignore: use_build_context_synchronously,

        setState(() {
          // thanh cong
          SignUpAvatar.of(context)!.file = File(imagePicker!.path);
        });
      } else if (permissions.isDenied) {
        openAppSettings();
      } else if (permissions.isPermanentlyDenied) {
        // user Denied --> xin quyen vao settings
        openAppSettings();
      }
    } else {
      //lay anh tu Ios gallery
      PermissionStatus permissions = await Permission.photos.request();
      if (permissions.isGranted) {
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        // ignore: use_build_context_synchronously

        setState(() {
          //thanh cong
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

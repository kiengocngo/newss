import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:news_app/cubit/image_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class AvatarSettings extends StatefulWidget {
  final String image;
  File? file;
  AvatarSettings({Key? key, required this.image}) : super(key: key);

  @override
  State<AvatarSettings> createState() => _AvatarSettingsState();
}

class _AvatarSettingsState extends State<AvatarSettings> {
  _getFromGallery() async {
    if (Platform.isAndroid) {
      PermissionStatus permissions = await Permission.storage.request();
      if (permissions.isGranted) {
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        setState(() {
          widget.file = File(imagePicker!.path);

          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          context.read<ImageCubit>().emit(File(imagePicker.path));
        });
      } else if (permissions.isDenied) {
        openAppSettings();
      } else if (permissions.isPermanentlyDenied) {
        openAppSettings();
      }
    } else {
      PermissionStatus permissions = await Permission.photos.request();
      if (permissions.isGranted) {
        final imagePicker =
            await ImagePicker().pickImage(source: ImageSource.gallery);

        setState(() {
          widget.file = File(imagePicker!.path);

          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          context.read<ImageCubit>().emit(File(imagePicker.path));
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
              child: context.read<ImageCubit>().state != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          FileImage(context.read<ImageCubit>().state!)
                              as ImageProvider,
                      backgroundColor: Colors.blue,
                    )
                  : ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size(100, 100), // Image radius
                        child: Image.memory(
                          base64.decode(widget.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )),
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
                  "Choose image",
                  style: TextStyle(fontSize: 16),
                ))),
          ),
        ),
      ],
    );
  }
}

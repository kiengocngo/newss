import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/cubit/image_cubit.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: must_be_immutable
class AvatarPicker extends StatefulWidget {
  File? file;
  AvatarPicker({Key? key}) : super(key: key);

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
          widget.file = File(imagePicker!.path);
          // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
          context.read<ImageCubit>().emit(File(imagePicker.path));
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
          widget.file = File(imagePicker!.path);
          //thanh cong
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
          child: BlocBuilder<ImageCubit, File?>(
            builder: (context, state) {
              return Center(
                child: CircleAvatar(
                  radius: 50, // Image radius
                  backgroundImage: context.read<ImageCubit>().state != null
                      ? FileImage(context.read<ImageCubit>().state!)
                          as ImageProvider
                      : const AssetImage("assets/images/tom.jpg"),
                ),
              );
            },
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

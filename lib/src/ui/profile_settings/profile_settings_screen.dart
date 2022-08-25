import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/update_users_bloc/update_users_bloc.dart';
import 'package:news_app/services/users_services.dart';
import 'package:news_app/src/models/my_users.dart';
import 'package:news_app/src/ui/profile_settings/avatar_settings.dart';
import 'package:news_app/src/ui/settings/settings_screen.dart';

import '../../../cubit/image_cubit.dart';

class ProfileScreen extends StatefulWidget {
  final MyUser users;
  const ProfileScreen({Key? key, required this.users}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _adddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.users.name;
    _phoneController.text = widget.users.phoneNumber;
    _adddressController.text = widget.users.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Container(
          color: Colors.green[200],
          child: SingleChildScrollView(
            child: Column(children: [
              AvatarSettings(
                image: widget.users.base64Image,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    label: const Text(
                      'Name',
                      style: TextStyle(fontSize: 20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                    label: const Text(
                      'Phone',
                      style: TextStyle(fontSize: 20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _adddressController,
                decoration: InputDecoration(
                    label: const Text(
                      'Address',
                      style: TextStyle(fontSize: 20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                    )),
              ),
              const SizedBox(
                height: 30,
              ),
              BlocListener<UpdateUsersBloc, UpdateUsersState>(
                listener: (context, state) {
                  if (state is UpdateUsersSuccess) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SettingsScreen()));
                  }
                  if (state is UpdateUsersErrors) {
                    log('error');
                  }
                },
                child: InkWell(
                  onTap: () {
                    final bytes =
                        context.read<ImageCubit>().state!.readAsBytesSync();
                    context.read<UpdateUsersBloc>().add(UpdateUsers(
                        uid: 'cZRLuMBnsdRkfPBOaIcKfI8sZBi1',
                        name: _nameController.text,
                        address: _adddressController.text,
                        phone: _phoneController.text,
                        base64Image: base64.encode(bytes)));
                  },
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                          color: Colors.blue[300],
                          borderRadius: BorderRadius.circular(16)),
                      child: const Center(
                          child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

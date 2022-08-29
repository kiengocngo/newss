import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/get_users_bloc/get_users_bloc.dart';
import 'package:news_app/blocs/update_users_bloc/update_users_bloc.dart';
import 'package:news_app/src/models/my_user.dart';
import 'package:news_app/src/ui/profile_settings/avatar_settings.dart';

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
                  if (state.updateState ==UpdateState.success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Update Success')));
                    context
                        .read<GetUsersBloc>()
                        .add(GetUsers(uid: widget.users.uid));
                    Navigator.pop(context);
                  }
                  if (state.updateState == UpdateState.error) {
                    log('error');
                  }
                },
                child: InkWell(
                  onTap: () {
                    final image = base64.decode(widget.users.base64Image);
                    final bytes = context.read<ImageCubit>().state != null
                        ? context.read<ImageCubit>().state!.readAsBytesSync()
                        : image;
                    context.read<UpdateUsersBloc>().add(UpdateUsers(
                        uid: widget.users.uid,
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

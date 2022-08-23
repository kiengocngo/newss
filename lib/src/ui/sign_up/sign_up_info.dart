import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/info_changes_bloc/info_changes_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/cubit/image_cubit.dart';

import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/src/models/my_user.dart';

import 'components/avatar_picker.dart';

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
            return const Scaffold(
              body: Center(
                child: Text("Loading"),
              ),
            );

          case LogInStatus.loaded:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Sign up"),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
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
                              '/home',
                            );
                          }
                        },
                        child: InkWell(
                          onTap: () {
                            final bytes = context
                                .read<ImageCubit>()
                                .state!
                                .readAsBytesSync();

                            context.read<InfoChangesBloc>().add(
                                InfoAddNewUserEvent(
                                    myUser: MyUser(
                                        uid: state.message,
                                        name: _nameController.text,
                                        email: args["email"]!,
                                        password: args["password"]!,
                                        phoneNumber: _phoneController.text,
                                        address: _addressController.text,
                                        friends: [],
                                        base64Image: base64.encode(bytes))));
                                        Navigator.pushNamed(context, "home");
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
                    ],
                  ),
                ),
              ),
            );
          default:
            return const Scaffold(
              body: Icon(
                Icons.error,
                size: 150,
              ),
            );
        }
      },
    );
  }
}

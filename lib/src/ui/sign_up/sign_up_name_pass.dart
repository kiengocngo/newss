import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:news_app/blocs/sign_up_bloc/sign_up_event.dart';
import 'package:news_app/blocs/sign_up_bloc/sign_up_state.dart';
import 'package:news_app/src/components/input_text/password_field.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/src/ui/sign_up/sign_up_info.dart';

class SignUpMailPass extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reEnterPasswordController =
      TextEditingController();
  SignUpMailPass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text("Sign up")),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: size.height * 0.4,
                width: size.width * 0.8,
                child: Image.asset(
                  "assets/images/sign_up.jpg",
                  fit: BoxFit.cover,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextInputField(
                text: "Enter your email",
                type: TextInputType.name,
                prefixIcon: const Icon(Icons.email),
                controller: _emailController),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PassWordField(
                hintText: "Enter your password",
                prefixIcon: const Icon(Icons.lock),
                passwordController: _passwordController),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PassWordField(
                hintText: "Re Enter your password",
                prefixIcon: const Icon(Icons.lock),
                passwordController: _reEnterPasswordController),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: BlocListener<SignUpBloc, SignUpState>(
              listener: (context, state) {
                switch (state.signUpStatus) {
                  case SignUpStatus.loading:
                    {
                      log("loading");
                    }
                    break;
                  case SignUpStatus.loaded:
                    {
                      log("loaded");
                      context.read<LogInBloc>().add(LogInSubmitEvent(
                          email: _emailController.text,
                          password: _passwordController.text));
                      Navigator.pushNamed(context, '/add_info', arguments: {
                        "email": _emailController.text,
                        "password": _passwordController.text
                      });
                    }
                    break;
                  case SignUpStatus.error:
                    {
                      //show Dialog
                    }
                    break;
                  default:
                    {
                      context.read<SignUpBloc>().add(SignUpEventInit());
                    }
                    break;
                }
              },
              child: InkWell(
                onTap: () {
                  context.read<SignUpBloc>().add(SignUpSubmitEvent(
                      email: _emailController.text,
                      password: _passwordController.text,
                      reEnterPassword: _reEnterPasswordController.text));
                },
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
            ),
          ),
        ]),
      ),
    );
  }
}

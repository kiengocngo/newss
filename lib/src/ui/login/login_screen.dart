import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/src/components/input_text/password_field.dart';
import 'package:news_app/src/components/input_text/text_field.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/tom.jpg"),
              ),
              TextInputField(
                prefixIcon: const Icon(Icons.email),
                type: TextInputType.emailAddress,
                text: "Enter your email",
                controller: _emailController,
              ),
              PassWordField(
                prefixIcon: const Icon(Icons.lock),
                hintText: "Enter your password",
                passwordController: _passwordController,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {},
                      child: const Text("Forgot your password?"))),
              Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/sign_up');
                      },
                      child: const Text("Dont have an account? Sign up here"))),
              Padding(
                padding: const EdgeInsets.all(8),
                child: BlocListener<LogInBloc, LogInState>(
                  listener: (context, state) {
                    switch (state.logInStatus) {
                      case LogInStatus.loading:
                        {
                          log("loading");
                        }
                        break;
                      case LogInStatus.loaded:
                        {
                          log("loaded");
                          Navigator.pushNamed(context, '/home');
                        }
                        break;
                      case LogInStatus.error:
                        {
                          log("error");
                        }
                        break;
                      default:
                        {
                          log("default");
                        }
                        break;
                    }
                  },
                  child: InkWell(
                    onTap: () {
                      context.read<LogInBloc>().add(LogInSubmitEvent(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                    child: Container(
                      width: size.width,
                      height: size.height * 0.05,
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
                        "Login",
                        style: TextStyle(fontSize: 23),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:news_app/src/components/input_text/password_field.dart';

import '../../../blocs/change_password_bloc/change_password_bloc.dart';

class PasswordScreen extends StatelessWidget {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  PasswordScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.25,
        title: Text(
          'change_pass'.tr,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
          listener: (context, state) {
            switch (state.status) {
              case ChangePasswordStatus.success:
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
                Navigator.pop(context);
                break;
              case ChangePasswordStatus.error:
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
                break;
              default:
                break;
            }
          },
          child: Column(children: [
            PassWordField(
                hintText: 'current_pass'.tr,
                prefixIcon: const Icon(Icons.lock),
                passwordController: currentPasswordController),
            PassWordField(
                hintText: 'new_pass'.tr,
                prefixIcon: const Icon(Icons.lock),
                passwordController: newPasswordController),
            PassWordField(
                hintText: 'confirm_pass'.tr,
                prefixIcon: const Icon(Icons.lock),
                passwordController: confirmPasswordController),
            InkWell(
              onTap: () {
                context.read<ChangePasswordBloc>().add(ChangePassword(
                    currentPassword: currentPasswordController.text,
                    newPassword: newPasswordController.text,
                    confirmPassword: confirmPasswordController.text));
                currentPasswordController.clear();
                newPasswordController.clear();
                confirmPasswordController.clear();
              },
              child: Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Center(
                  child: Container(
                    height: size.height * 0.07,
                    width: size.width * 0.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: [
                            Color(0xFF3366FF),
                            Color(0xFF00CCFF),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Center(
                      child: Text(
                        'submit_change'.tr,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

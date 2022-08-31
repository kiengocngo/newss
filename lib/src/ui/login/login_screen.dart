import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/log_in_bloc/log_in_bloc.dart';
import 'package:news_app/src/components/input_text/password_field.dart';
import 'package:news_app/src/components/input_text/text_field.dart';
import 'package:news_app/theme/news_theme_data.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        title: Text(
          "Login",
          style: NewsThemeData.fromContext(context).textAppBar,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        bottomOpacity: 0.0,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextInputField(
                prefixIcon: const Icon(Icons.email),
                type: TextInputType.emailAddress,
                text: "Enter your email",
                controller: _emailController,
              ),
              const SizedBox(
                height: 12,
              ),
              PassWordField(
                prefixIcon: const Icon(Icons.lock),
                hintText: "Enter your password",
                passwordController: _passwordController,
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot your password?",
                  style: NewsThemeData.fromContext(context).textAuth,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                child: Text(
                  "Dont have an account? Sign up here",
                  style: NewsThemeData.fromContext(context).textAuth,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: BlocListener<LogInBloc, LogInState>(
                  listener: (context, state) {
                    switch (state.logInStatus) {
                      case LogInStatus.loading:
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Logging in")));
                        break;
                      case LogInStatus.loaded:
                        Navigator.pushNamed(context, '/bottom');
                        break;
                      case LogInStatus.error:
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)));
                        break;
                      default:
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
                      height: 56,
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
                      child: Center(
                          child: Text(
                        "Login",
                        style: NewsThemeData.fromContext(context).textButton,
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

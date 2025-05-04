// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_weather_app/Features/Auth/Cubit/LoginCubit/login_cubit.dart';
import 'package:task_weather_app/Features/Auth/Cubit/LoginCubit/login_state.dart';
import 'package:task_weather_app/Features/Auth/View/Register_Screen.dart';
import 'package:task_weather_app/Features/home/View/Home.dart';
import 'package:task_weather_app/Widget/CustomBottom.dart';
import 'package:task_weather_app/Widget/Snackbar.dart';
import 'package:task_weather_app/Widget/customtextfiled.dart';

class Login_Page extends StatelessWidget {
  Login_Page({super.key});

  GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  String? username;

  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          Center(child: CircularProgressIndicator());
          showSnackbar(context, 'Loading login', Colors.grey);
        } else if (state is LoginSucces) {
          showSnackbar(context, 'Sucsses login', Colors.green);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return NotesHomePage();
              },
            ),https://github.com/Mohamed27112020/task_weather
          );
        } else if (state is LoginFailure) {
          showSnackbar(context, 'failure login ', Colors.red);
        } else {
          showSnackbar(context, 'Try again login ', Colors.deepOrange);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Container(
                  width: double.infinity,
                  height: 900,
                //  color: Colors.red,
                  alignment: Alignment.center,
                  child: Container(
                    width: 500,
                  //  color: Colors.blue,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "ABS.AI Notes ",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Welcome back! Please login to your account.',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 20),
                        customTextField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          hinttext: 'Username',
                          onchange: (data) {
                            username = data;
                          },
                        ),
                        SizedBox(height: 10),
                        customTextField(
                          controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          hinttext: 'Password',
                          onchange: (data) {
                            password = data;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomBottom(
                          color: Colors.blue,
                          ontap: () async {
                            if (formkey.currentState!.validate()) {
                              await BlocProvider.of<LoginCubit>(
                                context,
                              ).loginfun(
                                email: emailcontroller.text,
                                password: passwordcontroller.text,
                              );
                            }
                            passwordcontroller.clear();
                            emailcontroller.clear();
                          },
                          name: 'Login',
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Dont have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return RegisterPage();
                                    },
                                  ),
                                );
                              },
                              child: Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
